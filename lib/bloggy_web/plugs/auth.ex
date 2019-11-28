defmodule BloggyWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias Bloggy.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    if user_id = Plug.Conn.get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)

      conn = assign(conn, :current_user, current_user)

      case current_user.role do
        "0" ->
          conn
          |> assign(:current_user_role, "Owner")

        "1" ->
          conn
          |> assign(:current_user_role, "Admin")

        "2" ->
          conn |> assign(:current_user_role, "Editor")

        "3" ->
          conn |> assign(:current_user_role, "Journalist")

        "4" ->
          conn |> assign(:current_user_role, "Outsource")

        "5" ->
          conn |> assign(:current_user_role, "Admin")
      end
    else
      conn
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
