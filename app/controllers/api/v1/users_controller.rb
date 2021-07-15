class Api::V1::UsersController < ApplicationController
    before_action :getUser, only: [:updateUser, :deleteUser, :showUser]

  #get
  def getUsers
    user = User.all  
    if user
      render json: user , status: :ok 
    else 
      render json: {msg: "User empty "}, status: :unprocessable_entity
    end 
  end 
  #post
  def addUser
    user = User.new(userparams)
    user.type = 2; # eveytime a user is created a type is will be default as 2

    if user.save()
         render json: user.as_json({:except => [:password_digest]}).merge({:id => user.id.to_s}), status: :ok
    else
         render json: { msg: "User not added", error: user.errors }, status: :unprocessable_entity
    end

end

  #put 
  def updateUser 
    if @user
      if @user.update(userparams)
        render json: @user, status: :ok 
      else 
        render json: {msg: "Update failed",error: @user.errors }, status: :unprocessable_entity
      end 
    else
      render json: {msg: " User not found"},  status: :unprocessable_entity
    end 

  end 

  #get 
  def showUser 
    if @user
        render json: @user, status: :ok 
    else
      render json: {msg: " User not found"},  status: :unprocessable_entity
    end
  end 

  #delete 
  def deleteUser
    if @user
      if @user.destroy()
        render json:  {msg: "User deleted" }, status: :ok 
      else 
       render json: {msg: "Destroy failed" }, status: :unprocessable_entity
      end 
     else
     render json: {msg: " User not found"},  status: :unprocessable_entity
   end 
  end 


  private 

  def userparams 
    params.permit(:username, :email, :password)
  end
  def getUser 
    @user = User.find(params[:id])
  end 
end
