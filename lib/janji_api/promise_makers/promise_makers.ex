defmodule JanjiApi.PromiseMakers do
  @moduledoc """
  The PromiseMakers context.
  """

  import Ecto.Query, warn: false
  alias JanjiApi.Repo

  alias JanjiApi.PromiseMakers.PromiseMaker

  @doc """
  Returns the list of promise_makers.

  ## Examples

      iex> list_promise_makers()
      [%PromiseMaker{}, ...]

  """
  def list_promise_makers() do
    query = from p in PromiseMaker,
      preload: [:inserted_by]
    Repo.all query
  end

  @doc """
  Gets a single promise_maker.

  Raises `Ecto.NoResultsError` if the PromiseMaker does not exist.

  ## Examples

      iex> get_promise_maker!(123)
      %PromiseMaker{}

      iex> get_promise_maker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promise_maker!(id) do
    query = from p in PromiseMaker,
      preload: [:inserted_by]
    Repo.get!(query, id)
  end

  @doc """
  Gets a single promise_maker by specific attributes.

  ## Examples

      iex> get_promise_maker_by(promise_makername: "test")
      %PromiseMaker{}

  """
  def get_promise_maker_by(attrs) do
    query = from p in PromiseMaker,
      preload: [:inserted_by]
    Repo.get_by(query, attrs)
  end

  @doc """
  Creates a promise_maker.

  ## Examples

      iex> create_promise_maker(%{field: value})
      {:ok, %PromiseMaker{}}

      iex> create_promise_maker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promise_maker(attrs \\ %{}) do
    %PromiseMaker{}
    |> PromiseMaker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promise_maker.

  ## Examples

      iex> update_promise_maker(promise_maker, %{field: new_value})
      {:ok, %PromiseMaker{}}

      iex> update_promise_maker(promise_maker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promise_maker(%PromiseMaker{} = promise_maker, attrs) do
    promise_maker
    |> PromiseMaker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PromiseMaker.

  ## Examples

      iex> delete_promise_maker(promise_maker)
      {:ok, %PromiseMaker{}}

      iex> delete_promise_maker(promise_maker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promise_maker(%PromiseMaker{} = promise_maker) do
    Repo.delete(promise_maker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promise_maker changes.

  ## Examples

      iex> change_promise_maker(promise_maker)
      %Ecto.Changeset{source: %PromiseMaker{}}

  """
  def change_promise_maker(%PromiseMaker{} = promise_maker) do
    PromiseMaker.changeset(promise_maker, %{})
  end
end
