module Sprinkle
  module Installers
    # The Uci installer uses the +uci+ command to set config keys on openwrt
    #
    # == Example Usage
    #
    # First, a simple installation of the magic_beans package:
    #
    #   package :magic_beans do
    #     opkg 'magic_beans_package'
    #     verify { has_opkg 'magic_beans_package' }
    #   end
    class Uci < Installer
      attr_accessor :section, :key, :value #:nodoc:
      
      api do
        def uci_set(section, key, value, options = {}, &block)
          install Uci.new(self, section, key, value, &block)
        end
      end

      def initialize(parent, section, key, value, options = {}, &block) #:nodoc:
        super parent, options, &block
        @section = section
        @key = key
        @value = value

        uci_commit
      end
      
      verify_api do
        def has_uci(key, value)
          @commands << "uci get #{key} | grep '^#{value}$'"
        end
      end

      protected
        def install_commands #:nodoc:
          "uci set #{@section}.#{@key}=#{@value}"
        end

        def uci_commit
          post :install, "uci commit #{@section}"
        end
    end
  end
end
