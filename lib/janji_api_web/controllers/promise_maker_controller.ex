defmodule JanjiApiWeb.PromiseMakerController do
  use JanjiApiWeb, :controller

  alias JanjiApi.PromiseMakers
  alias JanjiApi.PromiseMakers.PromiseMaker

  action_fallback JanjiApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: JanjiApiWeb.Auth

  def index(conn, _params) do
    promise_makers = PromiseMakers.list_promise_makers()
    render(conn, "index.json", promise_makers: promise_makers)
  end

  def create(conn, %{"promise_maker" => promise_maker_params}) do
    with {:ok, %PromiseMaker{} = promise_maker} <-
      PromiseMakers.create_promise_maker(promise_maker_params) do

      promise_maker = PromiseMakers.get_promise_maker!(promise_maker.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", promise_maker_path(conn, :show, promise_maker))
      |> render("show.json", promise_maker: promise_maker)
    end
  end

  def show(conn, %{"id" => id}) do
    promise_maker = PromiseMakers.get_promise_maker!(id)
    render(conn, "show.json", promise_maker: promise_maker)
  end

  def update(conn, %{"id" => id, "promise_maker" => promise_maker_params}) do
    promise_maker = PromiseMakers.get_promise_maker!(id)

    with {:ok, %PromiseMaker{} = promise_maker} <- PromiseMakers.update_promise_maker(promise_maker, promise_maker_params) do
      render(conn, "show.json", promise_maker: promise_maker)
    end
  end

  def delete(conn, %{"id" => id}) do
    promise_maker = PromiseMakers.get_promise_maker!(id)
    with {:ok, %PromiseMaker{}} <- PromiseMakers.delete_promise_maker(promise_maker) do
      send_resp(conn, :no_content, "")
    end
  end
end
