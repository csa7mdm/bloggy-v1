defmodule BloggyWeb.Router do
  use BloggyWeb, :router

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

  scope "/", BloggyWeb do
    pipe_through [:browser, BloggyWeb.Plugs.Guest]

    resources "/register", UserController, only: [:create, :new]
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", BloggyWeb do
    pipe_through [:browser, BloggyWeb.Plugs.Auth]

    get "/", PageController, :index

    delete "/logout", SessionController, :delete

    resources("/users", UserController, only: [:index, :show, :new, :create, :edit, :delete])

    resources("/companies", CompanyController, only: [:index, :show, :new, :create])

    resources("/posts", PostController, only: [:index, :show, :new, :create])
  end

  # Other scopes may use custom stacks.
  # scope "/api", BloggyWeb do
  #   pipe_through :api
  # end
end
