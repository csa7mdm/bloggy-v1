defmodule BloggyWeb.Plugs.Jouralist do
  import Plug.Conn
  import Phoenix.Controller

  alias Bloggy.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    if user_id = Plug.Conn.get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)

      if current_user.role == 3 do
        conn
        |> assign(:current_user_role, "Journalist")
      else
        conn
        |> redirect(to: "/login")
        |> halt()
      end
    else
      conn
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
