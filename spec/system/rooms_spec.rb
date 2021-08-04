require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  #チャット削除機能の結合テスト
  before do
    @room_user = FactoryBot.create(:room_user)
    @room = @room_user.room
    @user = @room_user.user
  end

  it "チャットルームを削除すると、関連するメッセージが全て削除されていること" do
    #サインインする
    sign_in(@user)
    #作成されたチャットルームに移動する
    click_on(@room.name)
    #メッセージ情報を５つDBに追加する
    messages = FactoryBot.create_list(:message, 5, room_id: @room.id, user_id: @user.id)
    
    #「チャットを終了する」ボタンをクリックすることで、作成した５つのメッセージが削除されていることを確認する。
    expect{
      click_on('チャットを終了する')
    }.to change{Message.count}.by(-5)
    #トップページに遷移していることを確認する
    expect(current_path).to eq(root_path)
    

  end
end
