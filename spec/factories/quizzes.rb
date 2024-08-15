FactoryBot.define do
  factory :quiz do
    question       { "¿Cuál es el Pokémon número 25?" }
    user_answer    { "Pikachu" }
    correct_answer { "Pikachu" }
    points         { 0 }

    # Associations
    association :game, strategy: :create
  end
end
