# elm-inertia-rails-starter

A starter template for using [Elm](https://elm-lang.org) with a [Rails](https://rubyonrails.org) backend (powered by [Inertia.js](https://inertiajs.com)).

## Local development

### Required software

Name | How to check
--- | ---
[Ruby v3.3.2+](https://www.ruby-lang.org) | `ruby -v`
[Rails v7.1.3+](https://rubyonrails.org) | `rails -v`
[sqlite v3.43.2+](https://sqlite.org) | `sqlite --version`
[Node.js v20.14.0+](https://nodejs.org) | `node -v`

### Running the web server

```sh
# Install ruby and node dependencies
bundle install
npm install

# Initialize the SQL database
rails db:migrate

# Runs the Rails server at http://localhost:3000
npm run dev
```
