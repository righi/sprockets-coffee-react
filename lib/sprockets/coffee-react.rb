require 'sprockets'
require 'coffee-react'
require 'sprockets/coffee-react-postprocessor'

module Sprockets
  # Preprocessor that runs CJSX source files through coffee-react-transform
  class CoffeeReact < Tilt::Template
    CJSX_EXTENSION = /\.(:?cjsx|coffee)[^\/]*?$/
    CJSX_PRAGMA = /^\s*#[ \t]*@cjsx/i

    def self.call(input)
      filename = input[:filename]
      source   = input[:data]
      context  = input[:environment].context_class.new(input)

      if filename =~ CJSX_EXTENSION || source =~ CJSX_PRAGMA
        ::CoffeeReact.transform(source)
      else
        source
      end
    end

    def self.install(environment = ::Sprockets)
      environment.register_mime_type 'text/cjsx', extensions: ['.cjsx', '.js.cjsx'], charset: :unicode
      environment.register_preprocessor 'application/javascript', Sprockets::CoffeeReact
      environment.register_postprocessor 'application/javascript', Sprockets::CoffeeReactPostprocessor
      environment.register_preprocessor 'text/cjsx', Sprockets::CoffeeReactScript
    end
  end
end
