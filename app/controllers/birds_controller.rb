class BirdsController < ApplicationController
    def index
        render json:Bird.all
    end

    #ngereturn bird dengan specified id, cth /1, akan direturn bird dengan id 1
    def show
        bird = Bird.find(params[:id])
        render json: bird
    end

    def create
        bird = Bird.new(bird_params)
        bird.save!
        render json: bird
    end    

    def bird_params
        params.require(:bird).permit(:name, :description)
    end

    def update
        bird = Bird.find(params[:id])
        bird.assign_attributes(bird_params)
        bird.save!
        render json: bird
    end

    def delete
        bird = Bird.find(params[:id])
        bird.delete
        render json: "Delete Success"
    end
end
