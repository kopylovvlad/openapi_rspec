module OpenapiRspec
  module Helpers
    def request_params(metadata)
      {}.tap do |hash|
        hash[:method] = defined?(http_method) ? http_method : metadata[:method]
        hash[:path] = defined?(uri) ? uri : metadata[:uri]
        hash[:media_type] = openapi_rspec_media_type if defined? openapi_rspec_media_type
        hash[:params] = path_params(hash[:path])
        hash[:params].merge!(openapi_rspec_params) if defined? openapi_rspec_params
        hash[:headers] = openapi_rspec_headers if defined? openapi_rspec_headers
        hash[:query] = openapi_rspec_query if defined? openapi_rspec_query
      end
    end

    def path_params(path)
      path_params = {}
      path.scan(/\{([^\}]*)\}/).each do |param|
        key = param.first.to_sym
        path_params[key] = public_send(key) if respond_to?(key)
      end
      path_params
    end
  end
end
