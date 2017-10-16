require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should successfully save when first name and last name are provided, email is provided and unique, and password and password confirmation are provided and match' do
      @user = User.new({first_name: 'Alex', last_name: 'Jones', email: 'alex@jones.com', password: 'password', password_confirmation: 'password'})
      
      expect(@user).to be_valid
    end



    it 'should not save user if pw and pw-confirmation are not provided' do
      @user = User.new({first_name: 'Alex', last_name: 'Jones', email: 'alex@jones.com'})
      
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password]).to include("can't be blank")
    end

    it 'should not save user if pw and pw-confirmation do not match' do
      @user = User.new({first_name: 'Alex', last_name: 'Jones', email: 'alex@jones.com', password: 'password', password_confirmation: 'pass'})
      
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should not save user if pw is <5 characters' do
      @user = User.new({first_name: 'Alex', last_name: 'Jones', email: 'alex@jones.com', password: 'pass', password_confirmation: 'pass'})

      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password]).to include("is too short (minimum is 5 characters)")
    end



    it 'should not save user if email is in use' do
      @user1 = User.create({first_name: 'Alex', last_name: 'Jones', email: 'alex@jones.com', password: 'password', password_confirmation: 'password'})
      @user2 = User.new({first_name: 'Alex', last_name: 'Jones', email: 'alex@jones.com', password: 'password', password_confirmation: 'password'})
      
      expect(@user2).to_not be_valid
      expect(@user2.errors.messages[:email]).to include("has already been taken")
    end

    it 'should not save user if no email provided' do
      @user = User.new({first_name: 'Alex', last_name: 'Jones', password: 'password', password_confirmation: 'password'})

      expect(@user).to_not be_valid
      expect(@user.errors.messages[:email]).to include("can't be blank")
    end



    it 'should not save user if no first name provided' do
      @user = User.new({last_name: 'Jones', email: 'alex@jones.com', password: 'password', password_confirmation: 'password'})
      
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:first_name]).to include("can't be blank")
    end

    it 'should not save user if no last name provided' do
      @user = User.new({first_name: 'Alex', email: 'alex@jones.com', password: 'password', password_confirmation: 'password'})
      
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:last_name]).to include("can't be blank")
    end

    describe '.authenticate_with_credentials' do
      it 'should return an instance of the user if good credentials' do
        User.create({
          first_name: 'Alex',
          last_name: 'Jones',
          email: 'alex@jones.com',
          password: 'password',
          password_confirmation: 'password'
        })

        @user = User.authenticate_with_credentials('alex@jones.com', 'password')

        expect(@user).to have_attributes(email: "alex@jones.com")
      end

      it 'return nil if bad credentials' do
        @user = User.authenticate_with_credentials('hey@hey.com', 'hello')

        expect(@user).to be_nil
      end
    end
  end
end
