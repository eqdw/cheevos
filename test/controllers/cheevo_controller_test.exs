defmodule Cheevos.CheevoControllerTest do
  use Cheevos.ConnCase

  alias Cheevos.Cheevo
  @valid_attrs %{achieved: true, description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cheevo_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing cheevos"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, cheevo_path(conn, :new)
    assert html_response(conn, 200) =~ "New cheevo"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, cheevo_path(conn, :create), cheevo: @valid_attrs
    assert redirected_to(conn) == cheevo_path(conn, :index)
    assert Repo.get_by(Cheevo, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cheevo_path(conn, :create), cheevo: @invalid_attrs
    assert html_response(conn, 200) =~ "New cheevo"
  end

  test "shows chosen resource", %{conn: conn} do
    cheevo = Repo.insert! %Cheevo{}
    conn = get conn, cheevo_path(conn, :show, cheevo)
    assert html_response(conn, 200) =~ "Show cheevo"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, cheevo_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    cheevo = Repo.insert! %Cheevo{}
    conn = get conn, cheevo_path(conn, :edit, cheevo)
    assert html_response(conn, 200) =~ "Edit cheevo"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    cheevo = Repo.insert! %Cheevo{}
    conn = put conn, cheevo_path(conn, :update, cheevo), cheevo: @valid_attrs
    assert redirected_to(conn) == cheevo_path(conn, :show, cheevo)
    assert Repo.get_by(Cheevo, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cheevo = Repo.insert! %Cheevo{}
    conn = put conn, cheevo_path(conn, :update, cheevo), cheevo: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit cheevo"
  end

  test "deletes chosen resource", %{conn: conn} do
    cheevo = Repo.insert! %Cheevo{}
    conn = delete conn, cheevo_path(conn, :delete, cheevo)
    assert redirected_to(conn) == cheevo_path(conn, :index)
    refute Repo.get(Cheevo, cheevo.id)
  end
end
