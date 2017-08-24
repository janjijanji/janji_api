defmodule JanjiApiWeb.PromisePostControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.Promises
  alias JanjiApi.Promises.Post
  alias JanjiApiWeb.PromisePostView

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
    test "lists all promise_posts", %{conn: conn, jwt: jwt} do
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_post_path(conn, :index))
      assert json_response(conn, 200) == render_json(PromisePostView, "index.json", promise_posts: Promises.list_posts())
    end
  end

  describe "create promise_post" do
    @tag login_as: "test_user"
    test "renders promise_post when data is valid", %{conn: conn, jwt: jwt} do
      attrs = params_with_assocs(:promise_post)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_post_path(conn, :create), promise_post: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_post_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise"]["id"] == attrs.promise_id
      assert resp["promise_maker_term"]["id"] == attrs.promise_maker_term_id
      assert resp["title"] == attrs.title
      assert resp["body"] == attrs.body
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_post_path(conn, :create), promise_post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promise_post" do
    setup [:create_promise_post]

    @tag login_as: "test_user"
    test "renders promise_post when data is valid",
      %{conn: conn, jwt: jwt, promise_post: %Post{id: id} = promise_post} do

      attrs = params_with_assocs(:promise_post)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_post_path(conn, :update, promise_post), promise_post: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_post_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise"]["id"] == attrs.promise_id
      assert resp["promise_maker_term"]["id"] == attrs.promise_maker_term_id
      assert resp["title"] == attrs.title
      assert resp["body"] == attrs.body
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid",
      %{conn: conn, jwt: jwt, promise_post: promise_post} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_post_path(conn, :update, promise_post), promise_post: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promise_post" do
    setup [:create_promise_post]

    @tag login_as: "test_user"
    test "deletes chosen promise_post",
      %{conn: conn, jwt: jwt, promise_post: promise_post} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(promise_post_path(conn, :delete, promise_post))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_post_path(conn, :show, promise_post))
      end
    end
  end

  defp create_promise_post(_) do
    promise_post = insert(:promise_post)
    {:ok, promise_post: promise_post}
  end
end
