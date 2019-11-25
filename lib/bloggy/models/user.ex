defmodule Bloggy.Models.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bloggy.Models.{User, Encryption}

  schema "users" do
    field :company_id, :integer
    field :email, :string
    field :is_admin, :boolean, default: false, null: false
    field :name, :string
    field :password_hash, :string
    field :role, :string
    field :token, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :company_id, :password])
    |> validate_required([:email, :name, :company_id, :password])
    |> validate_format(:email, ~r/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> downcase_username
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)

    if password do
      password_hash = Encryption.hash_password(password)
      put_change(changeset, :password_hash, password_hash)
    else
      changeset
    end
  end

  defp downcase_username(changeset) do
    update_change(changeset, :email, &String.downcase/1)
  end
end
