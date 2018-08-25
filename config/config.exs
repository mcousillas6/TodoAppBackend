# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todo_app,
  ecto_repos: [TodoApp.Repo]

# Configures the endpoint
config :todo_app, TodoAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C4V4x0zZGryYwZBdVi4Nha2Qz1x8dX6EFvrlruA1JjvaOm1hk2ILbxTVDPPbOzqs",
  render_errors: [view: TodoAppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: TodoApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Guardian configuration
config :todo_app, TodoApp.Guardian,
  issuer: "todo_app",
  secret_key:  "D/MzeGhkOOk+BgyRRjCcF+LZN4f+BYbTTej0cuKOXnwpLF1jJ8G9uSpUYxr4gPNK"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
