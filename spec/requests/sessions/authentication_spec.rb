require 'rails_helper'

RSpec.describe 'Api::Authentication', type: :request do
  describe User do
    let(:user) { create(:user) }

    context 'when login as user' do
      it 'user should returns 200' do
        post api_signin_path, params: {
          user: {
            email: user.email,
            password: user.password
          }
        }

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when logout' do
      it 'response no content' do
        delete api_signout_path, params: {
          app_user: {
            email: user.email,
            password: user.password
          }
        }

        expect(response).to have_http_status(:no_content)
      end
    end
  end
end