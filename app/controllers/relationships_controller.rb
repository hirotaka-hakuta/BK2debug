class RelationshipsController < ApplicationController
    
   def create
    user = User.find(params[:user_id])
    follower = current_user.follower_relationships.new(follower_id: user.id)
    
    binding.pry
    
    follower.save
        binding.pry
    
    followed = user.followed_relationships.new(followed_id: current_user.id)
        binding.pry
    
    followed.save
     binding.pry
    
    redirect_to request.referer
   end
   
   def destroy
    user = User.find(params[:user_id])
    follower = current_user.relationships.find_by(follower_id: user.id)
    follower.destroy
    followed = user.relationships.find_by(followed_id: current_user.id)
    followed.destroy
    redirect_to request.referer
   end 

end
