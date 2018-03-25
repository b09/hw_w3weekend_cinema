class Ticket

  attr_accessor :id, :customer_id, :film_id

  def initialize(options)
    @customer_id = options['customer_id']
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i
  end

  def save
    sql = "
    INSERT INTO tickets ( customer_id, film_id) VALUES ($1, $2) RETURNING id
    "
    values = [@customer_id, @film_id]
    array_hash_id = SqlRunner.run(sql, values)
    @id = array_hash_id.first['id'].to_i
  end

  def update
    sql = "
    UPDATE tickets SET (customer_id, film_id) = ($1, $2) WHERE id = $3
    "
    values = [@customer_id, @film_id, @id]
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
