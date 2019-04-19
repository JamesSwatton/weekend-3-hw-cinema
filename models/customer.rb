require_relative('../db/sql_runner')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
          VALUES ($1, $2)
          RETURNING id;"
    values = [@name, @funds]
    customers = SqlRunner.run(sql, values)
    @id = customers.first['id'].to_i
  end

  def update()
    sql = "UPDATE customers
          SET (name, funds) = ($1, $2)
          WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT * FROM films
          INNER JOIN tickets
          ON tickets.film_id = films.id
          WHERE customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def self.map_items(customer_data)
    results = customer_data.map { |customer| Customer.new(customer) }
  end

end
