defmodule JanjiApiWeb.PromisePostVoteControllerTest do
  use JanjiApiWeb.ConnCase

  alias JanjiApi.Promises
  alias JanjiApi.Promises.PostVote
  alias JanjiApiWeb.PromisePostVoteView

  @invalid_attrs %{promise_post_id: nil, inserted_by_id: nil}

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
    test "lists all promise_post_votes filtered by post", %{conn: conn, jwt: jwt} do
      promise_post_vote = insert(:promise_post_vote)
      conn = conn
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_post_vote_path(conn, :index, %{promise_post_id: promise_post_vote.promise_post_id}))
      assert json_response(conn, 200) == render_json(PromisePostVoteView, "index.json", promise_post_votes: Promises.list_post_votes())
    end
  end

  describe "create promise_post_vote" do
    @tag login_as: "test_user"
    test "renders promise_post_vote when data is valid", %{conn: conn, jwt: jwt, user: user} do
      attrs = params_with_assocs(:promise_post_vote)

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_post_vote_path(conn, :create), promise_post_vote: attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      # Fetch promise_post
      promise_post = Promises.get_post!(attrs.promise_post_id)

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_post_vote_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise"]["id"] == promise_post.promise_id
      assert resp["promise_post"]["id"] == attrs.promise_post_id
      assert resp["inserted_by"]["id"] == user.id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid", %{conn: conn, jwt: jwt} do
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(promise_post_vote_path(conn, :create), promise_post_vote: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update promise_post_vote" do
    setup [:create_promise_post_vote]

    @tag login_as: "test_user"
    test "renders promise_post_vote when data is valid",
      %{conn: conn, jwt: jwt, promise_post_vote: %PostVote{id: id} = promise_post_vote} do

      attrs = params_with_assocs(:promise_post_vote)
      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_post_vote_path(conn, :update, promise_post_vote), promise_post_vote: attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      # Fetch promise_post
      promise_post = Promises.get_post!(attrs.promise_post_id)

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get(promise_post_vote_path(conn, :show, id))
      resp = json_response(conn, 200)["data"]
      assert resp["id"] == id
      assert resp["promise"]["id"] == promise_post.promise_id
      assert resp["promise_post"]["id"] == attrs.promise_post_id
      assert resp["inserted_by"]["id"] == attrs.inserted_by_id
    end

    @tag login_as: "test_user"
    test "renders errors when data is invalid",
      %{conn: conn, jwt: jwt, promise_post_vote: promise_post_vote} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(promise_post_vote_path(conn, :update, promise_post_vote), promise_post_vote: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete promise_post_vote" do
    setup [:create_promise_post_vote]

    @tag login_as: "test_user"
    test "deletes chosen promise_post_vote",
      %{conn: conn, jwt: jwt, promise_post_vote: promise_post_vote} do

      conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(promise_post_vote_path(conn, :delete, promise_post_vote))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        build_conn()
        |> put_req_header("authorization", "Bearer #{jwt}")
        |> get(promise_post_vote_path(conn, :show, promise_post_vote))
      end
    end
  end

  defp create_promise_post_vote(_) do
    promise_post_vote = insert(:promise_post_vote)
    {:ok, promise_post_vote: promise_post_vote}
  end
end
