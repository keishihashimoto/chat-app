require 'rails_helper'

RSpec.describe User, type: :model do
  describe "新規登録" do
    before do
      @user = FactoryBot.build(:user)
    end

    context "新規登録できる時" do
      it "name, email, passwordが揃えば新規登録できる" do
        expect(@user).to be_valid
      end

      it "passwordが６文字異常であれば登録できる" do
        password = "000000"
        @user.password = password
        @user.password_confirmation = password
        expect(@user).to be_valid
      end
    end

    context "新規登録できない時" do
      it "nameの値が空ではDBに保存できない" do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it "emailの値が空ではDBに保存ができない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "passwordの値が空ではDBに保存できない" do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが６文字未満だと登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it "passwordとpassword_confirmationの不一致があると登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it "既にDBに保存されているemailは使用できない" do
        user1 = FactoryBot.build(:user)
        email = user1.email
        user1.save
        @user.email = email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

    end
  end
end

