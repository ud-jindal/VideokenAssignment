class TagsController < ApplicationController
	before_action :set_entity, only: [:show, :destroy, :stat_entity]
	skip_before_filter :verify_authenticity_token, :only => [:create, :destroy]

	def new
		@entity = Entity.new
	end
	def create
		@entity = Entity.new(post_params)
		@fake= Entity.where(name: @entity.name).take
		if @fake != nil
			@fake.destroy
			respond_to do |format|
           		format.json { head :no_content }
    		end
    	end
		if @entity.save
			@entity.tags.each do |f|
				f.increment(:count, by = 1)
				f.save
			end
			@entity.count= @entity.tags.size
			@entity.save
			respond_to do |format|
    			format.json { head :ok }
  			end
      	else
        	format.json { render json: @entity.errors, status: :unprocessable_entity }
      	end
	end
	def show
		@tags = @entity.tags
		render :json => {:entity => @entity.to_json(only: :name), :tags => @tags.to_json(only: :name)} 
	end
	def destroy
		@entity.destroy
		respond_to do |format|
           format.json { head :no_content }
    	end
	end
	def stats
		@tags = Tag.all.select("id","name","count")
		render json: @tags
	end
	def stat_entity
		render json: @entity.to_json(:only => [:id, :name, :count])
	end


	private
    	def post_params
    		params.require(:entity).permit(:name, tag_ids: [])
    	end
    	def set_entity
    		@entity= Entity.find(params[:id]) 
		end

end
