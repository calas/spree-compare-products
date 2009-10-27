module CompareProductsHelper
  # Return the transposed matrix of the comparison table.
  #
  # Example:
  #   [
  #    ["Product", "product1 image", "product2 image"],
  #    ["Name",    "product1 name",  "product2 name"],
  #    ... # property fields
  #    ["Price", "product1 price", "product2 price"]
  #   ]
  def comparison_rows_for(products, properties)
    fields = [comparison_fields_for(products, properties)]
    products.each do |product|
      fields << (fields_for(product, properties))
    end
    fields.transpose
  end

  # Return an array with the values of the fields to be compared for
  # the specified product.
  #
  # Example:
  #   ["product1 image", "product1 name", ..., "product1 price"]
  def fields_for(product, properties)
    [ link_to(small_image(product), product), link_to(product.name, product)].tap { |fields|
      properties.each do |property|
        fields << product.product_properties.find_by_property_id(property.id).try(:value)
      end
    }.tap { |fields| fields << number_to_currency(product.price) }
  end

  # Returns an array with the translated names of the fields to be
  # compared.
  #
  # Example:
  #   ["Product", "Name", ..., "Price"]
  def comparison_fields_for(products, properties)
    [t('product'), t('name')].tap { |fields|
      properties.each { |property| fields << property.presentation }
    }.tap { |fields|
      fields << t('price')
    }
  end
end
