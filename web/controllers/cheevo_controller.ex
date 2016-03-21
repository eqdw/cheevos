defmodule Cheevos.CheevoController do
  use Cheevos.Web, :controller

  alias Cheevos.Cheevo

  plug :scrub_params, "cheevo" when action in [:create, :update]

  def index(conn, _params) do
    cheevos = Repo.all(Cheevo)
    render(conn, "index.html", cheevos: cheevos)
  end

  def new(conn, _params) do
    changeset = Cheevo.changeset(%Cheevo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"cheevo" => cheevo_params}) do
    changeset = Cheevo.changeset(%Cheevo{}, cheevo_params)

    case Repo.insert(changeset) do
      {:ok, _cheevo} ->
        conn
        |> put_flash(:info, "Cheevo created successfully.")
        |> redirect(to: cheevo_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cheevo = Repo.get!(Cheevo, id)
    render(conn, "show.html", cheevo: cheevo)
  end

  def edit(conn, %{"id" => id}) do
    cheevo = Repo.get!(Cheevo, id)
    changeset = Cheevo.changeset(cheevo)
    render(conn, "edit.html", cheevo: cheevo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "cheevo" => cheevo_params}) do
    cheevo = Repo.get!(Cheevo, id)
    changeset = Cheevo.changeset(cheevo, cheevo_params)

    case Repo.update(changeset) do
      {:ok, cheevo} ->
        conn
        |> put_flash(:info, "Cheevo updated successfully.")
        |> redirect(to: cheevo_path(conn, :show, cheevo))
      {:error, changeset} ->
        render(conn, "edit.html", cheevo: cheevo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cheevo = Repo.get!(Cheevo, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cheevo)

    conn
    |> put_flash(:info, "Cheevo deleted successfully.")
    |> redirect(to: cheevo_path(conn, :index))
  end
end
