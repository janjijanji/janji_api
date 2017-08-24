defmodule JanjiApiWeb.PromiseMakerControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.PromiseMakers
  alias JanjiApi.PromiseMakers.PromiseMaker
  alias JanjiApiWeb.PromiseMakerView

  @invalid_attrs %{full_name: nil, inserted_by_id: nil}

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
    test "lists all promise_makers", %{conn: conn, jwt: jwt} do
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_maker_path(conn, :index))
      assert json_response(conn, 200) == render_json(PromiseMakerView, "index.json", promise_makers: PromiseMakers.list_promise_makers())
    end
  end

  describe "create promise_maker" do
    @tag login_as: "test_user"
    test "renders promise_maker when data is valid", %{conn: conn, jwt: jwt} do
      attrs = params_with_assocs(:promise_maker)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_maker_path(conn, :create), promise_maker: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_maker_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["full_name"] == attrs.full_name
      assert resp["gender"] == attrs.gender
      assert resp["birthplace"] == attrs.birthplace
      assert resp["birthdate"] == Date.to_iso8601(attrs.birthdate)
      assert resp["bio"] == attrs.bio
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_maker_path(conn, :create), promise_maker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promise_maker" do
    setup [:create_promise_maker]

    @tag login_as: "test_user"
    test "renders promise_maker when data is valid",
      %{conn: conn, jwt: jwt, promise_maker: %PromiseMaker{id: id} = promise_maker} do

      attrs = params_with_assocs(:promise_maker)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_maker_path(conn, :update, promise_maker), promise_maker: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_maker_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["full_name"] == attrs.full_name
      assert resp["gender"] == attrs.gender
      assert resp["birthplace"] == attrs.birthplace
      assert resp["birthdate"] == Date.to_iso8601(attrs.birthdate)
      assert resp["bio"] == attrs.bio
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid",
      %{conn: conn, jwt: jwt, promise_maker: promise_maker} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_maker_path(conn, :update, promise_maker), promise_maker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promise_maker" do
    setup [:create_promise_maker]

    @tag login_as: "test_user"
    test "deletes chosen promise_maker",
      %{conn: conn, jwt: jwt, promise_maker: promise_maker} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(promise_maker_path(conn, :delete, promise_maker))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_maker_path(conn, :show, promise_maker))
      end
    end
  end

  defp create_promise_maker(_) do
    promise_maker = insert(:promise_maker)
    {:ok, promise_maker: promise_maker}
  end
end
