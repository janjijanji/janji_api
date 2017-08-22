defmodule JanjiApiWeb.SessionControllerTest do
  use JanjiApiWeb.ConnCase

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert(:user, username: username)
      {:ok, jwt, claims} = Guardian.encode_and_sign(user)
      {:ok, conn: conn, user: user, jwt: jwt, claims: claims}
    else
      {:ok, conn: conn}
    end
  end

  describe "create session" do
    test "renders login.json when credential is valid", %{conn: conn} do
      user = build(:user) |> set_password("secret") |> insert

      conn = post conn, "/api/login", session: %{username: user.username, password: "secret"}
      assert %{"jwt" => _jwt, "exp" => _exp} = json_response(conn, 200)["data"]
    end

    test "renders errors when credential is invalid", %{conn: conn} do
      user = build(:user) |> set_password("secret") |> insert
      conn = post conn, session_path(conn, :create),
        session: %{username: user.username, password: "wrong"}
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete session" do

    @tag login_as: "test_user"
    test "if called when still logged in, renders logout.json", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete("/api/logout")
      assert response(conn, 204)
    end
  end
end
