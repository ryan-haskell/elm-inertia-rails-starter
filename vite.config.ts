import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import elm from 'vite-plugin-elm-watch'
import FullReload from 'vite-plugin-full-reload'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*']),
    elm(),
  ],
})
