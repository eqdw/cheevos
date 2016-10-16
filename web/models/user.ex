defmodule Cheevos.User do
  use Cheevos.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :encrypted_password, :string

    timestamps()
  end

  @required_fields ~w(name email encrypted_password)
  @optional_fields ~w()


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
  end

  def validate({valid, errors}, user_params) do
    {valid, errors}
  end
end
