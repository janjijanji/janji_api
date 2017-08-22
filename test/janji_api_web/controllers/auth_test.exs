defmodule JanjiApiWeb.AuthTest do
  use JanjiApiWeb.ConnCase
  alias JanjiApiWeb.Auth

  test "call places user from guardian current_resource into assigns", %{conn: conn} do
    user = insert(:user)
    conn =
      conn
      |> Guardian.Plug.api_sign_in(user)
      |> Auth.call(%{})

    assert conn.assigns.current_user.id == user.id
  end

  test "call with nil guardian current_resource sets current_user assign to nil", %{conn: conn} do
    conn = Auth.call(conn, %{})
    assert conn.assigns.current_user == nil
  end

  test "unauthenticated return 401 response",
    %{conn: conn} do

    conn = Auth.unauthenticated(conn, [])
    assert json_response(conn, 401)["errors"] != %{detail: "Page not found"}
  end

  test "login sign in the user using Guardian", %{conn: conn} do
    user = insert(:user)
    {:ok, conn, _} = Auth.login(conn, user)
    assert Guardian.Plug.current_resource(conn).id == user.id
  end

  test "logout returns :ok when logout is succesful", %{conn: conn} do
    user = insert(:user)
    {:ok, conn, _} = Auth.login(conn, user)
    assert Auth.logout(conn) == :ok
  end

  test "login with a valid username and pass", %{conn: conn} do
    user = build(:user) |> set_password("secret") |> insert
    {:ok, conn, _} =
      Auth.login_by_username_and_pass(conn, user.username, "secret")

    assert Guardian.Plug.current_resource(conn).id == user.id
  end

  test "login with a not found user", %{conn: conn} do
    assert {:error, :not_found, _conn} =
      Auth.login_by_username_and_pass(conn, "me", "secret")
  end

  test "login with password mismatch", %{conn: conn} do
    user = build(:user) |> set_password("secret") |> insert
    assert {:error, :unauthorized, _conn} =
      Auth.login_by_username_and_pass(conn, user.username, "wrong")
  end
end
