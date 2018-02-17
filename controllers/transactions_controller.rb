require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction.rb')
require_relative( '../models/tag.rb')

get '/transactions/index' do
  @transactions = Transaction.all()
  erb ( :"transactions/index" )
end

post "/transactions/index" do
  @transaction = Transaction.new(params)
  @transaction.save
  redirect to "/transactions/new"
end

# get '/transactions/:id' do
#   @transaction = Transaction.find(params['id'].to_i)
#   erb( :"Transactions/show" )
# end

get '/transactions/new' do
  @transactions = Transaction.all
  @tags = Tag.all
  erb(:"transactions/new")
end
