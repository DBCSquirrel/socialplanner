require 'spec_helper'

describe User do
	let(:user) { build(:user) } 

	context "initialization" do
		it "should have a name" do
			user.name = ""
      user.save.should be_false
      user.errors.full_messages.should include("Name can't be blank")  
		end

		it "has an oauth_token" do
  		user.oauth_token = ""
      user.save.should be_false
      user.errors.full_messages.should include("Oauth token can't be blank")
    end

    it "should have a properly formatted oauth_token"

  	it "has a facebook uid" do
      user.uid = ""
      user.save.should be_false
      user.errors.full_messages.should include("Uid can't be blank")
  	end

    it "should have a numerical facebook uid" do
      user.uid = "I ran over a homeless man"
      user.save.should be_false
      user.errors.full_messages.should include("Uid is not a number")
    end


  	it "has a unique facebook uid" do
  	  user2 = create(:user)
      user.save.should be_false
      user.errors.full_messages.should include("Uid has already been taken")
  	end

  	it "has a provider called 'facebook'" do
  		user.provider = 'facebookish'
      user.save.should be_false
      user.errors.full_messages.should include("Provider is invalid")
  	end

	end	

end

# class User < ActiveRecord::Base
#   attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid

#   # validates presence
#   # validates uniqueness

#   def self.from_omniauth(auth)
# 	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
# 	    user.provider = auth.provider
# 	    user.uid = auth.uid
# 	    user.name = auth.info.name
# 	    user.oauth_token = auth.credentials.token
# 	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
# 	    user.save!
# 	  end
#   end

#   def facebook
#   	@facebook ||= Koala::Facebook::API.new(oauth_token)
#   end
# end