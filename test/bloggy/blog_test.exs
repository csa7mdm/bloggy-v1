defmodule Bloggy.BlogTest do
  use Bloggy.DataCase

  alias Bloggy.Blog

  describe "posts" do
    alias Bloggy.Blog.Post

    @valid_attrs %{approved: true, company_id: 42, content: "some content", created_by: 42, publish_date: "2010-04-17T14:00:00Z", tag: "some tag", title: "some title"}
    @update_attrs %{approved: false, company_id: 43, content: "some updated content", created_by: 43, publish_date: "2011-05-18T15:01:01Z", tag: "some updated tag", title: "some updated title"}
    @invalid_attrs %{approved: nil, company_id: nil, content: nil, created_by: nil, publish_date: nil, tag: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.approved == true
      assert post.company_id == 42
      assert post.content == "some content"
      assert post.created_by == 42
      assert post.publish_date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert post.tag == "some tag"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.approved == false
      assert post.company_id == 43
      assert post.content == "some updated content"
      assert post.created_by == 43
      assert post.publish_date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert post.tag == "some updated tag"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end
end
