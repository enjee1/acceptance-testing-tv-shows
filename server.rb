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
  @error_message = "Please fill in all required fields"
  erb :new
end

post "/television_shows" do
  show_details = params.values

  if show_details.any? { |field| field == "" }
    redirect "/television_shows/new"
  end

  CSV.open("television-shows.csv", "a") do |file|
    file << show_details
  end

  redirect "/television_shows"
end
