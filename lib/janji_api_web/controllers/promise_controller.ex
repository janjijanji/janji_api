defmodule JanjiApiWeb.PromiseController do
  use JanjiApiWeb, :controller

  alias JanjiApi.Promises
  alias JanjiApi.Promises.Promise

  action_fallback JanjiApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: JanjiApiWeb.Auth

  def index(conn, _params) do
    promises = Promises.list_promises()
    render(conn, "index.json", promises: promises)
  end

  def create(conn, %{"promise" => promise_params}) do
    promise_params = Map.put(promise_params, "inserted_by_id", conn.assigns.current_user.id)

    with {:ok, %Promise{} = promise} <-
      Promises.create_promise(promise_params) do

      promise = Promises.get_promise!(promise.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", promise_path(conn, :show, promise))
      |> render("show.json", promise: promise)
    end
  end

  def show(conn, %{"id" => id}) do
    promise = Promises.get_promise!(id)
    render(conn, "show.json", promise: promise)
  end

  def update(conn, %{"id" => id, "promise" => promise_params}) do
    promise = Promises.get_promise!(id)

    with {:ok, %Promise{} = promise} <- Promises.update_promise(promise, promise_params) do
      render(conn, "show.json", promise: promise)
    end
  end

  def delete(conn, %{"id" => id}) do
    promise = Promises.get_promise!(id)
    with {:ok, %Promise{}} <- Promises.delete_promise(promise) do
      send_resp(conn, :no_content, "")
    end
  end
end
