require 'sinatra'
require 'csv'
require 'pry'

def get_movies

  all_movies = []

  CSV.foreach('movies.csv', headers: true, header_converters: :symbol) do |row|
    all_movies << row.to_hash
  end

  # sorry array by title
  all_movies = all_movies.sort_by { |row| row[:title] }

end

# get '/movies' do

#   @movies = get_movies

#   erb :index

# end

get '/movies/:id' do

  @movies = get_movies

  @movies = @movies.find do |m|
    m[:id] == params[:id]
  end

  erb :movie

end

get '/movies' do

  @movies = get_movies
  @page = params[:page]
  @prev_p = @page.to_i - 20
  @next_p = @page.to_i + 20

  index = 1 * @page.to_i

  @movies = @movies.slice(index,20)

  erb :index
end


