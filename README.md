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
# Runs a server at http://localhost:3000
bin/rails server
```

## Manual setup steps

If you'd prefer to set things up from scratch, here are all the terminal commands I ran to set up this template:

__Outline__:
1. [Creating a Rails app](#1-creating-a-new-rails-app)

### 1. Creating a new Rails app

__In the terminal__

```sh
# Create a new minimal Rails app
rails new elm-inertia-rails-starter --minimal

# Enter the new project folder
cd elm-inertia-rails-starter

# Generate an "Articles" controller
rails generate controller Articles index

# Generate an "Article" model
rails generate model Article title:string body:text

# Run database migration to create "articles" table
rails db:migrate

# Start a rails console session
rails console
```

__Within that new rails console__

```rb
# Define a new article
article = Article.new(title: "Hello Rails", body: "I am on Rails!")
# Insert it into the SQL database
article.save
```

__In your `Gemfile`__

```sh
# Inertia.js Rails adapter
gem 'inertia_rails'

# Vite support for rails
gem 'vite_rails'
```

__In the terminal__

```sh
# Install new Gem
bin/bundle install

# Set up your Vite project
bin/bundle exec vite install

# Install Elm dependencies
npm install -D elm-inertia vite-plugin-elm-watch

# Create a new Elm project in "app/elm"
npx elm-inertia init

# Add an Elm page to handle the "Articles#index" action
npx elm-inertia add Articles/Index

# Run the Rails server (in another tab)
rails server
```
