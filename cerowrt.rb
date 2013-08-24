$: << File.dirname(__FILE__)

require 'installers/opkg'
require 'installers/uci'
require 'packages/qos'

policy :cerowrt, :roles => :app do
  requires :qos_config
end

deployment do
  delivery :ssh do
    roles :app => 'test.com'
  end
end
