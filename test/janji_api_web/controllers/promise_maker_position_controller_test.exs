defmodule JanjiApiWeb.PromiseMakerPositionControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.PromiseMakers
  alias JanjiApi.PromiseMakers.Position
  alias JanjiApiWeb.PromiseMakerPositionView

  @invalid_attrs %{title: nil, inserted_by: nil}

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
    test "lists all promise_maker_positions", %{conn: conn, jwt: jwt} do
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_maker_position_path(conn, :index))
      assert json_response(conn, 200) == render_json(PromiseMakerPositionView, "index.json", promise_maker_positions: PromiseMakers.list_positions())
    end
  end

  describe "create promise_maker_position" do
    @tag login_as: "test_user"
    test "renders promise_maker_position when data is valid", %{conn: conn, jwt: jwt} do
      attrs = params_with_assocs(:promise_maker_position)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_maker_position_path(conn, :create), promise_maker_position: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_maker_position_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["title"] == attrs.title
      assert resp["description"] == attrs.description
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_maker_position_path(conn, :create), promise_maker_position: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promise_maker_position" do
    setup [:create_promise_maker_position]

    @tag login_as: "test_user"
    test "renders promise_maker_position when data is valid",
      %{conn: conn, jwt: jwt, promise_maker_position: %Position{id: id} = promise_maker_position} do

      attrs = params_with_assocs(:promise_maker_position)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_maker_position_path(conn, :update, promise_maker_position), promise_maker_position: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_maker_position_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["title"] == attrs.title
      assert resp["description"] == attrs.description
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid",
      %{conn: conn, jwt: jwt, promise_maker_position: promise_maker_position} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_maker_position_path(conn, :update, promise_maker_position), promise_maker_position: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promise_maker_position" do
    setup [:create_promise_maker_position]

    @tag login_as: "test_user"
    test "deletes chosen promise_maker_position",
      %{conn: conn, jwt: jwt, promise_maker_position: promise_maker_position} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(promise_maker_position_path(conn, :delete, promise_maker_position))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_maker_position_path(conn, :show, promise_maker_position))
      end
    end
  end

  defp create_promise_maker_position(_) do
    promise_maker_position = insert(:promise_maker_position)
    {:ok, promise_maker_position: promise_maker_position}
  end
end
