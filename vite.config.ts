import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import elm from 'vite-plugin-elm-watch'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    elm(),
  ],
})
