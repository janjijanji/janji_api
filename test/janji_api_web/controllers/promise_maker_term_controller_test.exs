defmodule JanjiApiWeb.PromiseMakerTermControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.PromiseMakers
  alias JanjiApi.PromiseMakers.Term
  alias JanjiApiWeb.PromiseMakerTermView

  @invalid_attrs %{promise_maker_position: nil, promise_maker: nil, from_time: nil, inserted_by: nil}

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
    test "lists all promise_maker_terms", %{conn: conn, jwt: jwt} do
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_maker_term_path(conn, :index))
      assert json_response(conn, 200) == render_json(PromiseMakerTermView, "index.json", promise_maker_terms: PromiseMakers.list_terms())
    end
  end

  describe "create promise_maker_term" do
    @tag login_as: "test_user"
    test "renders promise_maker_term when data is valid", %{conn: conn, jwt: jwt} do
      attrs = params_with_assocs(:promise_maker_term)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_maker_term_path(conn, :create), promise_maker_term: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_maker_term_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise_maker_position"]["id"] == attrs.promise_maker_position_id
      assert resp["promise_maker"]["id"] == attrs.promise_maker_id
      {:ok, resp_from_time} = NaiveDateTime.from_iso8601(resp["from_time"])
      assert NaiveDateTime.compare(resp_from_time, attrs.from_time)
      {:ok, resp_thru_time} = NaiveDateTime.from_iso8601(resp["thru_time"])
      assert NaiveDateTime.compare(resp_thru_time, attrs.thru_time)
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_maker_term_path(conn, :create), promise_maker_term: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promise_maker_term" do
    setup [:create_promise_maker_term]

    @tag login_as: "test_user"
    test "renders promise_maker_term when data is valid",
      %{conn: conn, jwt: jwt, promise_maker_term: %Term{id: id} = promise_maker_term} do

      attrs = params_with_assocs(:promise_maker_term)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_maker_term_path(conn, :update, promise_maker_term), promise_maker_term: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_maker_term_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise_maker_position"]["id"] == attrs.promise_maker_position_id
      assert resp["promise_maker"]["id"] == attrs.promise_maker_id
      {:ok, resp_from_time} = NaiveDateTime.from_iso8601(resp["from_time"])
      assert NaiveDateTime.compare(resp_from_time, attrs.from_time)
      {:ok, resp_thru_time} = NaiveDateTime.from_iso8601(resp["thru_time"])
      assert NaiveDateTime.compare(resp_thru_time, attrs.thru_time)
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid",
      %{conn: conn, jwt: jwt, promise_maker_term: promise_maker_term} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_maker_term_path(conn, :update, promise_maker_term), promise_maker_term: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promise_maker_term" do
    setup [:create_promise_maker_term]

    @tag login_as: "test_user"
    test "deletes chosen promise_maker_term",
      %{conn: conn, jwt: jwt, promise_maker_term: promise_maker_term} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(promise_maker_term_path(conn, :delete, promise_maker_term))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_maker_term_path(conn, :show, promise_maker_term))
      end
    end
  end

  defp create_promise_maker_term(_) do
    promise_maker_term = insert(:promise_maker_term)
    {:ok, promise_maker_term: promise_maker_term}
  end
end
