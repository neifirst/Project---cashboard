require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/tag.rb' )

# budget index

get '/budget/index' do
  @tags = Tag.all
  erb ( :"budget/index" )
end

#  edit

get "/budget/:id/edit" do
  @tag = Tag.find(params[:id])
  @tag_name = Tag.find(params[:id]).name()
  erb(:"budget/edit")
end

# update

post "/budget/:id" do
  tag = Tag.new(params)
  tag.update()
  redirect to "/budget/index"
end
