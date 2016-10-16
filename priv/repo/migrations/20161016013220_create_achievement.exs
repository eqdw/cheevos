defmodule Cheevos.Repo.Migrations.CreateAchievement do
  use Ecto.Migration

  def change do
    create table(:achievements) do
      add :title, :string
      add :description, :string
      add :creator_id, references(:users)

      timestamps()
    end

  end
end
