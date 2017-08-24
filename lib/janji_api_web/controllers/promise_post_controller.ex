defmodule JanjiApiWeb.PromisePostController do
  use JanjiApiWeb, :controller

  alias JanjiApi.Promises
  alias JanjiApi.Promises.Post

  action_fallback JanjiApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: JanjiApiWeb.Auth

  def index(conn, _params) do
    promise_posts = Promises.list_posts()
    render(conn, "index.json", promise_posts: promise_posts)
  end

  def create(conn, %{"promise_post" => promise_post_params}) do
    with {:ok, %Post{} = promise_post} <-
      Promises.create_post(promise_post_params) do

      promise_post = Promises.get_post!(promise_post.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", promise_post_path(conn, :show, promise_post))
      |> render("show.json", promise_post: promise_post)
    end
  end

  def show(conn, %{"id" => id}) do
    promise_post = Promises.get_post!(id)
    render(conn, "show.json", promise_post: promise_post)
  end

  def update(conn, %{"id" => id, "promise_post" => promise_post_params}) do
    promise_post = Promises.get_post!(id)

    with {:ok, %Post{} = promise_post} <- Promises.update_post(promise_post, promise_post_params) do
      render(conn, "show.json", promise_post: promise_post)
    end
  end

  def delete(conn, %{"id" => id}) do
    promise_post = Promises.get_post!(id)
    with {:ok, %Post{}} <- Promises.delete_post(promise_post) do
      send_resp(conn, :no_content, "")
    end
  end
end
