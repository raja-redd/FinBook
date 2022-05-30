class UsersController < ApplicationController
    def  new
        @user = User.new
    end
    
    before_action :set_user, only: [:edit, :update, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
    
    def index
      # i=1;
      # users=User.all
      # users.each do |user|
      #   user.username="user"+i.to_s
      #   i=i+1;
      #   user.save
      # end
      @users = User.all
    end
    
    
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome to the FinanceBook #{@user.username.upcase}"
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
      flash[:danger] = "User and all other details of user have been deleted"
      redirect_to users_path
    end

    def follow
      if !logged_in?
        flash[:danger] = "must be logged in to follow"
      end   
      star=params[:id]
      follow_=Follow.new(follower_id:current_user.id,star_id:star)
      follow_.save
      flash[:success] = "you are now following #{User.find(star)[:username]}"
      
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
      flash[:danger] = "you unfollowed #{(User.find(star))[:username]}"
      
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
      flash[:success] = "you requested #{(User.find(params[:id]))[:username]} to be your friend"
     
      redirect_to users_path
    end
    def removee
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end 
      status=0
      @var=Friend.all.where(freind1_id:current_user.id,freind2_id:params[:id])
      @var.each do |var_|
        status=var_.status1 && var_.status2
        var_.destroy
      end
      @var=Friend.all.where(freind2_id:current_user.id,freind1_id:params[:id])
      @var.each do |var_|
        status=(var_.status1 && var_.status2) || status
        var_.destroy
      end
      flash[:danger] = "you #{status ? "removed" : "cancelled request" } #{(User.find(params[:id]))[:username]} as your friend"
     
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
      flash[:success] = "you accepted #{(User.find(params[:id]))[:username]} to be your friend"
     
      if Friend.all.where(freind2_id:current_user.id,status2:0).count==0
        redirect_to users_path
        return
      end
      redirect_to ('/requests/'+current_user.id.to_s)
      return
    end


    def friends
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end
      @users=User.all.where(id:Friend.all.where(freind2_id:current_user.id,status2:true,status1:true).select(:freind1_id))
      # if @users.nil?
      @users+=User.all.where(id:Friend.all.where(freind1_id:current_user.id,status2:true,status1:true).select(:freind2_id))
      # end
    end



    def copy
      if !logged_in?
        flash[:danger] = "must be logged in to see"
        redirect_to stocks_path
      end
      puts "--------------------------------------------------"
      puts params[:id2]
      puts "--------------------------------------------------"
      flag=0;
      friend=Friend.all.where(freind1_id:current_user.id,freind2_id:params[:id],status1:1,status2:1)
      if friend.count>0 
         friend.first.one_two=params[:id2]
         x=friend.first.save
         puts "saving is "+x.to_s
         flag=1;
      end

      friend=Friend.all.where(freind2_id:current_user.id,freind1_id:params[:id],status1:1,status2:1)
      if friend.count>0 
         friend.first.two_one=params[:id2]
         x=friend.first.save
         puts "saving is "+x.to_s
         flag=1;
      end
      if params[:id2].to_s==0.to_s
        flash[:danger] = " you are no longer copying stocks"
      else

        flash[:success ] = " you are now copying stocks"
      end
      puts "--------------------------------------------------"
      puts flag.to_s+"copy "
      puts "--------------------------------------------------"
      flag=0;
      redirect_to users_path

      
      

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