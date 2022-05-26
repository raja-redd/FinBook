class StocksController < ApplicationController

    def index
        @stocks =Stock.all
    end
    
    def show
        @stock=Stock.find(params[:id])
        @sp=@stock.stock_prices
        puts "enters show"
        puts "enters show"

    end

    def myport
        puts params[:id]
        puts current_user.id
        if ((params[:id]).to_s)!=((current_user.id).to_s)
            puts "---------------------------------"
            flash[:danger] = "You are not allowed to see"
            redirect_to stocks_path
        end
        @id=current_user.id
        # puts "enters show"
        # puts "enters show---------------------"

    end

    def add 
        # puts params[:id]
        # puts current_user.id
        # puts params[:id]
        @adding=MyStock.new(stock_id:params[:id],user_id:current_user.id)
        # puts @adding.valid?
        # puts @adding.errors
        # puts MyStock.all.where(stock_id:params[:id]).where(user_id:current_user.id).count
        # puts  @adding.valid? && MyStock.all.where(stock_id:params[:id]).where(user_id:current_user.id).count==0
        if @adding.valid? 
            if (MyStock.all.where(stock_id:params[:id]).where(user_id:current_user.id).count)<1
             @adding.save
            # puts "entering the if, added and saved -----------------------------" 
            end
        end
        puts ""
        redirect_to stocks_path
    end


    def delete 
        puts "------------------------------------------------------------------------------------------------"
        # puts params[:id]
        # puts current_user.id
        # puts params[:id]
        # @adding=MyStock.new(stock_id:params[:id],user_id:current_user.id)
        # puts @adding.valid?
        # puts @adding.errors
        puts MyStock.all.where(stock_id:params[:id]).where(user_id:current_user.id).count
        @del=MyStock.where(stock_id:params[:id]).where(user_id:current_user.id)
        # puts  @adding.valid? && MyStock.all.where(stock_id:params[:id]).where(user_id:current_user.id).count==0
        # if @adding.valid? 
        #     if (MyStock.all.where(stock_id:params[:id]).where(user_id:current_user.id).count)<1
        #      @adding.save
        #     puts "entering the if, added and saved -----------------------------" 
        #     end
        # end
        # puts ""
        @del.each do |stock|
        puts stock.stock_id
        stock.destroy
        end
        redirect_to stocks_path
    end









end
