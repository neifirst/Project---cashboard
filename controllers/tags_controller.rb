require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/tag.rb' )

get '/tags/index' do
  @tags = Tag.all
  erb ( :"tags/index" )
end

# get '/tag/new' do
#   @tag = Tag.all
#   erb(:"tag/new")
# end
#
# post '/tags' do
#   tag = Tag.new(params)
#   tag.save
#   redirect to("/tags")
# end
#
# post '/tag/:id/delete' do
#   Tag.destroy(params[:id])
#   redirect to("/tags")
# end
