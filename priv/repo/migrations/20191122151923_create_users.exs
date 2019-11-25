defmodule Bloggy.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :company_id, :integer
      add :password_hash, :string
      add :is_admin, :boolean, default: false, null: false
      add :token, :string
      add :role, :string

      timestamps()
    end

  end
end
