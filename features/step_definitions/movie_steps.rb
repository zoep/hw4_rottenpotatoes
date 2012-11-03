# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end


Then /the director of "(.*)" should be "(.*)"/ do |mov, dir|
  movie = Movie.find_by_title(mov)
  assert_equal movie.director, dir
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.to_s.match /#{e1}(.*)#{e2}/m
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(/,/).each do |rating|
    
    if (uncheck)
      uncheck("ratings[#{rating}]")
    else
      check("ratings[#{rating}]")
    end
    # HINT: use String#split to split up the rating_list, then
    #   iterate over the ratings and reuse the "When I check..." or
    #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
    # click_button("ratings_submit")
  end
end 

Then /^(?:|I )should see all of the movies/ do
  numberOfRows = page.all('table tbody tr').size
  numberOfMovies = Movie.find(:all).count
  assert_equal numberOfMovies, numberOfRows
  #if page.respond_to? :should
  #  page.should have_css("table#movies tr", :count=>0)
  #else
  #  assert page.has_css?("table#movies tr", :count=>0)
  #end
end

Then /^(?:|I )should not see any movie/ do
  numberOfRows = page.all('table tbody tr').size
  assert_equal 0, numberOfRows
  #if page.respond_to? :should
  #  page.should have_css("table#movies tr", :count=>Movie.count)
  #else
  #  assert page.has_css?("table#movies tr", :count=>Movie.count)
  #end
end
