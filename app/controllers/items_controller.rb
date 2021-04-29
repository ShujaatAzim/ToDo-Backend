class ItemsController < ApplicationController

	skip_before_action :authorized #only for dev purposes

	def index
		@items = Item.all
		render json: ItemSerializer.new(@items).to_serialized_json
		# render json: current_user.lists  <-- this is for testing what gets shown upon authorized request
	end

	def show
		@item = Item.where(list_id: params[:id])
		render json: ItemSerializer.new(@item).to_serialized_json
	end

	def create
		@item = Item.new(item_params)
		@item.save
		render json: ItemSerializer.new(@item).to_serialized_json
	end

	def update
		@item = Item.find(params[:id])
		@item.update(content: params[:content], complete: params[:complete])
		@item.save
		render json: ItemSerializer.new(@item).to_serialized_json
	end

	def destroy
		@item = Item.find(params[:id])
		@item.destroy
	end

	private

	def item_params
		params.require(:item).permit(:list_id, :content, :complete)
	end

end
