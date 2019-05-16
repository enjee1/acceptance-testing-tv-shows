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
  show_details = params.values
  CSV.foreach("television-shows.csv", headers: true) do |row|
    show_details.each do |field|
      
    end
  end

  if show_details.any? { |field| field == "" }
    @error_message = "Please fill in all required fields"
    erb :new
  # elsif show_list.include?(show_details.each { |detail| detail.to_s } )
  #   @error_message = "The show has already been added"
  #   erb :new
  else
    CSV.open("television-shows.csv", "a") do |file|
      file << show_details
    end
    redirect "/television_shows"
  end
end
