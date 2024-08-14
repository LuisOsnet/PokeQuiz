require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # Validaciones de presencia
  it 'is invalid without a username' do
    binding.pry
    user.username = nil
    expect(user).not_to be_valid
    expect(user.errors[:username]).to include("can't be blank")
  end
  #
  # it 'is invalid without an email' do
  #   user.email = nil
  #   expect(user).not_to be_valid
  #   expect(user.errors[:email]).to include("can't be blank")
  # end
  #
  # # Validación de unicidad del correo electrónico
  # it 'is invalid with a duplicate email' do
  #   create(:user, email: 'unique@example.com')
  #   user.email = 'unique@example.com'
  #   expect(user).not_to be_valid
  #   expect(user.errors[:email]).to include('has already been taken')
  # end
  #
  # # Validación de formato del correo electrónico
  # it 'is invalid with an incorrectly formatted email' do
  #   user.email = 'invalidemail'
  #   expect(user).not_to be_valid
  #   expect(user.errors[:email]).to include('is invalid')
  # end
  #
  # # Validación de longitud de la contraseña
  # it 'is invalid with a password shorter than 6 characters' do
  #   user.password = 'short'
  #   expect(user).not_to be_valid
  #   expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
  # end
  #
  # it 'is invalid with a password longer than 128 characters' do
  #   user.password = 'a' * 129
  #   expect(user).not_to be_valid
  #   expect(user.errors[:password]).to include('is too long (maximum is 128 characters)')
  # end
  #
  # # Validación de longitud del nombre de usuario
  # it 'is invalid with a username shorter than 6 characters' do
  #   user.username = 'short'
  #   expect(user).not_to be_valid
  #   expect(user.errors[:username]).to include('is too short (minimum is 6 characters)')
  # end
  #
  # it 'is invalid with a username longer than 10 characters' do
  #   user.username = 'a' * 11
  #   expect(user).not_to be_valid
  #   expect(user.errors[:username]).to include('is too long (maximum is 10 characters)')
  # end
end
