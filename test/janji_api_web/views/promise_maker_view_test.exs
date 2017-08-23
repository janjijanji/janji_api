defmodule JanjiApiWeb.PromiseMakerViewTest do
  use JanjiApiWeb.ConnCase, async: true
  import Phoenix.View

  alias JanjiApiWeb.PromiseMakerView
  alias JanjiApiWeb.UserView
  alias JanjiApi.Accounts.User

  test "promise_maker.json" do
    promise_maker = create_promise_maker()
    content = PromiseMakerView.render("promise_maker.json", %{promise_maker: promise_maker})
    assert content == %{
      id: promise_maker.id,
      full_name: promise_maker.full_name,
      gender: promise_maker.gender,
      birthplace: promise_maker.birthplace,
      birthdate: promise_maker.birthdate,
      bio: promise_maker.bio,
      inserted_by: UserView.render("user.json", %{user: promise_maker.inserted_by}),
    }
  end

  test "index.json" do
    promise_makers = [create_promise_maker(), create_promise_maker()]
      |> render_many(PromiseMakerView, "promise_maker.json")
    content = PromiseMakerView.render("index.json", %{promise_makers: promise_makers})
    assert content == %{
      data: %{
        items: promise_makers
      }
    }
  end

  test "show.json" do
    promise_maker = create_promise_maker()
      |> render_one(PromiseMakerView, "promise_maker.json")
    content = PromiseMakerView.render("show.json", %{promise_maker: promise_maker})
    assert content == %{
      data: promise_maker
    }
  end

  defp create_promise_maker do
    params_for(:promise_maker)
      |> Map.put(:id, 1)
      |> Map.put(:inserted_by, %User{})
  end
end
