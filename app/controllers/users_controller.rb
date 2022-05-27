class UsersController < ApplicationController
    def  new
        @user = User.new
    end
    
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
    
    def index
      @users = User.all
    end
    
    
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
        redirect_to user_path(@user)
      else
        render 'new'
      end
    end
    
    def edit
    end
    
    def update
      if @user.update(user_params)
        flash[:success] = "Your account was updated successfully"
        redirect_to articles_path
      else
        render 'edit'
      end
    end
    
    def show
        redirect_to ('/myport/'+params[:id])
    end
    
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:danger] = "User and all articles created by user have been deleted"
      redirect_to users_path
    end

    def follow
      if !logged_in?
        flash[:danger] = "must be logged in to follow"
      end   
      star=params[:id]
      follow_=Follow.new(follower_id:current_user.id,star_id:star)
      follow_.save
      redirect_to users_path
    end
    def unfollow
      if !logged_in?
        flash[:danger] = "must be logged in to follow"
        redirect_to stocks_path
      end   
      star=params[:id]
      follow_=Follow.all.where(follower_id:current_user.id,star_id:star)
      follow_.each do |follow__|
        follow__.destroy
      end
      redirect_to users_path
    end
    def following
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end 
      if (current_user.id.to_s)!=(params[:id].to_s)
        flash[:danger] = "you have no permission to see"
        redirect_to stocks_path
      end
      @stars=User.all.where(id:current_user.stars.select(:star_id))
      # puts "------------------------------------------"
      # puts @stars
      # puts "------------------------------------------"
    end
    def requestt
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end 
      # @var=Friend.new
      @var=Friend.new(freind1_id:current_user.id,freind2_id:params[:id],status1:true)
      if @var.valid?
         @var.save
      end
      puts "redirecting again"
      redirect_to users_path
    end
    def removee
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end 
      @var=Friend.all.where(freind1_id:current_user.id,freind2_id:params[:id])
      @var.each do |var_|
        var_.destroy
      end
      @var=Friend.all.where(freind2_id:current_user.id,freind1_id:params[:id])
      @var.each do |var_|
        var_.destroy
      end
      redirect_to users_path
    end

    def requests
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end 

      @users=User.all.where(id:Friend.all.where(freind2_id:current_user.id,status2:false).select(:freind1_id))

      
    end
    
    def acceptt
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end 

      @row=Friend.all.where(freind2_id:current_user.id,freind1_id:params[:id]).first
      @row.status2=1;
      @row.save
      redirect_to ('/requests/'+current_user.id.to_s)
    end
    def friends
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end
      @users=User.all.where(id:Friend.all.where(freind2_id:current_user.id,status2:true,status1:true).select(:freind1_id))
      
    end
    












    private
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:username, :email, :password)  
    end
    
    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "You can only edit your own account"
        redirect_to root_path
      end
    end
    
    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = "Only admin users can perform that action"
        redirect_to root_path
      end
    end
    
  end