class FollowsController<ApplicationController

 def create
   @user = User.find(params[:followed_id])
   current_user.follow(@user)
   respond_to do |format|
     format.html { redirect_to user_path(current_user) }
     format.js
   end
  
 end

 
end
