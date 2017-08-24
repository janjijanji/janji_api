defmodule JanjiApiWeb.PromiseMakerTermController do
  use JanjiApiWeb, :controller

  alias JanjiApi.PromiseMakers
  alias JanjiApi.PromiseMakers.Term

  action_fallback JanjiApiWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, handler: JanjiApiWeb.Auth

  def index(conn, _params) do
    promise_maker_terms = PromiseMakers.list_terms()
    render(conn, "index.json", promise_maker_terms: promise_maker_terms)
  end

  def create(conn, %{"promise_maker_term" => promise_maker_term_params}) do
    with {:ok, %Term{} = promise_maker_term} <-
      PromiseMakers.create_term(promise_maker_term_params) do

      promise_maker_term = PromiseMakers.get_term!(promise_maker_term.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", promise_maker_term_path(conn, :show, promise_maker_term))
      |> render("show.json", promise_maker_term: promise_maker_term)
    end
  end

  def show(conn, %{"id" => id}) do
    promise_maker_term = PromiseMakers.get_term!(id)
    render(conn, "show.json", promise_maker_term: promise_maker_term)
  end

  def update(conn, %{"id" => id, "promise_maker_term" => promise_maker_term_params}) do
    promise_maker_term = PromiseMakers.get_term!(id)

    with {:ok, %Term{} = promise_maker_term} <- PromiseMakers.update_term(promise_maker_term, promise_maker_term_params) do
      render(conn, "show.json", promise_maker_term: promise_maker_term)
    end
  end

  def delete(conn, %{"id" => id}) do
    promise_maker_term = PromiseMakers.get_term!(id)
    with {:ok, %Term{}} <- PromiseMakers.delete_term(promise_maker_term) do
      send_resp(conn, :no_content, "")
    end
  end
end
