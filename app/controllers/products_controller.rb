class ProductsController < ApplicationController
  def index
    @products = Product.order(:name)
    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv }
      # format.xls
    end
  end

  def create
    @products = Product.new(product_params)

    respond_to do |format|
      if @products.save
        format.html { redirect_to @products, notice: 'Company was successfully created.' }
        format.json { render action: 'show', status: :created, location: @products }
      else
        format.html { render action: 'new' }
        format.json { render json: @products.errors, status: :unprocessable_entity }
      end
    end
  end

  def import
    Product.import(params[:file])
    redirect_to root_url, notice: 'Products imported'
    p 'Products imported'
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :released_on, :price)
  end

end