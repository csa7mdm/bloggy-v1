defmodule Bloggy.BusinessTest do
  use Bloggy.DataCase

  alias Bloggy.Business

  describe "companies" do
    alias Bloggy.Business.Company

    @valid_attrs %{name: "some name", parent_id: 42}
    @update_attrs %{name: "some updated name", parent_id: 43}
    @invalid_attrs %{name: nil, parent_id: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Business.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Business.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Business.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Business.create_company(@valid_attrs)
      assert company.name == "some name"
      assert company.parent_id == 42
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Business.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Business.update_company(company, @update_attrs)
      assert company.name == "some updated name"
      assert company.parent_id == 43
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Business.update_company(company, @invalid_attrs)
      assert company == Business.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Business.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Business.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Business.change_company(company)
    end
  end
end
