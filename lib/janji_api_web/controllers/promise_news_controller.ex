defmodule JanjiApiWeb.PromiseNewsController do
  use JanjiApiWeb, :controller

  alias JanjiApi.Promises
  alias JanjiApi.Promises.News

  action_fallback JanjiApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: JanjiApiWeb.Auth

  def index(conn, _params) do
    promise_news = Promises.list_news()
    render(conn, "index.json", promise_news: promise_news)
  end

  def create(conn, %{"promise_news" => promise_news_params}) do
    with {:ok, %News{} = promise_news} <-
      Promises.create_news(promise_news_params) do

      promise_news = Promises.get_news!(promise_news.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", promise_news_path(conn, :show, promise_news))
      |> render("show.json", promise_news: promise_news)
    end
  end

  def show(conn, %{"id" => id}) do
    promise_news = Promises.get_news!(id)
    render(conn, "show.json", promise_news: promise_news)
  end

  def update(conn, %{"id" => id, "promise_news" => promise_news_params}) do
    promise_news = Promises.get_news!(id)

    with {:ok, %News{} = promise_news} <- Promises.update_news(promise_news, promise_news_params) do
      render(conn, "show.json", promise_news: promise_news)
    end
  end

  def delete(conn, %{"id" => id}) do
    promise_news = Promises.get_news!(id)
    with {:ok, %News{}} <- Promises.delete_news(promise_news) do
      send_resp(conn, :no_content, "")
    end
  end
end
