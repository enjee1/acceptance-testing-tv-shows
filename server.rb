require 'sinatra'
require 'csv'
require_relative "app/models/television_show"

set :bind, '0.0.0.0'  # bind to all interfaces
set :views, File.join(File.dirname(__FILE__), "app/views")

get "/television_shows" do
  @tv_shows = CSV.readlines("television-shows.csv", headers: true)
  erb :index
end

get "/television_shows/new" do
  @genres = TelevisionShow::GENRES
  erb :new
end

post "/television_shows" do
  @genres = TelevisionShow::GENRES

  duplicate_found = dupe_exists(params)
  if params.values.any? { |field| field == "" }
    @error_message = "Please fill in all required fields"
    erb :new
  elsif duplicate_found
    @error_message = "The show has already been added"
    erb :new
  else
    CSV.open("television-shows.csv", "a") do |file|
      file << params.values
    end
    redirect "/television_shows"
  end
end

def dupe_exists(tv_show)
  duplicate_found = false
  CSV.foreach("television-shows.csv", headers: true) do |row|
      if row["title"] == tv_show["title"]
          duplicate_found = true
          break
      end
  end
  duplicate_found
end
