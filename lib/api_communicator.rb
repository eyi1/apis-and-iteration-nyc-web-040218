require 'rest-client'
require 'json'
require 'pry'



# def get_input
#   puts "Give us a Star Wars Character"
#   gets.chomp
#
# end

def get_character_movies_from_api(character)
  #make the web request
  page = 1
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls,
  until page == 10
    all_characters = RestClient.get("https://swapi.co/api/people/?page=#{page}")
    character_hash = JSON.parse(all_characters)

    character_hash["results"].each do |value|
        if value["name"] == character
          films_hash = value["films"]
        end
    end
    page +=1
  end

end # get char

def parse_character_movies(films_hash)
  # binding.pry
  films_hash.each_with_index do |movie_url, index|
    calling = RestClient.get(movie_url)
    parsed_film = JSON.parse(calling)
    title = parsed_film["title"]
    puts "#{index+1}. #{title}"

  end

  # some iteration magic and puts out the movies in a nice list
end


def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end



  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

# films_hash = get_character_movies_from_api("Chewbacca")
# puts get_character_movies_from_api("Chewbacca")

# make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `parse_character_movies`

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
