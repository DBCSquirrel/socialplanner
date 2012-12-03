require 'spec_helper'

describe Comment do
  let(:comment) { build(:comment) }
  context "#initialization" do
    [:body, :commentable_type, :commentable_id].each do |attribute|
      it {should respond_to attribute}
    end

    it { should belong_to(:commentable) }
    it { should have_many(:comments) }

    it "should have a body" do
      comment.body = ''
      comment.save.should be_false
      comment.errors.full_messages.should include("Body can't be blank")
    end

    it "should have a commentable_id" do
      comment.commentable_id = nil
      comment.save.should be_false
      comment.errors.full_messages.should include("Commentable can't be blank")
    end

    it "should have a commentable_type" do
      comment.commentable_type = ""
      comment.save.should be_false
      comment.errors.full_messages.should include("Commentable type can't be blank")
    end

    it "should have a properly formatted commentable type" do
      comment.commentable_type = "Commenta"
      comment.save.should be_false
      comment.errors.full_messages.should include("Commentable type must be 'Comment' or 'Event'")
    end

    it "should have a numeric commentable ID" do
      comment.commentable_id = "34asdf"
      comment.save.should be_false
      comment.errors.full_messages.should include("Commentable is not a number")
    end
  end
end