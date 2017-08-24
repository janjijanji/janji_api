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

  describe "positions" do
    alias JanjiApi.PromiseMakers.Position

    @invalid_attrs %{title: nil, inserted_by: nil}

    test "list_positions/0 returns all positions" do
      position = insert(:promise_maker_position)
      assert PromiseMakers.list_positions() == [position]
    end

    test "get_position!/1 returns the position with given id" do
      position = insert(:promise_maker_position)
      assert PromiseMakers.get_position!(position.id) == position
    end

    test "get_position_by/1 returns the position with given attributes" do
      position = insert(:promise_maker_position)
      assert PromiseMakers.get_position_by(title: position.title) == position
    end

    test "create_position/1 with valid data creates a position" do
      attrs = params_with_assocs(:promise_maker_position)
      assert {:ok, %Position{} = position} = PromiseMakers.create_position(attrs)
      assert position.title == attrs.title
      assert position.description == attrs.description
      assert position.inserted_by_id == attrs.inserted_by_id
    end

    test "create_position/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PromiseMakers.create_position(@invalid_attrs)
    end

    test "update_position/2 with valid data updates the position" do
      position = insert(:promise_maker_position)
      update_attrs = params_with_assocs(:promise_maker_position)
      assert {:ok, position} = PromiseMakers.update_position(position, update_attrs)
      assert %Position{} = position
      assert position.title == update_attrs.title
      assert position.description == update_attrs.description
      assert position.inserted_by_id == update_attrs.inserted_by_id
    end

    test "update_position/2 with invalid data returns error changeset" do
      position = insert(:promise_maker_position)
      assert {:error, %Ecto.Changeset{}} = PromiseMakers.update_position(position, @invalid_attrs)
      assert position == PromiseMakers.get_position!(position.id)
    end

    test "delete_position/1 deletes the position" do
      position = insert(:promise_maker_position)
      assert {:ok, %Position{}} = PromiseMakers.delete_position(position)
      assert_raise Ecto.NoResultsError, fn -> PromiseMakers.get_position!(position.id) end
    end

    test "change_position/1 returns a position changeset" do
      position = insert(:promise_maker_position)
      assert %Ecto.Changeset{} = PromiseMakers.change_position(position)
    end
  end

  describe "terms" do
    alias JanjiApi.PromiseMakers.Term

    @invalid_attrs %{promise_maker_position: nil, promise_maker: nil, from_time: nil, inserted_by: nil}

    test "list_terms/0 returns all terms" do
      %Term{id: id} = insert(:promise_maker_term)
      assert [%Term{id: ^id}] = PromiseMakers.list_terms()
    end

    test "get_term!/1 returns the term with given id" do
      %Term{id: id} = insert(:promise_maker_term)
      assert %Term{id: ^id} = PromiseMakers.get_term!(id)
    end

    test "get_term_by/1 returns the term with given attributes" do
      %Term{id: id} = insert(:promise_maker_term)
      assert %Term{id: ^id} = PromiseMakers.get_term_by(id: id)
    end

    test "create_term/1 with valid data creates a term" do
      attrs = params_with_assocs(:promise_maker_term)
      assert {:ok, %Term{}} = PromiseMakers.create_term(attrs)
    end

    test "create_term/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PromiseMakers.create_term(@invalid_attrs)
    end

    test "update_term/2 with valid data updates the term" do
      term = insert(:promise_maker_term)
      update_attrs = params_with_assocs(:promise_maker_term)
      assert {:ok, %Term{}} = PromiseMakers.update_term(term, update_attrs)
    end

    test "update_term/2 with invalid data returns error changeset" do
      term = insert(:promise_maker_term)
      assert {:error, %Ecto.Changeset{}} = PromiseMakers.update_term(term, @invalid_attrs)
    end

    test "delete_term/1 deletes the term" do
      term = insert(:promise_maker_term)
      assert {:ok, %Term{}} = PromiseMakers.delete_term(term)
      assert_raise Ecto.NoResultsError, fn -> PromiseMakers.get_term!(term.id) end
    end

    test "change_term/1 returns a term changeset" do
      term = insert(:promise_maker_term)
      assert %Ecto.Changeset{} = PromiseMakers.change_term(term)
    end
  end

end
