require 'spec_helper'

describe CommentsController do

  describe '#new' do
    it "renders a form" do
      get :new
      assigns(:comment).should_not be_nil
      assigns(:comment).should be_an_instance_of(Comment)
    end
  end

end