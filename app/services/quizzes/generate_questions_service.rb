module Quizzes
  class GenerateQuestionsService
    POKEAPI_URL = "https://pokeapi.co/api/v2/".freeze
    POKEMONS_LIMIT = 151

    def call
      begin
        random_pokemon = fetch_random_pokemon

        {
          question: generate_question(random_pokemon),
          answer_options: generate_answer_options(random_pokemon['name']),
          correct_answer: random_pokemon['name'],
          pokemon_image_url: pokemon_image(random_pokemon['name'])
        }
      rescue StandardError => e
        handle_error(e)
      end
    end

    private

    def fetch_random_pokemon
      pokemon_id = rand(1..POKEMONS_LIMIT)
      url = URI("#{POKEAPI_URL}pokemon-species/#{pokemon_id}")
      response = Net::HTTP.get(url)
      JSON.parse(response)
    rescue JSON::ParserError
      raise "Error parsing JSON response from Pokémon API"
    rescue StandardError => e
      raise "Error fetching Pokémon data: #{e.message}"
    end

    def generate_question(pokemon)
      name = pokemon['name']
      flavor_text_entries = pokemon['flavor_text_entries']
      flavor_text = flavor_text_entries.find { |entry| entry['language']['name'] == I18n.locale.to_s }

      if flavor_text
        flavor_text['flavor_text'].gsub(name.capitalize, '...')
      else
        raise "Flavor text not found for Pokémon '#{name}' in locale '#{I18n.locale}'"
      end
    rescue StandardError => e
      raise "Error generating question: #{e.message}"
    end

    def generate_answer_options(correct_answer)
      options = pokemon_collection
      options.delete(correct_answer)

      if options.size < 3
        raise "Not enough Pokémon to generate answer options"
      end

      options.sample(3).push(correct_answer).shuffle
    rescue StandardError => e
      raise "Error generating answer options: #{e.message}"
    end

    def pokemon_collection
      url = URI("#{POKEAPI_URL}pokemon?limit=#{POKEMONS_LIMIT}")
      response = Net::HTTP.get(url)
      JSON.parse(response)['results'].map { |pokemon| pokemon['name'] }
    rescue JSON::ParserError
      raise "Error parsing JSON response from Pokémon collection API"
    rescue StandardError => e
      raise "Error fetching Pokémon collection: #{e.message}"
    end

    def pokemon_image(pokemon_name)
      url = URI("#{POKEAPI_URL}pokemon/#{pokemon_name}")
      data = JSON.parse(Net::HTTP.get(url))
      data.dig('sprites', 'other', 'official-artwork', 'front_default')
    rescue JSON::ParserError
      raise "Error parsing JSON response from Pokémon image API"
    rescue StandardError => e
      raise "Error fetching Pokémon image: #{e.message}"
    end

    def handle_error(error)
      puts "An error occurred: #{error.message}"
      { error: error.message }
    end
  end
end
