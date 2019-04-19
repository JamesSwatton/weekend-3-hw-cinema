require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()


customer1 = Customer.new( {'name' => 'James', 'funds' => 20.00} )
customer2 = Customer.new( {'name' => 'Frank', 'funds' => 10.00} )
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

film1.title = 'Phantom Thread'
film1.update()

ticket1 = Ticket.new( {'customer_id' => customer1.id, 'film_id' => film3.id} )
ticket2 = Ticket.new( {'customer_id' => customer2.id, 'film_id' => film3.id} )
ticket3 = Ticket.new( {'customer_id' => customer3.id, 'film_id' => film1.id} )
ticket4 = Ticket.new( {'customer_id' => customer1.id, 'film_id' => film1.id} )

ticket1.save()
ticket2.save()
ticket3.save()


customer1.delete()
