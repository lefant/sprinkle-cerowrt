package :opkg_update do
  description "opkg update"
  runner "opkg update"
end

package :qos_scripts do
  description "qos-scripts package"

  requires :opkg_update

  opkg 'qos-scripts'

  verify do
    has_opkg 'qos-scripts'
  end
end

package :qos_config do
  description "qos config settings"

  download = opts[:download] || '100000'
  upload = opts[:upload] || '10000'

  requires :qos_scripts

  uci_set 'qos', 'enabled', '1'
  uci_set 'qos', 'download', download
  uci_set 'qos', 'upload', upload
end
