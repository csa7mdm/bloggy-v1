defmodule Bloggy.Models.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :name, :string
    field :parent_id, :integer

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :parent_id])
    |> validate_required([:name, :parent_id])
  end
end
