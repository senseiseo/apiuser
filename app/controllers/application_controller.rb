class ApplicationController < ActionController::API
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

    if user.save 
      render json: user, status: :ok 

    else
      render json: {msg: "user not added"}, status: :unprocessable_entity 
    end
  end 

  #put 
  def updateUser 
    if @user
      if @user.update(userparams)
        render json: @user, status: :ok 
      else 
        render json: {msg: "Update failed" }, status: :unprocessable_entity
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
    params.permit(:username, :email, :password_digest)
  end
  def getUser 
    @user = User.find(params[:id])
  end 
end
