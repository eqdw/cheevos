defmodule Cheevos.CheevoTest do
  use Cheevos.ModelCase

  alias Cheevos.Cheevo

  @valid_attrs %{achieved: true, description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cheevo.changeset(%Cheevo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cheevo.changeset(%Cheevo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
