class Screening

  attr_accessor :film_id, :show_time, :available_seats
  attr_reader :id, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @show_time = options['show_time']
    @capacity = options['capacity'].to_i
    @available_seats = @capacity
  end

  def save()
    sql = "INSERT INTO screenings (film_id, show_time, capacity, available_seats) VALUES ($1,$2,$3,$4) RETURNING id;"
    values = [@film_id, @show_time, @capacity, @available_seats]
    screenings = SqlRunner.run(sql, values)
    @id = screenings.first['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
          SET (film_id, show_time, capacity, available_seats) = ($1,$2,$3,$4)
          WHERE id = $5;"
    values = [@film_id, @show_time, @capacity, @available_seats, @id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(screening_data)
    results = screening_data.map { |screening| Screening.new(screening) }
  end
end
