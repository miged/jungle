require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before :each do
      User.create({
        first_name: 'John',
        last_name: 'Doe',
        email: 'johnD@email.com',
        password: 'P@ssw0rd123',
        password_confirmation: 'P@ssw0rd123'
      })

      @user = User.new({
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'janeD@email.com',
        password: 'P@ssw0rd123',
        password_confirmation: 'P@ssw0rd123'
      })
    end

    it 'saves to the database' do
      expect(@user.save).to be_truthy
    end

    it 'validates that password fields match' do
      @user.password = 'password'
      expect(@user.save).to_not be_truthy
    end

    it 'validates password length' do
      @user.password = 'pass'
      expect(@user.save).to_not be_truthy
    end

    it 'validates that email is unique' do
      @user.email = 'JOHND@email.com'
      expect(@user.save).to_not be_truthy
    end

    it 'validates that email is present' do
      @user.email = nil
      expect(@user.save).to_not be_truthy
    end

    it 'validates that first name is present' do
      @user.first_name = nil
      expect(@user.save).to_not be_truthy
    end

    it 'validates that last name is present' do
      @user.last_name = nil
      expect(@user.save).to_not be_truthy
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    before :each do
      User.create({
        first_name: 'John',
        last_name: 'Doe',
        email: 'johnD@email.com',
        password: 'P@ssw0rd123',
        password_confirmation: 'P@ssw0rd123'
      })

      @login = { email: 'johnD@email.com', password: 'P@ssw0rd123' }
    end

    it 'authenticates valid user' do
      user = User.authenticate_with_credentials(@login[:email], @login[:password])
      expect(user).to be_truthy
    end

    it 'validates password' do
      user = User.authenticate_with_credentials(@login[:email], 'password')
      expect(user).to_not be_truthy
    end

    it 'authenticates valid user with whitespaced email' do
      user = User.authenticate_with_credentials('  johnD@email.com  ', @login[:password])
      expect(user).to be_truthy
    end

    it 'authenticates valid user with different-cased email' do
      user = User.authenticate_with_credentials('johnD@EMAIL.com', @login[:password])
      expect(user).to be_truthy
    end
  end
end
