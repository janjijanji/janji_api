defmodule JanjiApi.PromiseMakerTest do
  use JanjiApi.DataCase

  alias JanjiApi.PromiseMakers.PromiseMaker

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PromiseMaker.changeset(%PromiseMaker{}, params_for(:promise_maker))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PromiseMaker.changeset(%PromiseMaker{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset full_name must be at least 3 chars long" do
    attrs = Map.put(params_for(:promise_maker), :full_name, "AA")
    changeset = PromiseMaker.changeset(%PromiseMaker{}, attrs)
    assert {:full_name, {"should be at least %{count} character(s)", count: 3, validation: :length, min: 3}} in changeset.errors
  end

  test "changeset gender must be either 'MALE' or 'FEMALE'" do
    attrs = Map.put(params_for(:promise_maker), :gender, "AA")
    changeset = PromiseMaker.changeset(%PromiseMaker{}, attrs)
    assert {:gender, {"is invalid", validation: :inclusion}} in changeset.errors
  end
end
