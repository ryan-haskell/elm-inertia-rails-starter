# elm-inertia-rails-starter

A starter template for using [Elm](https://elm-lang.org) with a [Rails](https://rubyonrails.org) backend (powered by [Inertia.js](https://inertiajs.com)).

## Local development

### Required software

Name | How to check
--- | ---
[Ruby v3.3.2+](https://www.ruby-lang.org) | `ruby -v`
[Rails v7.1.3+](https://rubyonrails.org) | `rails -v`
[sqlite v3.43.2+](https://sqlite.org) | `sqlite -v`
[Node.js v20.14.0+](https://nodejs.org) | `node -v`

### Running the web server

```sh
bin/rails server
```

## Setup steps

If you'd rather set things up manually, here were all the terminal commands I ran to set up this template:

```sh
# Create a new minimal Rails app
rails new elm-inertia-rails-starter --minimal

# Enter the new project folder
cd elm-inertia-rails-starter

# Ran the Rails server (in another tab)
bin/rails server
```