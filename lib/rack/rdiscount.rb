# Copyright: Savonix Corporation, 2009
# Author:    Albert Lash
# License:   MIT
require "rdiscount"

module Rack
  class RackDiscount
    def initialize(app, options)
      @my_path_info = String.new
      @app = app
    end

    def call(env)
      status, headers, @response = @app.call(env)
      [status, headers, self]
    end

    def each(&block)
      @response.each { |x|
        yield RDiscount.new(x).to_html
      }
    end
  end
end
