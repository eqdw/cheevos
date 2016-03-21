defmodule Cheevos.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :hash, :string
      add :recovery_hash, :string

      timestamps
    end

  end
end
