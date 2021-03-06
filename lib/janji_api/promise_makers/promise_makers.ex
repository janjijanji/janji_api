defmodule JanjiApi.PromiseMakers do
  @moduledoc """
  The PromiseMakers context.
  """

  import Ecto.Query, warn: false
  alias JanjiApi.Repo

  alias JanjiApi.PromiseMakers.PromiseMaker
  alias JanjiApi.PromiseMakers.Position
  alias JanjiApi.PromiseMakers.Term

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

  @doc """
  Returns the list of positions.

  ## Examples

      iex> list_positions()
      [%Position{}, ...]

  """
  def list_positions() do
    query = from p in Position,
      preload: [:inserted_by]
    Repo.all query
  end

  @doc """
  Gets a single position.

  Raises `Ecto.NoResultsError` if the Position does not exist.

  ## Examples

      iex> get_position!(123)
      %Position{}

      iex> get_position!(456)
      ** (Ecto.NoResultsError)

  """
  def get_position!(id) do
    query = from p in Position,
      preload: [:inserted_by]
    Repo.get!(query, id)
  end

  @doc """
  Gets a single position by specific attributes.

  ## Examples

      iex> get_position_by(positionname: "test")
      %Position{}

  """
  def get_position_by(attrs) do
    query = from p in Position,
      preload: [:inserted_by]
    Repo.get_by(query, attrs)
  end

  @doc """
  Creates a position.

  ## Examples

      iex> create_position(%{field: value})
      {:ok, %Position{}}

      iex> create_position(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_position(attrs \\ %{}) do
    %Position{}
    |> Position.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a position.

  ## Examples

      iex> update_position(position, %{field: new_value})
      {:ok, %Position{}}

      iex> update_position(position, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_position(%Position{} = position, attrs) do
    position
    |> Position.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Position.

  ## Examples

      iex> delete_position(position)
      {:ok, %Position{}}

      iex> delete_position(position)
      {:error, %Ecto.Changeset{}}

  """
  def delete_position(%Position{} = position) do
    Repo.delete(position)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking position changes.

  ## Examples

      iex> change_position(position)
      %Ecto.Changeset{source: %Position{}}

  """
  def change_position(%Position{} = position) do
    Position.changeset(position, %{})
  end

  @doc """
  Returns the list of terms.

  ## Examples

      iex> list_terms()
      [%Term{}, ...]

  """
  def list_terms() do
    query = from p in Term,
      preload: [:promise_maker_position, :promise_maker, :inserted_by]
    Repo.all query
  end

  @doc """
  Gets a single term.

  Raises `Ecto.NoResultsError` if the Term does not exist.

  ## Examples

      iex> get_term!(123)
      %Term{}

      iex> get_term!(456)
      ** (Ecto.NoResultsError)

  """
  def get_term!(id) do
    query = from p in Term,
      preload: [:promise_maker_position, :promise_maker, :inserted_by]
    Repo.get!(query, id)
  end

  @doc """
  Gets a single term by specific attributes.

  ## Examples

      iex> get_term_by(termname: "test")
      %Term{}

  """
  def get_term_by(attrs) do
    query = from p in Term,
      preload: [:promise_maker_position, :promise_maker, :inserted_by]
    Repo.get_by(query, attrs)
  end

  @doc """
  Creates a term.

  ## Examples

      iex> create_term(%{field: value})
      {:ok, %Term{}}

      iex> create_term(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_term(attrs \\ %{}) do
    %Term{}
    |> Term.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a term.

  ## Examples

      iex> update_term(term, %{field: new_value})
      {:ok, %Term{}}

      iex> update_term(term, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_term(%Term{} = term, attrs) do
    term
    |> Term.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Term.

  ## Examples

      iex> delete_term(term)
      {:ok, %Term{}}

      iex> delete_term(term)
      {:error, %Ecto.Changeset{}}

  """
  def delete_term(%Term{} = term) do
    Repo.delete(term)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking term changes.

  ## Examples

      iex> change_term(term)
      %Ecto.Changeset{source: %Term{}}

  """
  def change_term(%Term{} = term) do
    Term.changeset(term, %{})
  end
end
