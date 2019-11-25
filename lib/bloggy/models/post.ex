defmodule Bloggy.Models.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :approved, :boolean, default: false
    field :company_id, :integer
    field :content, :string
    field :created_by, :integer
    field :publish_date, :utc_datetime
    field :tag, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :created_by, :company_id, :approved, :tag, :publish_date])
    |> validate_required([
      :title,
      :content,
      :created_by,
      :company_id,
      # :approved,
      # :tag,
      :publish_date
    ])
  end
end
