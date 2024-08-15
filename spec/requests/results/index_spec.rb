require "rails_helper"

RSpec.describe "Api::Results", type: :request do
  let!(:user) { create(:user) }
  let!(:game) { create(:game, user: user) }
  let!(:quiz) { create(:quiz, game: game) }

  describe "GET /api/results" do
    before { sign_in user }

    context 'when the request is successful' do
      before { get api_results_path }

      it 'returns a successful response' do
        get api_results_path
        expect(response).to have_http_status(:ok)
      end


      it 'returns the correct JSON structure' do
        json_response = JSON.parse(response.body)
        expect(json_response['data']).to be_an(Array)
        expect(json_response['data'].first['id']).to eq(user.id)
        expect(json_response['data'].first['username']).to eq(user.username)
        expect(json_response['data'].first['games']).to be_an(Array)
        expect(json_response['data'].first['games'].first['id']).to eq(game.id)
        expect(json_response['data'].first['games'].first['score']).to eq(game.score)
        expect(json_response['data'].first['games'].first['finished']).to eq(game.finished)
        expect(json_response['data'].first['games'].first['quizzes']).to be_an(Array)
        expect(json_response['data'].first['games'].first['quizzes'].first['id']).to eq(quiz.id)
        expect(json_response['data'].first['games'].first['quizzes'].first['question']).to eq(quiz.question)
        expect(json_response['data'].first['games'].first['quizzes'].first['correct_answer']).to eq(quiz.correct_answer)
        expect(json_response['data'].first['games'].first['quizzes'].first['user_answer']).to eq(quiz.user_answer)
      end
    end
  end
end
