defmodule Bloggy.Helpers.Auth do
  alias Bloggy.Models.{Encryption, User}
  alias Bloggy.Repo

  # def login(params, repo) do
  def login(params) do
    user = Repo.get_by(User, email: String.downcase(params["username"]))

    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp authenticate(user, password) do
    if user do
      {:ok, authenticated_user} = Encryption.validate_password(user, password)
      authenticated_user.email == user.email
    else
      nil
    end
  end

  def signed_in?(conn) do
    conn.assigns[:current_user]
  end

  def signed_in_role?(conn) do
    conn.assigns[:current_user_role]
  end
end
