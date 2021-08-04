require 'rails_helper'

RSpec.describe "Users", type: :system do
  #ユーザーログイン機能の結合テスト
  describe "ユーザーログイン" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "ログインしていない状態ではサインインページに遷移することを確認する" do
      visit root_path
      expect(current_path).to eq(new_user_session_path)
    end

    context "ログインできる時" do
      it "ユーザー情報を正しく入力すればログインができ、チャットルーム一覧が表示される" do
        #トップページに移動する
        visit root_path
        #ログインページに遷移していることを確認する
        expect(current_path).to eq(new_user_session_path)
        #ログイン情報を入力する
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        #ログインボタンを押す
        click_on('Log in')
        #チャット一覧のページに移動したことを確認する
        expect(current_path).to eq(root_path)
      end
    end

    context "ログインできない時" do
      it "ログイン情報が誤っていればログインできない" do
        #ログインページに遷移する
        visit new_user_session_path
        #ログイン情報を入力する
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        #ログインボタンを押す
        click_on('Log in')
        #ログインページにリダイレクトされることを確認する
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end
