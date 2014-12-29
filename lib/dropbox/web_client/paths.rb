module Dropbox
  module WebClient
    
    module Paths
      @@endpoint = "https://www.dropbox.com"      
      @@paths = {
        :login          => "/login",
        :post_login     => "/ajax_login",
        :invite         => "/share_ajax/existing",
        :invite_more    => "/share_ajax/invite_more",
        :share_options  => "/share_options/:path"
      }

      private

      def url_from_path(path, *arguments)
        _path = path.dup
        options = arguments.last.is_a?(Hash) ? arguments.pop : {}
        options.each { |key, value| _path.gsub!(":#{key}", value) }
        _path.gsub! "//", "/"

        URI.encode(File.join(@@endpoint, _path))
      end

      def method_missing(method_sym, *arguments, &block)
        if (method_sym.to_s =~ /^(.*)_url$/) == 0 and @@paths.keys.include?(path = $1.to_sym)
          return url_from_path(@@paths[path], *arguments)
        else
          super
        end
      end
    end
    
  end
end