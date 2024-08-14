require "rails_helper"

RSpec.describe Quizzes::CreationService, type: :service do
  let(:game) { create(:game) }
  let(:user_answer) { "Pikachu" }
  let(:correct_answer) { "Pikachu" }
  let(:question) { "¿Cuál es el Pokémon número 25?" }

  subject { described_class.new(game.id, user_answer, correct_answer, question) }

  describe "#call" do
    context "when the quiz is saved successfully" do
      it "creates a new quiz associated with the game" do
        expect {
          subject.call
        }.to change(game.quizzes, :count).by(1)
      end

      it "assigns 1 point if the user_answer matches the correct_answer" do
        subject.call
        quiz = game.quizzes.last
        expect(quiz.points).to eq(1)
      end

      it "returns true" do
        expect(subject.call).to be_truthy
      end
    end

    context "when the quiz fails to save" do
      before do
        allow_any_instance_of(Quiz).to receive(:save).and_return(false)
      end

      it "does not create a new quiz" do
        expect {
          subject.call
        }.not_to change(game.quizzes, :count)
      end

      it "returns false" do
        expect(subject.call).to be_falsey
      end
    end

    context "when an exception occurs" do
      before do
        allow(Game).to receive(:find_by).and_raise(StandardError, "Something went wrong")
      end

      it "logs an error and returns false" do
        expect(Rails.logger).to receive(:error).with("Failed to save quiz: Something went wrong")
        expect(subject.call).to be_falsey
      end
    end
  end
end
