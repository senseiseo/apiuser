class ApplicationController < ActionController::API
  def getUsers 
  end 

  def addUser
    user = User.new(username: params[:username], email: params[:email], password_digest: params[:password])

    if user.save 
      render json: user, status: :ok 

    else
      render json: {message: "user not added"}, status: :unprocessable_entity 
    end
  end 
end
