module Sprinkle
  module Installers
    # The Opkg package installer uses the +opkg+ command to install
    # packages.
    # 
    # == Example Usage
    #
    # First, a simple installation of the magic_beans package:
    #
    #   package :magic_beans do
    #     opkg 'magic_beans_package'
    #     verify { has_opkg 'magic_beans_package' }
    #   end
    class Opkg < PackageInstaller
      def initialize(parent, *packages, &block) #:nodoc:
        super parent, *packages, &block
      end

      auto_api
      
      verify_api do
        def has_opkg(package)
          @commands << "opkg list-installed #{package} | grep '^#{package}$'"
        end
      end

      protected

        def install_commands #:nodoc:
          "opkg install #{@packages.join(' ')}"
        end

    end
  end
end
