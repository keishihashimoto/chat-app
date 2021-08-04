require 'rails_helper'

RSpec.describe "Messages", type: :system do
  #メッセージ投稿機能の結合テスト
  before do
    #中間テーブルを介して、usersテーブルとroomsテーブルのレコードを作成する。
    @room_user = FactoryBot.create(:room_user)
    @user = @room_user.user
    @room = @room_user.room
  end

  context "投稿に失敗した時" do
    it "送る値がからの時、メッセージの送信に失敗する" do
      #サインインする
      sign_in(@user)
      #作成されたチャットルームへ遷移する
      click_on(@room.name)
      #空のメッセージを送信する
      #DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]')
      }.to change{Message.count}.by(0)
      #元のページに戻ってくることを確認する
      expect(current_path).to eq(room_messages_path(@room))
    end
  end

  context "投稿に成功した時" do
    it "テキストの投稿に成功すると、投稿一覧に遷移し投稿した内容も表示されている" do
      #サインインする
      sign_in(@user)
      #作成されたチャットルームに遷移する
      click_on(@room.name)
      #値をフォームに入力する
      message_content = Faker::Lorem.sentence
      fill_in "message_content", with: message_content
      #送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{Message.count}.by(1)
      #投稿一覧に遷移したことを確認する
      expect(current_path).to eq(room_messages_path(@room))
      #送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(message_content)
    end

    it "画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている" do
      #サインインする
      sign_in(@user)
      #作成されたチャットルームに遷移する
      click_on(@room.name)
      #添付する画像を選択する
      image_path = Rails.root.join('public/images/test_image.png')
      #画像選択フォームに画像を添付する
      attach_file("message[image]", image_path, make_visible: true)
      #送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change{Message.count}.by(1)
      #投稿一覧に遷移したことを確認する
      expect(current_path).to eq(room_messages_path(@room))
      #送信した値がブラウザに表示されていることを確認する
      expect(page).to have_selector "img"
    end

    it "テキストと画像の投稿に成功した時" do
      #サインインする
      sign_in(@user)
      #作成されたチャットルームに遷移する
      click_on(@room.name)
      #値をフォームに入力する
      message_content = Faker::Lorem.sentence
      fill_in "message_content", with: message_content
      #添付する画像を選択する
      image_path = Rails.root.join('public/images/test_image.png')
      #画像選択フォームに画像を添付する
      attach_file("message[image]", image_path, make_visible: true)
      #送信した値がDBに保存されていることを確認する
      expect{
        click_on('送信')
      }.to change{Message.count}.by(1)
      #投稿一覧に遷移したことを確認する
      expect(current_path).to eq(room_messages_path(@room))
      #送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(message_content)
      expect(page).to have_selector "img"

    end
  end


end
