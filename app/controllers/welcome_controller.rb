class WelcomeController < ApplicationController
	def index
	end
	def login
	end
	def set_name
		@user_name=params['user_name']
		session['user_name']=@user_name
		redirect_to :action => 'index'
	end
	def logout
		@user_name=nil
		reset_session
		redirect_to :action => 'index'
	end
	def guess_game
		@guess_images={
			:img1=>"/images/cars/car1.jpeg",
			:img2=>"/images/cars/car2.jpeg",
			:img3=>"/images/cars/car3.jpeg",
			:img4=>"/images/cars/car4.jpeg"
		}
		@special_guess = @guess_images.keys[rand(4)]
	    if !session['guess_counter']
	    	session['win_counter']=0
	    	@guess_message = "study these pics, you'll need their positions later"
	    else @guess_message = "Which position was this pic in?"
	    end
	    @submit_guess = params[:submit_choice]
	    @old_special_guess = params[:old_answer]
	    @win_counter=session['win_counter']

	end
	def choose_image 
		if !session['guess_counter']
			session['guess_counter'] = 1
		else session['guess_counter'] += 1
	    end
	    if params[:submit] == params[:answer]
	    	session['win_counter'] += 1
	    end
	    redirect_to :action => 'guess_game', :submit_choice => params[:submit], :old_answer=> params[:answer]
	end

end
