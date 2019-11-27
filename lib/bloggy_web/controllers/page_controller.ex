defmodule BloggyWeb.PageController do
  use BloggyWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    render(conn, "index.html")
  end
end
