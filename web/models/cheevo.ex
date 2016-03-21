defmodule Cheevos.Cheevo do
  use Cheevos.Web, :model

  schema "cheevos" do
    field :name, :string
    field :description, :string
    field :achieved, :boolean, default: false

    timestamps
  end

  @required_fields ~w(name description achieved)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
