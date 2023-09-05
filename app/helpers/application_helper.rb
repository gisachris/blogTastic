module ApplicationHelper
  Rails.application.routes.url_helpers.instance_methods.each do |method|
    if method.to_s.include?("_path")
      define_method(method) do |*args, **kwargs|
        Rails.application.routes.url_helpers.send(method, *args, **kwargs)
      end
    end
  end
end
