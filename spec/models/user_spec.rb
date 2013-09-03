require 'spec_helper'

describe User do

	before { @user = User.new(name: "Sample User", 
				  email: "sample@example.com", 
                                  password: "test01",
                                  password_confirmation: "test01") }

	subject { @user }

	it { should respond_to(:authenticate) }
	it { should respond_to(:name) }
 	it { should respond_to(:email) }


  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
