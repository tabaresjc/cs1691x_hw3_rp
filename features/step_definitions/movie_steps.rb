# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    	# each returned element will be a hash whose key is the table header.
    	# you should arrange to add that movie to the database here.
	if movie then	
		movie = Movie.create!([movie])
	end
  end

end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
 	#  ensure that that e1 occurs before e2.
 	#  page.body is the entire content of the page as a string.
  	page.body.match(e1.to_s+'[\W\w]+'+e2.to_s)
end

# Make it easier to express checking or unchecking several rating boxes at once
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
	# HINT: use String#split to split up the rating_list, then
	#   iterate over the ratings and reuse the "When I check..." or
	#   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	rating_list.split(/,?\s+/).each do |rating|		
		if uncheck == nil then
			step("I check \"ratings_#{rating}\"")
		else
			step("I uncheck \"ratings_#{rating}\"")
		end
	end
end

# Given the list of rating, check if the movies appear or not
Then /I should (not )?see all of the movies: (.*)/ do |notsee, rating_list|
	if notsee then
		Movie.find_all_by_rating(rating_list.split(/,?\s+/)).count.should != page.all('table tbody tr').count
	else
		Movie.find_all_by_rating(rating_list.split(/,?\s+/)).count.should == page.all('table tbody tr').count
	end
	#movie_list = Movie.find_all_by_rating(rating_list.split(/,?\s+/))
	#movie_list.each do |movie|
	#	if notsee==nil then
	#		step("I should not see \"#{movie.title}\"")
	#	else
	#		step("I should see \"#{movie.title}\"")
	#	end
	#end
end

