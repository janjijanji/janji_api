defmodule JanjiApi.PromiseMakers.PositionTest do
  use JanjiApi.DataCase

  alias JanjiApi.PromiseMakers.Position

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Position.changeset(%Position{}, params_for(:promise_maker_position))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Position.changeset(%Position{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset title must be at least 3 chars long" do
    attrs = Map.put(params_for(:promise_maker_position), :title, "AA")
    changeset = Position.changeset(%Position{}, attrs)
    assert {:title, {"should be at least %{count} character(s)", count: 3, validation: :length, min: 3}} in changeset.errors
  end
end
