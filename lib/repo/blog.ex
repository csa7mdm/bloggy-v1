defmodule Bloggy.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Bloggy.Repo

  alias Bloggy.Models.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Gets User posts.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_user_posts!(123)
      %Post{}

      iex> get_user_posts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_posts!(user_id) do
    # Create a query
    # where = [id: user_id]
    # order_by = [desc: :published_at]
    # select = [:id, :title, :body]
    query = from u in Post, where: u.created_by == ^user_id
    # , order_by: ^order_by, select: ^select

    IO.inspect(Repo.all(query))
  end

  @doc """
  Gets Company posts.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_company_posts!(123)
      %Post{}

      iex> get_company_posts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company_posts!(company_id) do
    # Create a query
    where = [id: company_id]
    # order_by = [desc: :published_at]
    # select = [:id, :title, :body]
    query = from u in Post, where: u.company_id == ^where
    # , order_by: ^order_by, select: ^select
    # select: u.name

    IO.inspect(Repo.all(query))
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
