class RelationshipsController < ApplicationController
    
   def create
    # user = User.find(params[:follower_id])
    # follower = current_user.follower_relationships.new(follower_id: user.id)
    # follower.save
    # followed = user.followed_relationships.new(followed_id: current_user.id)
    # followed.save
    
    current_user.follow(params[:user_id])
    
    redirect_to request.referer
   end
   
   def destroy
    # user = User.find(params[:user_id])
    # follower = current_user.relationships.find_by(follower_id: user.id)
    # follower.destroy
    # followed = user.relationships.find_by(followed_id: current_user.id)
    # followed.destroy
    
    current_user.unfollow(params[:user_id])
    
    redirect_to request.referer
   end 

end
