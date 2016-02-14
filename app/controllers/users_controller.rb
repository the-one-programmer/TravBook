class UsersController < ApplicationController
  skip_before_filter :authenticate_request , :only=>[:create,:request_reset_password,:current_user]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        render json: { message: 'Account successfully created!' }, status: 200
      else
        render json: { message: @user.errors}, status: 400
      end

  end

  def show
    @user = User.find_by_id(params[:id])
    if (@user.nil?)
      render json: { message: 'User not found'}, status: 400
    end
  end

  def update
    if (params.has_key?(:interests)) and params[:interests].present?
      @current_user.interests.clear
      params[:interests].each do |interest_id|
        if (Interest.exists?(:id => interest_id))
          @current_user.interests << Interest.find(interest_id)
        end
      end
    end
    if (params.has_key?(:languages)) and params[:languages].present?
      @current_user.languages.clear
      params[:languages].each do |language_id|
        if (Language.exists?(:id => language_id))
          @current_user.languages << Language.find(language_id)
        end
      end
    end
    if (params.has_key?(:countries_want_to_go)) and params[:countries_want_to_go].present?
      @current_user.countries.clear
      params[:countries_want_to_go].each do |country_id|
        if (Country.exists?(:id => country_id))
          @current_user.countries << Country.find(country_id)
        end
      end
    end

    if @current_user.update(user_params)
      @message = 'Profile updated.'
      render json: { message: 'Account successfully updated!' }, status: 200
    else
      render :error, status: 400
    end
  end

  def request_reset_password
    user = User.find_by_email(params[:email])
    if (user)
      token = user.generate_auth_token
      ApplicationMailer.reset_password_email(user,token).deliver_later
      render json: { message: "Email sent."}, status: 200
    else
      render json: { message: "Email not registered in database"}, status: 400
    end
  end

  def current_user
    if @current_user
      render json: {id:@current_user.id}, status:200
    else
      render json: {id:nil}, status:400
    end
  end

  def follow
    if (@current_user.follow(params[:user_id]))
      render json: {message:"success"}, status:200
    else
      render json: {message:@current_user.errors}, status:400
    end
  end

  def unfollow
    if (@current_user.unfollow(params[:user_id]))
      render json: {message:"success"}, status:200
    else
      render json: {message:@current_user.errors}, status:400
    end
  end

  def search
    @users = User.where('name ilike ?', '%' + params[:query] + '%').sort_by{|user| -user.matching_value(@current_user)}
    if (@users.include?(@current_user))
      @users.delete(@current_user)
    end
  end

  def recommend
    @users = User.all.sort_by {|user| -user.matching_value(@current_user)}
    if (@users.include?(@current_user))
      @users.delete(@current_user)
    end

  end

  private

  def user_params
    params.permit(:name, :email, :password,:gender, :city_id,
      :willing_to_host, :can_transport, :can_tourguide, :can_accomendation, :can_pickup,
      :transport_detail, :tourguide_detail, :accomendation_detail, :pickup_detail, :avatar)
  end

end