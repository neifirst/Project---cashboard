require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/tag.rb' )

# index

get '/tags/index' do
  @tags = Tag.all
  erb ( :"tags/index" )
end

# show

get "/tags/:id" do
  @transactions = Tag.find(params[:id]).get_transactions()
  erb(:"tags/show")
end
