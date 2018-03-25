require_relative('../db/runner')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_i
    @id = options['id'].to_i
  end

  def save
    sql = "
    INSERT INTO customers ( name, funds) VALUES ($1, $2) RETURNING id
    "
    values = [@name, @funds]
    array_hash_id = SqlRunner.run(sql, values)
    @id = array_hash_id.first['id'].to_i
  end

  def update
    sql = "
    UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3
    "
    values = [@name, @funds, @id]
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
