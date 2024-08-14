require "rails_helper"

RSpec.describe Quizzes::GenerateQuestionsService, type: :service do
  let(:service) { described_class.new }

  describe "#call" do
    context "when everything works correctly" do
      let(:pokemon_data) do
        {
          "name" => "ditto",
          "flavor_text_entries" => [
            {"flavor_text" => "Puede alterar por completo su estructura celular para emular cualquier objeto que vea.", "language" => {"name" => "es"}}
          ]
        }
      end

      let(:pokemon_image_url) { "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png" }

      before do
        allow(service).to receive(:fetch_random_pokemon).and_return(pokemon_data)
        allow(service).to receive(:pokemon_image).with("ditto").and_return(pokemon_image_url)
        allow(service).to receive(:pokemon_collection).and_return(["ditto", "bulbasaur", "charmander", "squirtle"])
      end

      it "returns a hash with the question, answer options, correct answer, and pokemon image url" do
        result = service.call

        expect(result).to include(
          question: "Puede alterar por completo su estructura celular para emular cualquier objeto que vea.",
          answer_options: a_collection_containing_exactly("bulbasaur", "ditto", "charmander", "squirtle"),
          correct_answer: "ditto",
          pokemon_image_url: pokemon_image_url
        )
      end
    end

    context "when there is an error fetching Pokémon data" do
      before do
        allow(service).to receive(:fetch_random_pokemon).and_raise("Error fetching Pokémon data")
      end

      it "returns an error hash" do
        result = service.call
        expect(result).to include(error: "Error fetching Pokémon data")
      end
    end

    context "when there is an error generating the question" do
      let(:pokemon_data) do
        {
          "name" => "ditto",
          "flavor_text_entries" => []
        }
      end

      before do
        allow(service).to receive(:fetch_random_pokemon).and_return(pokemon_data)
      end

      it "returns an error hash" do
        result = service.call
        expect(result).to include(error: "Error generating question: Flavor text not found for Pokémon 'ditto' in locale '#{I18n.locale}'")
      end
    end

    context "when there are not enough Pokémon to generate answer options" do
      before do
        allow(service).to receive(:pokemon_collection).and_return(["ditto"])
        allow(service).to receive(:fetch_random_pokemon).and_return({"name" => "ditto"})
      end

      it "returns an error hash" do
        result = service.call
        expect(result).to include(error: "Error generating question: undefined method `find' for nil")
      end
    end

    context "when there is an error fetching Pokémon collection" do
      before do
        allow(service).to receive(:pokemon_collection).and_raise("Error fetching Pokémon collection")
      end

      it "returns an error hash" do
        result = service.call
        expect(result).to include(error: "Error generating answer options: Error fetching Pokémon collection")
      end
    end

    context "when there is an error fetching Pokémon image" do
      before do
        allow(service).to receive(:pokemon_image).and_raise("Error fetching Pokémon image")
      end

      it "returns an error hash" do
        result = service.call
        expect(result).to include(error: "Error fetching Pokémon image")
      end
    end
  end
end
