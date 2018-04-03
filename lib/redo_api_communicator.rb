
require 'rest-client'
require 'json'
require 'pry'



def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get("https://www.swapi.co/api/people/?page=1")
  character_hash = JSON.parse(all_characters)
  # binding.pry

  loop do
    character_hash["results"].each do |info|
      # binding.pry
      if info["name"] == character
        return info["films"]
      end
    end
    next_page = RestClient.get(character_hash["next"])
    character_hash = JSON.parse(next_page)

    break if character_hash["next"] == "null" ||  character_hash["next"] == nil
    end
end

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

# films_hash = get_character_movies_from_api("BB8")
# puts get_character_movies_from_api("R5-D4")

def parse_character_movies(films_hash)
  # binding.pry
  films_hash.each_with_index do |movie_url, num|
    get_movie_info = RestClient.get(movie_url)
    movie_info = JSON.parse(get_movie_info)
    title = movie_info["title"]
    puts "#{num+1}. #{title}"
  end

end

# parse_character_movies(films_hash)
# films_hash = get_character_movies_from_api("Anakin Skywalker")
# #
# parse_character_movies(films_hash)
#
def show_character_movies(character)
  films_hash = get_character_movies_from_api(character) #returns films list/url
  parse_character_movies(films_hash)
end


puts "enter character"
input = gets.chomp

show_character_movies(input)
## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
