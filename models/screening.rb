class Screening

  attr_accessor :film_id, :show_time
  attr_reader :id, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @show_time = options['show_time']
    @capacity = options['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (film_id, show_time, capacity) VALUES ($1,$2,$3) RETURNING id;"
    values = [@film_id, @show_time, @capacity]
    screenings = SqlRunner.run(sql, values)
    @id = screenings.first['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
          SET (film_id, show_time, capacity) = ($1,$2,$3)
          WHERE id = $4;"
    values = [@film_id, @show_time, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def has_available_seats?()
    sql = "SELECT *
          FROM tickets
          WHERE screening_id = $1;"
    values = [@id]
    num_of_tickets_sold = SqlRunner.run(sql, values)
    return num_of_tickets_sold.count < @capacity
  end

  def num_of_available_seats()
    sql = "SELECT *
          FROM tickets
          WHERE screening_id = $1;"
    values = [@id]
    num_of_tickets_sold = SqlRunner.run(sql, values)
    return @capacity -  num_of_tickets_sold.count
  end

  def self.map_items(screening_data)
    results = screening_data.map { |screening| Screening.new(screening) }
  end
end
