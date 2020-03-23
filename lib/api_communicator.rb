require 'rest-client'
require 'json'
require 'pry'

def get_character_movie_urls_from_api(character_name)
  films = []
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  found = response_hash["results"].select do |result| 
      result["name"] == character_name
  end
  found = found[0]["films"]
end

def parse_urls(string)
  string.map do |url|
    bad_strings = RestClient.get(url)
    JSON.parse(bad_strings)
  end
end

def print_movies(films)
  titles = films.map do |films|
    films["title"]
  end
  puts titles
end

def show_character_movies(character)
  urls = get_character_movie_urls_from_api(character)
  strings = parse_urls(urls)
  print_movies(strings)
end