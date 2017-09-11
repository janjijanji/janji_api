defmodule JanjiApiWeb.PromiseControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.Promises
  alias JanjiApi.Promises.Promise
  alias JanjiApiWeb.PromiseView

  @invalid_attrs %{promise_maker_id: nil, title: nil, promised_at: nil, description: nil, inserted_by_id: nil}

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
    test "lists all promises", %{conn: conn, jwt: jwt} do
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_path(conn, :index))
      assert json_response(conn, 200) == render_json(PromiseView, "index.json", promises: Promises.list_promises())
    end
  end

  describe "create promise" do
    @tag login_as: "test_user"
    test "renders promise when data is valid", %{conn: conn, jwt: jwt, user: user} do
      attrs = params_with_assocs(:promise)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_path(conn, :create), promise: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise_maker"]["id"] == attrs.promise_maker_id
      assert resp["title"] == attrs.title
      {:ok, resp_promised_at} = NaiveDateTime.from_iso8601(resp["promised_at"])
      assert NaiveDateTime.compare(resp_promised_at, attrs.promised_at)
      assert resp["description"] == attrs.description
      assert resp["url"] == attrs.url
      assert resp["inserted_by"]["id"] == user.id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_path(conn, :create), promise: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promise" do
    setup [:create_promise]

    @tag login_as: "test_user"
    test "renders promise when data is valid",
      %{conn: conn, jwt: jwt, promise: %Promise{id: id} = promise} do

      attrs = params_with_assocs(:promise)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_path(conn, :update, promise), promise: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise_maker"]["id"] == attrs.promise_maker_id
      assert resp["title"] == attrs.title
      {:ok, resp_promised_at} = NaiveDateTime.from_iso8601(resp["promised_at"])
      assert NaiveDateTime.compare(resp_promised_at, attrs.promised_at)
      assert resp["description"] == attrs.description
      assert resp["url"] == attrs.url
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid",
      %{conn: conn, jwt: jwt, promise: promise} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_path(conn, :update, promise), promise: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promise" do
    setup [:create_promise]

    @tag login_as: "test_user"
    test "deletes chosen promise",
      %{conn: conn, jwt: jwt, promise: promise} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(promise_path(conn, :delete, promise))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_path(conn, :show, promise))
      end
    end
  end

  defp create_promise(_) do
    promise = insert(:promise)
    {:ok, promise: promise}
  end
end
