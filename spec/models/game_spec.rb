require "rails_helper"

RSpec.describe Game, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:quizzes).dependent(:destroy) }
  end

  describe "Database columns" do
    it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    it { is_expected.to have_db_column(:finished).of_type(:boolean) }
    it { is_expected.to have_db_column(:score).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
