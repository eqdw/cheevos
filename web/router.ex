defmodule Cheevos.Router do
  use Cheevos.Web, :router
  use Addict.RoutesHelper

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Cheevos do
    pipe_through :browser # Use the default browser stack

    addict :routes

    get "/", PageController, :index

    resources "/cheevos", CheevoController
    resources "/users",   UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Cheevos do
  #   pipe_through :api
  # end
end
