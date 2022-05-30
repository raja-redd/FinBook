class StocksController < ApplicationController

    def index
        @stocks =Stock.all
        # x=Stock.new(Name:"Apple")
        # x.save
        # x=Stock.new(Name:"Samsung")
        # x.save
        # x=Stock.new(Name:"Netflix")
        # x.save
        # x=Stock.new(Name:"Sprinkler")
        # x.save
        # x=Stock.new(Name:"TATA")
        # x.save
        # x=Stock.new(Name:"ITC")
        # x.save
        # x=Stock.new(Name:"Swiggy")
        # x.save
        # x=Stock.new(Name:"Zomato")
        # x.save
        # x=Stock.new(Name:"OnePlus")
        # x.save
        # x=Stock.new(Name:"Dell")
        # x.save
        # x=Stock.new(Name:"Acer")
        # x.save
        # x=Stock.new(Name:"EKSA")
        # x.save
        # x=Stock.new(Name:"Microsoft")
        # x.save
        # x=Stock.new(Name:"Logitech")
        # x.save
        
        
        # ActiveRecord::Base.connection.execute("truncate StockPrice RESTART DENTITy")
        # StockPrice.destroy_all
        # Stock.all.each do |stock|
        #     x= Random.new.rand(0..1000)
        #     i=30;
        #     30.times do |n|
        #         # puts stock.Name
        #         # puts datee
        #         # puts stock.id
        #         # puts x

        #         datee="#{i<10 ? "0"+i.to_s : i.to_s}/05/2022"
        #         i=i-1;
        #         x=x*(1+(Random.new.rand(0..300)/10000.0-0.015))
        #         x=x.round(3)
        #         price=StockPrice.new(Name:stock.Name,price:x,date:datee,stock_id:stock.id)
        #         puts price.valid?
        #          price.errors.each do |error|
        #             puts error
        #         end
        #         if price.valid?
        #             price.save
        #             puts "saved --------------------------------------------------"
        #         else 
        #             puts price.errors
        #             puts "not saved --------------------------------------------------"
        #         end
        #     end
        # end

    end
    
    def show
        @stock=Stock.find(params[:id])
        @sp=@stock.stock_prices
        puts "enters show"
        puts "enters show"

    end

    def myport
        # puts params[:id]
        # puts current_user.id
        # if ((params[:id]).to_s)!=((current_user.id).to_s)
        #     puts "---------------------------------"
        #     flash[:danger] = "You are not allowed to see"
        #     redirect_to stocks_path
        # end
        # if logged_in? 
        #      @id=current_user.id
        # end
        @id=params[:id]
        # puts "enters show"
        # puts "enters show---------------------"

    end

    def add 
        if !logged_in?
            flash[:danger]="you are not allowed to do this"
            render stocks_path
            return
        end
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
                if params[:id2].to_s==3.to_s
                    @adding.privacy=3
                else
                    @adding.privacy=params[:id2]
                    copiers=Friend.all.where(freind1_id:current_user.id,two_one:1)
                    puts "-------------------------------------------------------------------------------------------------------------------"
                    puts params[:id2]
                    puts "-------------------------------------------------------------------------------------------------------------------"
                
                    puts copiers.count
                    copiers.each do |copy|
                        findd=MyStock.all.where(user_id:copy.freind2_id,stock_id:params[:id])
                        puts "-------------------------------------------------------------------------------------------------------------------"
                        puts findd.count

                        if findd.count==0
                           x= MyStock.new(user_id:copy.freind2_id,stock_id:params[:id],privacy:2)
                           if x.valid?
                            puts "x is valid"
                            x.save
                           else
                             x.errors.each do |error|
                                puts error
                             end
                           end
                        end
                    end
                    puts "-------------------------------------------------------------------------------------------------------------------"
                
                    puts copiers.count
                    
                    copiers=Friend.all.where(freind2_id:current_user.id,one_two:1)
                    copiers.each do |copy|
                        findd=MyStock.all.where(user_id:copy.freind1_id,stock_id:params[:id])
                        puts findd.count
                        if findd.count==0
                            x= MyStock.new(user_id:copy.freind1_id,stock_id:params[:id],privacy:2)
                            if x.valid?
                                puts "x is valid"
                                x.save
                               else
                                 x.errors.each do |error|
                                    puts error
                                 end
                               end
                               
                        end
                    end


                end
                
                @adding.save
            # puts "entering the if, added and saved -----------------------------" 
            end
        end
        puts ""        
        stock_is=Stock.all.where(id:params[:id]).select(:Name).first
        flash[:success] = "Added  #{stock_is[:Name]}  to your portfolio successfully"
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
        stock_is=Stock.all.where(id:params[:id]).select(:Name).first
        flash[:danger] = "deleted #{stock_is[:Name]} from your portfolio successfully"

        redirect_to stocks_path
    end

    def privacy 
       
        puts MyStock.all.where(stock_id:params[:id1]).where(user_id:current_user.id).count
        @del=MyStock.where(stock_id:params[:id1]).where(user_id:current_user.id)
       
        @del.each do |stock|
        puts stock.stock_id
        stock.privacy=params[:id2]
        stock.save
        end
        every="Everyone"
        fr="Friends"
        only="only You"
        # puts "---------------------------------"  

        flash[:success] = "changed privacy to #{(params[:id2]).to_s==1.to_s ? every :  ((params[:id2]).to_s==2.to_s ? fr : only)}"

        redirect_to ('/myport/'+current_user.id.to_s)
        
    end










end
