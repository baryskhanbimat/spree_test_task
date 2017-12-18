class VariantsController < ApplicationController
  def index
    @variants = Variant.order(:name)
    respond_to do |format|
      format.html
      format.csv { send_data @variants.to_csv }
      # format.xls
    end
  end

  def import
    Variant.import(params[:file])
    redirect_to root_url, notice: 'Products imported'
    p 'Products imported'
  end
end
