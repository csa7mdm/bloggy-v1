defmodule BloggyWeb.CompanyController do
  use BloggyWeb, :controller

  alias Bloggy.Business
  alias Bloggy.Models.Company

  # plug(BloggyWeb.Plugs.Auth)

  def index(conn, _params) do
    companies = Business.list_companies()
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = Business.change_company(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    case Business.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Business.get_company!(id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Business.get_company!(id)
    changeset = Business.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Business.get_company!(id)

    case Business.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Business.get_company!(id)
    {:ok, _company} = Business.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: Routes.company_path(conn, :index))
  end
end
