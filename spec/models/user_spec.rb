require 'spec_helper'

describe User do
	let(:user) { build(:user) } 

	context "validations" do

		it "should have a name" do
			user.name?.should == true
		end

		it "should have a unique name" do
			user.name.unique?.should == true
		end

		it "has an oauth_token" do
  		user.oauth_token?.should == true
  	end

  	it "has a unique oauth_token" do
  		user.oauth_token.unique?.should == true
  	end

  	it "has a facebook uid" do
  		user.uid?.should == true
  	end

  	it "has a unique facebook uid" do
  		user.uid.unique?.should == true
  	end

  	it "has a provider of facebook" do
  		user.uid.unique?.should == true
  	end
	end	

  context "create facebook user" do
  	it "adds a new user object to the database" do
  		before_save = user.all.length
  		after_save  = user.all.length + 1
  		after_save.should == user.all.length + 1
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
# 		