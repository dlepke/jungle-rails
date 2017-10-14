class ReviewsController < ApplicationController

    
    def create
        @review = Review.new(review_params)
        @product = Product.find(params[:product_id])

        @review.user = current_user
        @review.product = @product

        @review.save

        if @review.save
            redirect_to product_path(@product)
        else 
            redirect_to product_path(@product)
        end
    end

    def destroy
        @product = Product.find(params[:product_id])
        @review = @product.reviews.find(params[:id])
        @review.destroy

        redirect_to product_path(@product)
    end

    private
    def review_params
        params.require(:review).permit(:rating, :description)
    end
end
