defmodule JanjiApi.UserTest do
  use JanjiApi.DataCase

  alias JanjiApi.Accounts.User

  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, params_for(:user))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset does not accept long usernames" do
    attrs = Map.put(params_for(:user), :username, String.duplicate("a", 30))
    changeset = User.changeset(%User{}, attrs)
    assert {:username, {"should be at most %{count} character(s)", count: 20, validation: :length, max: 20}} in changeset.errors
  end

  test "registration_changeset password must be at least 6 chars long" do
    attrs = Map.put(params_for(:user), :password, "12345")
    changeset = User.registration_changeset(%User{}, attrs)
    assert {:password, {"should be at least %{count} character(s)", count: 6, validation: :length, min: 6}} in changeset.errors
  end

  test "registration_changeset with valid attributes hashes password" do
    attrs = Map.put(params_for(:user), :password, "123456")
    changeset = User.registration_changeset(%User{}, attrs)
    %{password: pass, password_hash: pass_hash} = changeset.changes

    assert changeset.valid?
    assert pass_hash
    assert Comeonin.Bcrypt.checkpw(pass, pass_hash)
  end
end
