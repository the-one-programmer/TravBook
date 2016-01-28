class UsersController < ApplicationController
  skip_before_filter :authenticate_request , :only=>[:create]
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
    @user = User.find(params[:id])
  end

  def update
    if (params.has_key?(:interests))
      @current_user.interests.clear
      params.require(:interests).each do |interest_id|
        if (Interest.exists?(:id => interest_id))
          @current_user.interests << Interest.find(interest_id)
        end
      end
    end
    if (params.has_key?(:languages))
      @current_user.languages.clear
      params.require(:languages).each do |language_id|
        if (Language.exists?(:id => language_id))
          @current_user.languages << Language.find(language_id)
        end
      end
    end
    if (params.has_key?(:countries_want_to_go))
      @current_user.countries.clear
      params.require(:countries_want_to_go).each do |country_id|
        if (Country.exists?(:id => country_id))
          @current_user.countries << Language.find(country_id)
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

  def current_user
    if @current_user
      render json: {id:@current_user.id}, status:200
    else
      render json: {id:nil}, status:200
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password,:gender, :city_id,:willing_to_host)
  end

end