# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cheevos,
  ecto_repos: [Cheevos.Repo]

# Configures the endpoint
config :cheevos, Cheevos.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EPr6oEi9VfjsCknhHvflQxqMeWQ0NJ/gbmEEk/n50T5xvVfbGAKOYJeGl712DOXM",
  render_errors: [view: Cheevos.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cheevos.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :addict,
  secret_key: "243262243132246e442f414571666e756b70316a6c66543348417a5175",
  extra_validation: fn ({valid, errors}, user_params) -> {valid, errors} end, # define extra validation here
  user_schema: Cheevos.User,
  repo: Cheevos.Repo,
  from_email: "no-reply@example.com", # CHANGE THIS
mail_service: nil