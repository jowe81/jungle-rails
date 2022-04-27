require 'rails_helper'

RSpec.describe User, type: :model do


  describe "Validations" do

    before(:each) do
      @valid_test_record = {
        :name => "Bob",
        :email => "bob@gmail.com",
        :password => "password",
        :password_confirmation => "password"
      }
    end

    context "When attempting to generate a user" do

      it "succeeds with a valid record" do
        User.create(@valid_test_record)
        existing_user = User.find_by(email: "bob@gmail.com")
        expect(existing_user.email).to eq("bob@gmail.com")
      end

      it "stores the email in lower case" do
        @valid_test_record[:email] = "BOB@gMaIl.com"
        User.create(@valid_test_record)
        existing_user = User.find_by(email: "bob@gmail.com")
        expect(existing_user.email).to eq("bob@gmail.com")
      end

      it "fails if no email is provided" do
        @valid_test_record.delete(:email)
        user = User.new(@valid_test_record)
        expect(user.save).to eq(false)
      end

      it "fails if no name is provided" do
        @valid_test_record.delete(:name)
        user = User.new(@valid_test_record)
        expect(user.save).to eq(false)
      end

      it "fails if no password is provided" do
        @valid_test_record.delete(:password)
        @valid_test_record.delete(:password_confirmation)
        user = User.new(@valid_test_record)
        expect(user.save).to eq(false)
      end

      it "fails when passwords do not match" do
        user = User.new(@valid_test_record)
        user.password_confirmation = "different"
        expect(user.save).to eq(false)
      end

      it "fails when the password is shorter than 8 characters" do
        @valid_test_record[:password] = "tooshrt"
        @valid_test_record[:password_confirmation] = "tooshrt"
        user = User.new(@valid_test_record)
        expect(user.save).to eq(false)
      end

      it "fails if the email already exists (case-insensitive)" do
        User.create(@valid_test_record)

        @valid_test_record[:email] = "BOB@gmail.com"
        new_user = User.new(@valid_test_record)
        expect(new_user.save).to eq(false)        
      end

    end


    describe ".authenticate_with_credentials" do

      before do
        User.create(@valid_test_record)
        existing_user = User.find_by(email: "bob@gmail.com")
        expect(existing_user.email).to eq("bob@gmail.com")
      end

      it "returns a user when given an existing email and valid password" do
        result = User.authenticate_with_credentials("bob@gmail.com", "password")
        expect(result).to be_a(User)         
      end

      it "returns nil when given an invalid email/password combination" do
        result = User.authenticate_with_credentials("bob@gmail.com", "wrong")
        expect(result).to eq(nil)         
      end

      it "returns nil when given a valid email but no password" do
        result = User.authenticate_with_credentials("bob@gmail.com", "")
        expect(result).to eq(nil)         
      end

      it "returns nil when given a neither an email nor a password" do
        result = User.authenticate_with_credentials("", "")
        expect(result).to eq(nil)         
      end

      it "successfully authenticates when email is surrounded by whitespace" do
        result = User.authenticate_with_credentials("    bob@gmail.com ", "password")
        expect(result).to be_a(User)         
      end

      it "successfully authenticates when email is is provided in a different case" do
        result = User.authenticate_with_credentials("bOb@gMaIL.com", "password")
        expect(result).to be_a(User)         
      end

    end

  end

end
