class BirdsController < ApplicationController
    def index
        #get all birds data from database and render it as JSON
        render json: Bird.all
    end

    
end