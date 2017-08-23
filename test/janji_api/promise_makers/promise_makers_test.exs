defmodule JanjiApi.PromiseMakersTest do
  use JanjiApi.DataCase

  alias JanjiApi.PromiseMakers

  describe "promise_makers" do
    alias JanjiApi.PromiseMakers.PromiseMaker

    @invalid_attrs %{full_name: nil, inserted_by: nil}

    test "list_promise_makers/0 returns all promise_makers" do
      promise_maker = insert(:promise_maker)
      assert PromiseMakers.list_promise_makers() == [promise_maker]
    end

    test "get_promise_maker!/1 returns the promise_maker with given id" do
      promise_maker = insert(:promise_maker)
      assert PromiseMakers.get_promise_maker!(promise_maker.id) == promise_maker
    end

    test "get_promise_maker_by/1 returns the promise_maker with given attributes" do
      promise_maker = insert(:promise_maker)
      assert PromiseMakers.get_promise_maker_by(full_name: promise_maker.full_name) == promise_maker
    end

    test "create_promise_maker/1 with valid data creates a promise_maker" do
      attrs = params_with_assocs(:promise_maker)
      assert {:ok, %PromiseMaker{} = promise_maker} = PromiseMakers.create_promise_maker(attrs)
      assert promise_maker.full_name == attrs.full_name
      assert promise_maker.gender == attrs.gender
      assert promise_maker.birthplace == attrs.birthplace
      assert promise_maker.birthdate == attrs.birthdate
      assert promise_maker.bio == attrs.bio
      assert promise_maker.inserted_by_id == attrs.inserted_by_id
    end

    test "create_promise_maker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PromiseMakers.create_promise_maker(@invalid_attrs)
    end

    test "update_promise_maker/2 with valid data updates the promise_maker" do
      promise_maker = insert(:promise_maker)
      update_attrs = params_with_assocs(:promise_maker)
      assert {:ok, promise_maker} = PromiseMakers.update_promise_maker(promise_maker, update_attrs)
      assert %PromiseMaker{} = promise_maker
      assert promise_maker.full_name == update_attrs.full_name
      assert promise_maker.gender == update_attrs.gender
      assert promise_maker.birthplace == update_attrs.birthplace
      assert promise_maker.birthdate == update_attrs.birthdate
      assert promise_maker.bio == update_attrs.bio
      assert promise_maker.inserted_by_id == update_attrs.inserted_by_id
    end

    test "update_promise_maker/2 with invalid data returns error changeset" do
      promise_maker = insert(:promise_maker)
      assert {:error, %Ecto.Changeset{}} = PromiseMakers.update_promise_maker(promise_maker, @invalid_attrs)
      assert promise_maker == PromiseMakers.get_promise_maker!(promise_maker.id)
    end

    test "delete_promise_maker/1 deletes the promise_maker" do
      promise_maker = insert(:promise_maker)
      assert {:ok, %PromiseMaker{}} = PromiseMakers.delete_promise_maker(promise_maker)
      assert_raise Ecto.NoResultsError, fn -> PromiseMakers.get_promise_maker!(promise_maker.id) end
    end

    test "change_promise_maker/1 returns a promise_maker changeset" do
      promise_maker = insert(:promise_maker)
      assert %Ecto.Changeset{} = PromiseMakers.change_promise_maker(promise_maker)
    end
  end
end