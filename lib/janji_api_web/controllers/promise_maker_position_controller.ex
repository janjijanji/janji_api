defmodule JanjiApiWeb.PromiseMakerPositionController do
  use JanjiApiWeb, :controller

  alias JanjiApi.PromiseMakers
  alias JanjiApi.PromiseMakers.Position

  action_fallback JanjiApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: JanjiApiWeb.Auth

  def index(conn, _params) do
    promise_maker_positions = PromiseMakers.list_positions()
    render(conn, "index.json", promise_maker_positions: promise_maker_positions)
  end

  def create(conn, %{"promise_maker_position" => promise_maker_position_params}) do
    with {:ok, %Position{} = promise_maker_position} <-
      PromiseMakers.create_position(promise_maker_position_params) do

      promise_maker_position = PromiseMakers.get_position!(promise_maker_position.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", promise_maker_position_path(conn, :show, promise_maker_position))
      |> render("show.json", promise_maker_position: promise_maker_position)
    end
  end

  def show(conn, %{"id" => id}) do
    promise_maker_position = PromiseMakers.get_position!(id)
    render(conn, "show.json", promise_maker_position: promise_maker_position)
  end

  def update(conn, %{"id" => id, "promise_maker_position" => promise_maker_position_params}) do
    promise_maker_position = PromiseMakers.get_position!(id)

    with {:ok, %Position{} = promise_maker_position} <- PromiseMakers.update_position(promise_maker_position, promise_maker_position_params) do
      render(conn, "show.json", promise_maker_position: promise_maker_position)
    end
  end

  def delete(conn, %{"id" => id}) do
    promise_maker_position = PromiseMakers.get_position!(id)
    with {:ok, %Position{}} <- PromiseMakers.delete_position(promise_maker_position) do
      send_resp(conn, :no_content, "")
    end
  end
end
