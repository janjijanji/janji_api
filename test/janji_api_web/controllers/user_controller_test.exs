defmodule JanjiApiWeb.UserControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.Accounts
  alias JanjiApi.Accounts.User
  alias JanjiApiWeb.UserView

  @invalid_attrs %{email: nil, name: nil, username: nil}

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert(:user, username: username)
      {:ok, jwt, claims} = Guardian.encode_and_sign(user)
      {:ok, conn: conn, user: user, jwt: jwt, claims: claims}
    else
      {:ok, conn: conn}
    end
  end

  @tag login_as: "test_user"
  describe "index" do
    test "lists all users", %{conn: conn, jwt: jwt} do
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(user_path(conn, :index))
      assert json_response(conn, 200) == render_json(UserView, "index.json", users: Accounts.list_users())
    end
  end

  describe "create user" do
    @tag login_as: "test_user"
    test "renders user when data is valid", %{conn: conn, jwt: jwt} do
      attrs = params_for(:user)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(user_path(conn, :create), user: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(user_path(conn, :show, id))
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "email" => attrs.email,
        "name" => attrs.name,
        "username" => attrs.username}
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    @tag login_as: "test_user"
    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user, jwt: jwt} do
      attrs = params_for(:user)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(user_path(conn, :update, user), user: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(user_path(conn, :show, id))
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "email" => attrs.email,
        "name" => attrs.name,
        "username" => attrs.username}
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, user: user, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    @tag login_as: "test_user"
    test "deletes chosen user", %{conn: conn, user: user, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(user_path(conn, :delete, user))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = insert(:user)
    {:ok, user: user}
  end
end
