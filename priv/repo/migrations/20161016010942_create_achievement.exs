defmodule Cheevos.Repo.Migrations.CreateAchievement do
  use Ecto.Migration

  def change do
    create table(:achievements) do
      add :title, :string
      add :description, :string

      timestamps()
    end

  end
end
