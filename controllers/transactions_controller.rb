require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('date')
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

get "/transactions/by_month/:month" do
  @transactions = Transaction.get_by_month(params[:month])
  @monthname = Date::MONTHNAMES[params[:month].to_i]
  erb(:"transactions/show")
end

#  edit

get "/transactions/:id/edit" do
  @transaction = Transaction.find(params[:id])
  @tags = Tag.all
  erb(:"transactions/edit")
end

# update

post "/transactions/:id" do
  transaction = Transaction.new(params)
  transaction.update()
  redirect to "/transactions/index"
end

# destroy

post "/transactions/:id/delete" do
  Transaction.find(params[:id]).delete()
  redirect to "/transactions/index"
end
