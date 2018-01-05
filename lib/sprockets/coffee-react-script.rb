require 'sprockets'
require 'coffee-react'
require 'coffee_script'

module Sprockets
  # Preprocessor that runs CJSX source files through coffee-react-transform
  # then compiles with coffee-script
  class CoffeeReactScript
    CJSX_EXTENSION = /\.cjsx[^\/]*?$/
    CJSX_PRAGMA = /^\s*#[ \t]*@cjsx/i

    def self.call(input)
      filename = input[:filename]
      source   = input[:data]

      if filename =~ /\.coffee\.cjsx/
        ::CoffeeReact.transform(source)
      elsif filename =~ CJSX_EXTENSION || source =~ CJSX_PRAGMA
        ::CoffeeScript.compile(::CoffeeReact.transform(source))
      else
        source
      end
    end
  end
end
