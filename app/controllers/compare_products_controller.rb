class CompareProductsController < Spree::BaseController
  before_filter :find_taxon
  before_filter :verify_comparable_taxonomy
  before_filter :find_products

  helper :products, :taxons

  # We return the list of properties here so we can use them latter.
  def show
    @properties = @products.map(&:properties).flatten.uniq
  end

  private

  # Find the taxon from the url
  def find_taxon
    @taxon = Taxon.find_by_permalink("#{params[:taxon_path].join('/')}/")
    if @taxon.nil?
      flash[:error] = I18n.t('compare_products.invalid_taxon')
      redirect_to products_path
    end
  end

  # Verifies that the comparison can be made inside this taxon.
  def verify_comparable_taxonomy
    if !@taxon.taxonomy.comparable?
      flash[:error] = I18n.t('compare_products.taxon_not_comparable')
      redirect_to "/t/#{@taxon.permalink}"
    end
  end

  # Find the products inside the taxon, manually adding product ids to
  # the url will silently be ignored if they can't be compared inside
  # the taxon or don't exists.
  def find_products
    @products = @taxon.products.find(:all, :conditions => { :id => params[:product_ids]},
                                     :include => { :product_properties => :property },
                                     :limit => 4)
    if @products.length < 2
      flash[:error] = I18n.t('compare_products.insufficient_data')
      redirect_to "/t/#{@taxon.permalink}"
    end
  end
end
