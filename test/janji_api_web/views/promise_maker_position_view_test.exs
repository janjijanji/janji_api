defmodule JanjiApiWeb.PromiseMakerPositionViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.PromiseMakerPositionView
  alias JanjiApiWeb.UserView
  alias JanjiApi.Accounts.User

  test "promise_maker_position.json" do
    promise_maker_position = create_promise_maker_position()
    content = PromiseMakerPositionView.render("promise_maker_position.json", %{promise_maker_position: promise_maker_position})
    assert content == %{
      id: promise_maker_position.id,
      title: promise_maker_position.title,
      description: promise_maker_position.description,
      inserted_by: UserView.render("user.json", %{user: promise_maker_position.inserted_by}),
    }
  end

  test "index.json" do
    promise_maker_positions = [create_promise_maker_position(), create_promise_maker_position()]
      |> render_many(PromiseMakerPositionView, "promise_maker_position.json")
    content = PromiseMakerPositionView.render("index.json", %{promise_maker_positions: promise_maker_positions})
    assert content == %{
      data: %{
        items: promise_maker_positions
      }
    }
  end

  test "show.json" do
    promise_maker_position = create_promise_maker_position()
      |> render_one(PromiseMakerPositionView, "promise_maker_position.json")
    content = PromiseMakerPositionView.render("show.json", %{promise_maker_position: promise_maker_position})
    assert content == %{
      data: promise_maker_position
    }
  end

  defp create_promise_maker_position do
    params_for(:promise_maker_position)
      |> Map.put(:id, 1)
      |> Map.put(:inserted_by, %User{})
  end
end
