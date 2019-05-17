require 'spec_helper'

# As an organized TV fanatic
# I want to receive an error message if I try to add the same show twice
# So that I don't have duplicate entries

# Acceptance Criteria:
# [X] If the title is the same as a show that I've already added, the details are not saved to the csv
# [X] If the title is the same as a show that I've already added, I will be shown an error that says "The show has already been added".
# [X] If the details of the show are not saved, I will remain on the new form page

feature "user adds a TV show" do

  scenario "TV show already exists in the television_shows.csv file" do
    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Add TV Show"

    visit "/television_shows/new"

    fill_in "Title", with: "Friends"
    fill_in "Network", with: "NBC"
    fill_in "Starting Year", with: "1994"
    fill_in "Synopsis", with: "Six friends living in New York city."
    select "Comedy", from: "Genre"

    click_button "Add TV Show"

    expect(page).to have_content("The show has already been added")
  end

end
