defmodule JanjiApiWeb.PromiseNewsControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.Promises
  alias JanjiApi.Promises.News
  alias JanjiApiWeb.PromiseNewsView

  @invalid_attrs %{promise_id: nil, title: nil, body: nil, inserted_by_id: nil}

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
    test "lists all promise_news", %{conn: conn, jwt: jwt} do
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_news_path(conn, :index))
      assert json_response(conn, 200) == render_json(PromiseNewsView, "index.json", promise_news: Promises.list_news())
    end
  end

  describe "create promise_news" do
    @tag login_as: "test_user"
    test "renders promise_news when data is valid", %{conn: conn, jwt: jwt} do
      attrs = params_with_assocs(:promise_news)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_news_path(conn, :create), promise_news: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_news_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise"]["id"] == attrs.promise_id
      assert resp["title"] == attrs.title
      {:ok, resp_published_at} = NaiveDateTime.from_iso8601(resp["published_at"])
      assert NaiveDateTime.compare(resp_published_at, attrs.published_at)
      assert resp["summary"] == attrs.summary
      assert resp["body"] == attrs.body
      assert resp["url"] == attrs.url
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_news_path(conn, :create), promise_news: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promise_news" do
    setup [:create_promise_news]

    @tag login_as: "test_user"
    test "renders promise_news when data is valid",
      %{conn: conn, jwt: jwt, promise_news: %News{id: id} = promise_news} do

      attrs = params_with_assocs(:promise_news)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_news_path(conn, :update, promise_news), promise_news: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_news_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise"]["id"] == attrs.promise_id
      assert resp["title"] == attrs.title
      {:ok, resp_published_at} = NaiveDateTime.from_iso8601(resp["published_at"])
      assert NaiveDateTime.compare(resp_published_at, attrs.published_at)
      assert resp["summary"] == attrs.summary
      assert resp["body"] == attrs.body
      assert resp["url"] == attrs.url
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid",
      %{conn: conn, jwt: jwt, promise_news: promise_news} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_news_path(conn, :update, promise_news), promise_news: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promise_news" do
    setup [:create_promise_news]

    @tag login_as: "test_user"
    test "deletes chosen promise_news",
      %{conn: conn, jwt: jwt, promise_news: promise_news} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(promise_news_path(conn, :delete, promise_news))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_news_path(conn, :show, promise_news))
      end
    end
  end

  defp create_promise_news(_) do
    promise_news = insert(:promise_news)
    {:ok, promise_news: promise_news}
  end
end
