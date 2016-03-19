class UsersController < ApplicationController
  skip_before_filter :authenticate_request , :only=>[:create,:request_reset_password,:current_user]
  def new
    @user = User.new
  end
  api :POST, '/register', 'Create a user'
  description 'Create/register a user'
  param :name,String, desc: 'name of user' ,:required => true
  param :email, String, desc: 'email' ,:required => true
  param :password, String, desc: 'password' ,:required => true
  param :gender, :number, desc: 'gender' ,:required => true
  param :city_id, :number, desc: 'city of residence' ,:required => true
  param :willing_to_host, [true, false], desc: 'willing to host?' ,:required => true

  def create
    @user = User.new(user_params)
      if @user.save
        render json: { message: 'Account successfully created!' }, status: 200
      else
        render json: { message: @user.errors}, status: 400
      end
  end
  api :GET, '/show/:id', 'show a user'
  description 'show a user'
  param :id,:number, desc: 'user id' ,:required => true

  def show

    @user = User.find_by_id(params[:id])
    if (@user.nil?)
      render json: { message: 'User not found'}, status: 400
    end
  end
  api :POST, '/update', 'Update a user'
  param :name,String, desc: 'name of user'
  param :email, String, desc: 'email'
  param :password, String, desc: 'password'
  param :gender, :number, desc: 'gender'
  param :city_id, :number, desc: 'city of residence'
  param :willing_to_host, [true, false], desc: 'willing to host?'
  param :avatar, Hash, :desc => 'avatar' do
    param :filename, String, :desc => "name of the image", :required => true
    param :base64, String, :desc => "base64 encode of the image", :required => true
    param :filetype, String, :desc => "filetype of the image", :required => true
  end
  param :can_transport, [true, false]
  param :can_tourguide, [true, false]
  param :can_accomendation, [true, false]
  param :can_pickup, [true, false]
  param :transport_detail,String
  param :tourguide_detail,String
  param :accomendation_detail,String
  param :pickup_detail,String

  def update
    params[:avatar] = parse_image_data(params[:avatar]) if params[:avatar]
    @current_user.avatar = params[:avatar]
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
  ensure
    clean_tempfile
  end
  api :POST, '/request_reset_password', 'request an email for password reset'
  description 'An email will be sent to user for password reset'
  param :email, String, desc: 'email'
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

  api :GET, '/current_user', 'Get the information of the user by auth token'
  description 'Pls remember to put auth token in auth header'

  def current_user
    if @current_user
      render json: {id:@current_user.id, name:@current_user.name}, status:200
    else
      render json: {id:nil}, status:400
    end
  end
  api :POST, '/follow/', 'follow a user'
  param :user_id,:number, desc: 'id of user to follow' ,:required => true
  def follow
    if (@current_user.follow(params[:user_id])) and @current_user.id != params[:user_id]
      render json: {message:"success"}, status:200
    else
      render json: {message:@current_user.errors}, status:400
    end
  end
  api :POST, '/unfollow/', 'unfollow a user'
  param :user_id,:number, desc: 'id of user to unfollow' ,:required => true
  def unfollow
    if (@current_user.unfollow(params[:user_id])) and @current_user.id != params[:user_id]
      render json: {message:"success"}, status:200
    else
      render json: {message:@current_user.errors}, status:400
    end
  end
  api :POST, '/search/', 'search for users by keyword'
  param :query,String, desc: 'keywords' ,:required => true
  def search
    @users = User.where('name ilike ?', '%' + params[:query] + '%').sort_by{|user| -user.matching_value(@current_user)}
    if (@users.include?(@current_user))
      @users.delete(@current_user)
    end
  end
  api :GET, '/recommend', 'recommend a list of users that can be potential friend of the current user'

  def recommend
    @users = (User.all - @current_user.followeds).sort_by {|user| user.matching_value(@current_user)}
                 .last(20)
    if (@users.include?(@current_user))
      @users.delete(@current_user)
    end
  end
  api :POST, '/feed', 'news feed of the current user'

  param :page, :number, desc: 'page number'
  def feed
    @posts = @current_user.feed.paginate(:page => params[:page])
  end

  private

  def user_params
    params.permit(:name, :email, :password,:gender, :city_id,
      :willing_to_host, :can_transport, :can_tourguide, :can_accomendation, :can_pickup,
      :transport_detail, :tourguide_detail, :accomendation_detail, :pickup_detail, :avatar)
  end

  def parse_image_data(image_data)
    @tempfile = Tempfile.new('item_image')
    @tempfile.binmode
    @tempfile.write Base64.decode64(image_data[:base64])
    @tempfile.rewind

    uploaded_file = ActionDispatch::Http::UploadedFile.new(
        tempfile: @tempfile,
        filename: image_data[:filename]
    )

    uploaded_file.content_type = image_data[:filetype]
    uploaded_file
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end

end