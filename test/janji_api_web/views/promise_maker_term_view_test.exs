defmodule JanjiApiWeb.PromiseMakerTermViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.PromiseMakerView
  alias JanjiApiWeb.PromiseMakerPositionView
  alias JanjiApiWeb.PromiseMakerTermView
  alias JanjiApiWeb.UserView
  alias JanjiApi.PromiseMakers.Position
  alias JanjiApi.PromiseMakers.PromiseMaker
  alias JanjiApi.Accounts.User

  test "promise_maker_term.json" do
    promise_maker_term = create_promise_maker_term()
    content = PromiseMakerTermView.render("promise_maker_term.json", %{promise_maker_term: promise_maker_term})
    assert content == %{
      id: promise_maker_term.id,
      promise_maker_position: PromiseMakerPositionView.render("promise_maker_position_no_rel.json", %{promise_maker_position: promise_maker_term.promise_maker_position}),
      promise_maker: PromiseMakerView.render("promise_maker_no_rel.json", %{promise_maker: promise_maker_term.promise_maker}),
      from_time: promise_maker_term.from_time,
      thru_time: promise_maker_term.thru_time,
      inserted_by: UserView.render("user.json", %{user: promise_maker_term.inserted_by}),
    }
  end

  test "index.json" do
    promise_maker_terms = [create_promise_maker_term(), create_promise_maker_term()]
      |> render_many(PromiseMakerTermView, "promise_maker_term.json")
    content = PromiseMakerTermView.render("index.json", %{promise_maker_terms: promise_maker_terms})
    assert content == %{
      data: %{
        items: promise_maker_terms
      }
    }
  end

  test "show.json" do
    promise_maker_term = create_promise_maker_term()
      |> render_one(PromiseMakerTermView, "promise_maker_term.json")
    content = PromiseMakerTermView.render("show.json", %{promise_maker_term: promise_maker_term})
    assert content == %{
      data: promise_maker_term
    }
  end

  defp create_promise_maker_term do
    params_for(:promise_maker_term)
      |> Map.put(:id, 1)
      |> Map.put(:promise_maker_position, %Position{})
      |> Map.put(:promise_maker, %PromiseMaker{})
      |> Map.put(:inserted_by, %User{})
  end
end
