module ComparableContainer
  def self.included(base)
    base.class_eval do
      preference :enable_product_comparison, :boolean, :default => false
      alias_method :comparable, :prefers_enable_product_comparison?
      alias_method :comparable?, :prefers_enable_product_comparison?
      alias_method :comparable=, :prefers_enable_product_comparison=
    end
  end
end
