defmodule BloggyWeb.PostController do
  use BloggyWeb, :controller

  alias Bloggy.Blog
  alias Bloggy.Models.Post

  def index(conn, _params) do
    IO.inspect(conn)

    if conn.assigns[:current_user_role] == "Owner" or conn.assigns[:current_user_role] == "Admin" do
      posts = Blog.list_posts()

      render(conn, "index.html", posts: posts)
    else
      user_id = Plug.Conn.get_session(conn, :current_user_id)
      posts = Blog.get_user_posts!(user_id)
      render(conn, "index.html", posts: posts)
    end

    # posts = Blog.list_posts()
  end

  # def index_super(conn, _params) do
  #   posts = Blog.list_posts()
  #   render(conn, "index.html", posts: posts)

  # end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end
