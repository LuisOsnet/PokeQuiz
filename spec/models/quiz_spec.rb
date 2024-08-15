require "rails_helper"

RSpec.describe Quiz, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:game) }
  end

  describe "Database columns" do
    it { is_expected.to have_db_column(:game_id).of_type(:integer) }
    it { is_expected.to have_db_column(:question).of_type(:string) }
    it { is_expected.to have_db_column(:user_answer).of_type(:string) }
    it { is_expected.to have_db_column(:correct_answer).of_type(:string) }
    it { is_expected.to have_db_column(:points).of_type(:integer) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end
end
