defmodule JanjiApiWeb.PromisePostVoteController do
  use JanjiApiWeb, :controller

  alias JanjiApi.Promises
  alias JanjiApi.Promises.PostVote

  action_fallback JanjiApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: JanjiApiWeb.Auth

  def index(conn, %{"promise_post_id" => promise_post_id}) do
    promise_post_votes = Promises.list_post_votes_by_post(promise_post_id)
    render(conn, "index.json", promise_post_votes: promise_post_votes)
  end

  def create(conn, %{"promise_post_vote" => promise_post_vote_params}) do
    promise_post_vote_params = Map.put(promise_post_vote_params, "inserted_by_id", conn.assigns.current_user.id)

    with {:ok, %PostVote{} = promise_post_vote} <-
      Promises.create_post_vote(promise_post_vote_params) do

      promise_post_vote = Promises.get_post_vote!(promise_post_vote.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", promise_post_vote_path(conn, :show, promise_post_vote))
      |> render("show.json", promise_post_vote: promise_post_vote)
    end
  end

  def show(conn, %{"id" => id}) do
    promise_post_vote = Promises.get_post_vote!(id)
    render(conn, "show.json", promise_post_vote: promise_post_vote)
  end

  def update(conn, %{"id" => id, "promise_post_vote" => promise_post_vote_params}) do
    promise_post_vote = Promises.get_post_vote!(id)

    with {:ok, %PostVote{} = promise_post_vote} <- Promises.update_post_vote(promise_post_vote, promise_post_vote_params) do
      render(conn, "show.json", promise_post_vote: promise_post_vote)
    end
  end

  def delete(conn, %{"id" => id}) do
    promise_post_vote = Promises.get_post_vote!(id)
    with {:ok, %PostVote{}} <- Promises.delete_post_vote(promise_post_vote) do
      send_resp(conn, :no_content, "")
    end
  end
end
