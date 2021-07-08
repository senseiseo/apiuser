class Api::Auth::AuthController < ApplicationController
    def login 
        user = User.find_by(username: params[:username])

        # check user exist
        if !user
            render json: {msg: " User not found ",user: user}, status: :unprocessable_entity 
            return true
        end 

        if user.authenticate(params[:password])
            render json: {msg: "Sucesfull login", user: user}, status: :ok
        else 
            render json: {msg: " Password wrong"}, status: :unprocessable_entity  
        end 
    end 

end