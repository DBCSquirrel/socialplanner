require 'spec_helper'

describe CommentsController do
  let(:comment) { build(:comment) }

  let(:valid_attributes) do
    build(:comment).attributes.delete_if { |k,v| k == 'id' || k == 'created_at' || k == 'updated_at' }
  end

  let(:invalid_attributes) do
    build(:comment, :body => "").attributes.delete_if { |k,v| k == 'id' || k == 'created_at' || k == 'updated_at' }
  end

  describe '#new' do
    it "renders a form" do
      get :new
      assigns(:comment).should_not be_nil
      assigns(:comment).should be_an_instance_of(Comment)
    end
  end

  describe '#create' do

    context "with valid parameters" do
      it "saves the data from the form to the database" do
        expect do
          post :create, {:comment => valid_attributes }
        end.to change{Comment.count}.by(1)
      end

      it "renders new comment in the event page" do
        expect do
          post :create, {:comment => valid_attributes }
           response.should be_success
           response.should render_template('comments/_comment')
        end.to change(Comment, :count).by(1)
      end

    end

    context "with invalid parameters" do

      it "should not create a new comment" do
        expect do
          post :create, {:comment => invalid_attributes }
        end.to_not change{Comment.count}.by(1)
      end

      it "should render the form partial" do
        post :create, {:comment => invalid_attributes }
        response.should render_template(:partial => '_form')
      end

    end
  end

  describe '#destroy' do

    it "should remove a record from the database" do
      comment.save!
      expect do
        delete :destroy, { :id => comment.id }
      end.to change{Comment.count}.by(-1)
    end
  end
end