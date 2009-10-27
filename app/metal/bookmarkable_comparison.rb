class BookmarkableComparison
  def self.call(env)
    req = Rack::Request.new(env)
    if req.path_info =~ /^\/compare_products/
      products = (req.params['product_id'] || []).join('/')
      url = "/t/#{req.params['taxon']}/compare/#{products}"
      return [303, {"Location" => url}, []]
    end
    [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  end
end
