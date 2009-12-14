# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

require 'comparable_container'
class CompareProductsExtension < Spree::Extension
  version "1.0"
  description "Provides product comparison with other products with the same taxon"
  url "http://github.com/calas/spree-compare-products"

  def activate
    Taxonomy.class_eval do
      include ComparableContainer
    end

    Taxon.class_eval do
      include ComparableContainer

      def is_comparable?
        comparable? || taxonomy.comparable?
      end
    end
  end
end
