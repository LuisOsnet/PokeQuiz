require "rails_helper"

RSpec.describe "Api::Registrations", type: :request do
  describe "POST /api/registrations" do
    let(:valid_params) do
      {
        user: {
          username: Faker::Internet.username(specifier: 6..10),
          email: Faker::Internet.email,
          password: Faker::Internet.password(min_length: 6, max_length: 128)
        }
      }
    end

    let(:invalid_params) do
      {
        user: {
          username: Faker::Internet.username(specifier: 6..10),
          email: "invalid-email",
          password: Faker::Internet.password(min_length: 6, max_length: 128)
        }
      }
    end

    context "when registration is successful" do
      it "creates a new user and returns a created status" do
        post api_signup_path, params: valid_params, as: :json

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include(
          {
            "user" => {
              "username" => valid_params[:user][:username],
              "email" => valid_params[:user][:email]
            }
          }
        )
      end
    end

    context "when registration fails" do
      before do
        allow_any_instance_of(User).to receive(:save!).and_raise(StandardError, "Registration failed")
      end

      it "returns a bad request status with error message" do
        post api_signup_path, params: invalid_params, as: :json

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include(
          "error" => {
            "code" => 400,
            "status" => "bad_request",
            "resource" => "registrations",
            "message" => "El servidor no puede o no procesará la solicitud debido a algo que se percibe como un error del cliente",
            "details" => "Registration failed"
          }
        )
      end
    end
  end
end
