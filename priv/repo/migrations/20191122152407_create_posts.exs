defmodule Bloggy.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text
      add :created_by, :integer
      add :company_id, :integer
      add :approved, :boolean, default: false, null: false
      add :tag, :string
      add :publish_date, :utc_datetime

      timestamps()
    end

  end
end
