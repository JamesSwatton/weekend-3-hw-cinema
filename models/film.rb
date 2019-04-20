require_relative('../db/sql_runner')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1,$2) RETURNING id;"
    values = [@title, @price]
    films = SqlRunner.run(sql, values)
    @id = films.first['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT * FROM customers
          INNER JOIN tickets
          ON tickets.customer_id = customers.id
          WHERE film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return Customer.map_items(customers)
  end

  def num_of_customers()
    return customers().count
  end

  def most_popular_screening()
    sql = "SELECT show_time
          FROM screenings
          INNER JOIN tickets
          ON screenings.id = tickets.screening_id
          WHERE screenings.film_id = $1;"
    values = [@id]
    screenings = Screening.map_items(SqlRunner.run(sql, values))
    show_times = screenings.map { |screening| screening.show_time }
    uniq_times = show_times.uniq
    return uniq_times.sort_by { |time| show_times.count(time) }.pop
  end


  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def self.map_items(film_data)
    results = film_data.map { |film| Film.new(film) }
  end

end
