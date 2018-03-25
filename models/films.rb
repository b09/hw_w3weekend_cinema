class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "
    INSERT INTO films ( title, price) VALUES ($1, $2) RETURNING id
    "
    values = [@title, @price]
    array_hash_id = SqlRunner.run(sql, values)
    @id = array_hash_id.first['id'].to_i
  end

  def update
    sql = "
    UPDATE films SET (title, price) = ($1, $2) WHERE id = $3
    "
    values = [@title, @price, @id]
    array_hash_id = SqlRunner.run(sql, values)
  end

  def delete
    sql = "
    DELETE FROM customers WHERE id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.view_all
    sql = "
    SELECT * FROM customers
    "
    hash = SqlRunner.run(sql)
    customer_array = hash.map { |customer| Customer.new(customer) }
    return customer_array
  end

  def self.delete_all
    sql = "
    DELETE FROM customers
    "
    SqlRunner.run(sql)
  end

end
