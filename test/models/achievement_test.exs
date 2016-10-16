defmodule Cheevos.AchievementTest do
  use Cheevos.ModelCase

  alias Cheevos.Achievement

  @valid_attrs %{description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Achievement.changeset(%Achievement{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Achievement.changeset(%Achievement{}, @invalid_attrs)
    refute changeset.valid?
  end
end
