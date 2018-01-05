require 'sprockets'
require 'coffee-react'

module Sprockets
  class CoffeeReactPostprocessor

    def self.call(input)
      ::CoffeeReact.jstransform(input[:data])
    end
  end
end
