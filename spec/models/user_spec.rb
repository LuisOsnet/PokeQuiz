require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is invalid without a username" do
    user.username = nil
    expect(user).not_to be_valid
    expect(user.errors[:username]).to include("El username no puede estar vacío.")
  end
  it "is invalid without an email" do
    user.email = nil
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("El correo electrónico no puede estar vacío.")
  end

  it "is invalid with a duplicate email" do
    create(:user, email: "unique@example.com")
    user.email = "unique@example.com"
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("Correo electrónico ya está en uso")
  end

  it "is invalid with an incorrectly formatted email" do
    user.email = "invalidemail"
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("Correo electrónico inválido")
  end

  it "is invalid with a password shorter than 6 characters" do
    user.password = "short"
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("La contraseña debe tener un mínimo de 6 caracteres.")
  end

  it "is invalid with a password longer than 128 characters" do
    user.password = "a" * 129
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("La contraseña debe tener un máximo de 128 caracteres.")
  end

  it "is invalid with a username shorter than 6 characters" do
    user.username = "short"
    expect(user).not_to be_valid
    expect(user.errors[:username]).to include("El Nombre de usuario debe tener un mínimo de 6 caracteres.")
  end

  it "is invalid with a username longer than 10 characters" do
    user.username = "a" * 11
    expect(user).not_to be_valid
    expect(user.errors[:username]).to include("El Nombre de usuario debe tener un máximo de 10 caracteres.")
  end

  describe "Database columns" do
    it { is_expected.to have_db_column(:username).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:email).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe "Database indexes" do
    it { is_expected.to have_db_index(:username).unique(true) }
    it { is_expected.to have_db_index(:email).unique(true) }
  end

  describe "Associations" do
    it { is_expected.to have_many(:games).dependent(:destroy) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }

    describe "Uniqueness" do
      subject { create(:user) }

      it { is_expected.to validate_uniqueness_of(:username) }
      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end
  end
end
