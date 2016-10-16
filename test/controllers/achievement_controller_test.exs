defmodule Cheevos.AchievementControllerTest do
  use Cheevos.ConnCase

  alias Cheevos.Achievement
  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, achievement_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing achievements"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, achievement_path(conn, :new)
    assert html_response(conn, 200) =~ "New achievement"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, achievement_path(conn, :create), achievement: @valid_attrs
    assert redirected_to(conn) == achievement_path(conn, :index)
    assert Repo.get_by(Achievement, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, achievement_path(conn, :create), achievement: @invalid_attrs
    assert html_response(conn, 200) =~ "New achievement"
  end

  test "shows chosen resource", %{conn: conn} do
    achievement = Repo.insert! %Achievement{}
    conn = get conn, achievement_path(conn, :show, achievement)
    assert html_response(conn, 200) =~ "Show achievement"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, achievement_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    achievement = Repo.insert! %Achievement{}
    conn = get conn, achievement_path(conn, :edit, achievement)
    assert html_response(conn, 200) =~ "Edit achievement"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    achievement = Repo.insert! %Achievement{}
    conn = put conn, achievement_path(conn, :update, achievement), achievement: @valid_attrs
    assert redirected_to(conn) == achievement_path(conn, :show, achievement)
    assert Repo.get_by(Achievement, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    achievement = Repo.insert! %Achievement{}
    conn = put conn, achievement_path(conn, :update, achievement), achievement: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit achievement"
  end

  test "deletes chosen resource", %{conn: conn} do
    achievement = Repo.insert! %Achievement{}
    conn = delete conn, achievement_path(conn, :delete, achievement)
    assert redirected_to(conn) == achievement_path(conn, :index)
    refute Repo.get(Achievement, achievement.id)
  end
end
