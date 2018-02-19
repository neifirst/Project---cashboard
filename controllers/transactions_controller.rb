require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction.rb')
require_relative( '../models/tag.rb')

# index

get '/transactions/index' do
  @transactions = Transaction.all()
  erb ( :"transactions/index" )
end

# create

post "/transactions/index" do
  @transaction = Transaction.new(params)
  @transaction.save
  redirect to "/transactions/new"
end

# new

get '/transactions/new' do
  @transactions = Transaction.all
  @tags = Tag.all
  erb(:"transactions/new")
end

# show

get "/transactions/:id" do
  @transaction = Transaction.find(params['id'])
  erb(:"transactions/show")
end

# # edit
#
# get "/pizza-orders/:id/edit" do
#   @order = PizzaOrder.find(params[:id])
#   @toppings = ["Margherita", "Vegetarian", "Italian Sausage", "Pepperoni"]
#   erb(:edit)
# end
#
# # update
#
# post "/pizza-orders/:id" do
#   order = PizzaOrder.new(params)
#   order.update()
#   redirect to "/pizza-orders"
# end

# destroy

post "/transactions/:id/delete" do
  @transaction = Transaction.delete(params[:id])
  redirect to "/transactions/index"
end
