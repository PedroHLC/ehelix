defmodule EHelixWeb.Router do
  use EHelixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1/", EHelixWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/account/login", PageController, :login
  end
end
