class ApplicationController < ActionController::API
  include TokerManager 

  def create_token(user_id, username, usertype)
    return generate_token(user_id, username, usertype)
  end

  def chech_auth(usertype = 1, return_user = false)
    user_token = decrypt_token(request.headers['token'])
    if user_token
      account = User.find(user_token[:id])
      if account
        if  user_token[:token_ex] < Time.now.to_i 
          render json: {msg: "Token Expired"}, status: :unautorized
        else 
          if return_user 
            render json: {msg: "Token good",user: account}, status: :ok
          else

          return true
          end
        end 
      else
        render json: {msg: "unautorized"}, status: :unautorized
      end 
    else
      render json: {msg: "unautorized, Token unacceptble"}, status: :unautorized
    end 
  end 
end
