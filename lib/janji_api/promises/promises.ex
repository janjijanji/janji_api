defmodule JanjiApi.Promises do
  @moduledoc """
  The Promises context.
  """

  import Ecto.Query, warn: false
  alias JanjiApi.Repo

  alias JanjiApi.Promises.Promise
  alias JanjiApi.Promises.Position
  alias JanjiApi.Promises.Term

  @doc """
  Returns the list of promises.

  ## Examples

      iex> list_promises()
      [%Promise{}, ...]

  """
  def list_promises() do
    query = from p in Promise,
      preload: [:promise_maker, :inserted_by]
    Repo.all query
  end

  @doc """
  Gets a single promise.

  Raises `Ecto.NoResultsError` if the Promise does not exist.

  ## Examples

      iex> get_promise!(123)
      %Promise{}

      iex> get_promise!(456)
      ** (Ecto.NoResultsError)

  """
  def get_promise!(id) do
    query = from p in Promise,
      preload: [:promise_maker, :inserted_by]
    Repo.get!(query, id)
  end

  @doc """
  Gets a single promise by specific attributes.

  ## Examples

      iex> get_promise_by(promisename: "test")
      %Promise{}

  """
  def get_promise_by(attrs) do
    query = from p in Promise,
      preload: [:promise_maker, :inserted_by]
    Repo.get_by(query, attrs)
  end

  @doc """
  Creates a promise.

  ## Examples

      iex> create_promise(%{field: value})
      {:ok, %Promise{}}

      iex> create_promise(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_promise(attrs \\ %{}) do
    %Promise{}
    |> Promise.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a promise.

  ## Examples

      iex> update_promise(promise, %{field: new_value})
      {:ok, %Promise{}}

      iex> update_promise(promise, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_promise(%Promise{} = promise, attrs) do
    promise
    |> Promise.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Promise.

  ## Examples

      iex> delete_promise(promise)
      {:ok, %Promise{}}

      iex> delete_promise(promise)
      {:error, %Ecto.Changeset{}}

  """
  def delete_promise(%Promise{} = promise) do
    Repo.delete(promise)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking promise changes.

  ## Examples

      iex> change_promise(promise)
      %Ecto.Changeset{source: %Promise{}}

  """
  def change_promise(%Promise{} = promise) do
    Promise.changeset(promise, %{})
  end
end
