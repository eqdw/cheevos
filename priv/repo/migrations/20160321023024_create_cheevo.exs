defmodule Cheevos.Repo.Migrations.CreateCheevo do
  use Ecto.Migration

  def change do
    create table(:cheevos) do
      add :name, :string
      add :description, :string
      add :achieved, :boolean, default: false

      timestamps
    end

  end
end
