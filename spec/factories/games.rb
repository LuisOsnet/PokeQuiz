FactoryBot.define do
  factory :game do
    finished { false }
    score    { 0 }

    # Associations
    association :user, strategy: :create
  end
end
