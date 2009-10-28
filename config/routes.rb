# Put your extension routes here.
map.compare_products '/compare_products', :controller => 'compare_products', :action => 'show'
map.connect '/t/*taxon_path/compare/*product_id', :controller => 'compare_products', :action => 'show'

# map.namespace :admin do |admin|
#   admin.resources :whatever
# end
