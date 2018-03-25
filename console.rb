require_relative('models/customer')
require_relative('models/films')
require_relative('models/tickets')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({'name' => 'Peter Stevenson', 'funds' => '13'})
customer2 = Customer.new({'name' => 'Nicholas Johnson', 'funds' => '3'})
customer3 = Customer.new({'name' => 'Andrea Jacobs', 'funds' => '10'})
customer4 = Customer.new({'name' => 'Carla Pentone', 'funds' => '16'})

customers = [customer1, customer2, customer3, customer4]
customers.each {|customer| customer.save}
# customer1.save()
#
film1 = Film.new({'title' => 'The Movie', 'price' => '3'})
film2 = Film.new({'title' => 'The Fridge', 'price' => '2'})
film3 = Film.new({'title' => 'The Banana', 'price' => '1'})
film4 = Film.new({'title' => 'The Garage', 'price' => '3'})

films = [film1, film2, film3, film4]
films.each{|film| film.save}

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film3.id})
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film4.id})

tickets = [ticket1, ticket2, ticket3, ticket4]
tickets.each{|ticket| ticket.save}

customer1.name = "The Rock"
customer1.funds = "11"
customer1.update()

film1.title = "The Orange"
film1.price = "1"
film1.update()

ticket1.customer_id = customer2.id
ticket1.film_id = film2.id
ticket1.update

ticket3.delete()
customer3.delete()
film3.delete()

Customer.view_all()
