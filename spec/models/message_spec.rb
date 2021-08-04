require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "#create" do
    before do
      @message = FactoryBot.build(:message)
    end

    context "保存できる場合" do
      it "contentと画像があれば投稿できる" do
        expect(@message).to be_valid
      end
  
      it "contentがあれば画像がなくても投稿できる" do
        @message.image = nil
        expect(@message).to be_valid
      end
  
      it "画像があればcontentがなくても投稿できる" do
        @message.content = ""
        expect(@message).to be_valid
      end
    end
    
    context "保存できない場合" do
      it "画像もcontentもなければ保存ができない" do
        @message.content = ""
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end

      it "ユーザーidが紐づいていなければ保存ができない" do
        @message.user = nil
        @message.valid?
        expect(@message).to include("User must exist")
      end

      it "room_idが紐づいていなければ保存ができない" do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Room must exist")
      end
    end
    
  end
end
