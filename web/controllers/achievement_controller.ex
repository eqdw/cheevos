defmodule Cheevos.AchievementController do
  use Cheevos.Web, :controller

  plug Addict.Plugs.Authenticated when not action in [:index, :show]

  plug :load_user_achievements

  alias Cheevos.Achievement

  def index(conn, _params, user) do
    achievements = Repo.all(Achievement)
    render(conn, "index.html", achievements: achievements)
  end

  def new(conn, _params, user) do
    changeset = Achievement.changeset(%Achievement{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"achievement" => achievement_params}, user) do
    changeset = Achievement.changeset(%Achievement{}, achievement_params)

    case Repo.insert(changeset) do
      {:ok, _achievement} ->
        conn
        |> put_flash(:info, "Achievement created successfully.")
        |> redirect(to: achievement_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    achievement = Repo.get!(Achievement, id)
    render(conn, "show.html", achievement: achievement)
  end

  def edit(conn, %{"id" => id}, user) do
    achievement = Repo.get!(Achievement, id)
    changeset = Achievement.changeset(achievement)
    render(conn, "edit.html", achievement: achievement, changeset: changeset)
  end

  def update(conn, %{"id" => id, "achievement" => achievement_params}, user) do
    achievement = Repo.get!(Achievement, id)
    changeset = Achievement.changeset(achievement, achievement_params)

    case Repo.update(changeset) do
      {:ok, achievement} ->
        conn
        |> put_flash(:info, "Achievement updated successfully.")
        |> redirect(to: achievement_path(conn, :show, achievement))
      {:error, changeset} ->
        render(conn, "edit.html", achievement: achievement, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    achievement = Repo.get!(Achievement, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(achievement)

    conn
    |> put_flash(:info, "Achievement deleted successfully.")
    |> redirect(to: achievement_path(conn, :index))
  end


  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
      [conn, conn.params, Addict.Helper.current_user(conn)])
  end

  defp load_user_achievements(conn, _) do
    achievements =
      Addict.Helper.current_user(conn)
      |> user_achievements
      |> Repo.all

    assign(conn, :user_achievements, achievements)
  end

  defp user_achievements(user) do
    assoc(user, :videos)
  end
end
