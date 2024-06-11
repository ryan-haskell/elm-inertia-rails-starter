InertiaRails.configure do |config|
  config.version = ViteRuby.digest
  config.default_render = true
  config.ssr_enabled = false
  config.deep_merge_shared_data = false
end