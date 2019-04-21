require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')
require_relative('./models/screening')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()


customer1 = Customer.new( {'name' => 'James', 'funds' => 20.00} )
customer2 = Customer.new( {'name' => 'Frank', 'funds' => 15.00} )
customer3 = Customer.new( {'name' => 'Ralph', 'funds' => 5.00} )

customer1.save()
customer2.save()
customer3.save()



film1 = Film.new( {'title' => 'There Will Be Blood', 'price' => 5.00} )
film2 = Film.new( {'title' => 'The Master', 'price' => 5.00} )
film3 = Film.new( {'title' => 'Boogie Nights', 'price' => 5.00} )

film1.save()
film2.save()
film3.save()

# film1.title = 'Phantom Thread'
# film1.update()

screening1 = Screening.new( {'film_id' => film1.id, 'show_time' => '18:00', 'capacity' => 5})
screening2 = Screening.new( {'film_id' => film3.id, 'show_time' => '21:00', 'capacity' => 2})
screening3 = Screening.new( {'film_id' => film3.id, 'show_time' => '23:00', 'capacity' => 5})

screening1.save()
screening2.save()
screening3.save()

ticket1 = Ticket.new( {'customer_id' => customer1.id, 'film_id' => film3.id, 'screening_id' => screening2.id} )
ticket2 = Ticket.new( {'customer_id' => customer2.id, 'film_id' => film3.id, 'screening_id' => screening2.id} )
ticket3 = Ticket.new( {'customer_id' => customer3.id, 'film_id' => film3.id, 'screening_id' => screening2.id} )
# ticket4 = Ticket.new( {'customer_id' => customer1.id, 'film_id' => film1.id} )

ticket1.save()
ticket2.save()
ticket3.save()
# ticket4.save()

# p customer1.films()
# p film3.customers()
# customer1.delete()

# p customer1.buy_ticket(film3, screening3)

p screening2.has_available_seats?()
p screening2.num_of_available_seats()

# p film3.most_popular_screening()

# p customer1.num_of_tickets()

# p film3.num_of_customers()
