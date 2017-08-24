defmodule JanjiApi.PromiseMakers.Position do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.PromiseMakers.Position

  schema "promise_maker_positions" do
    field :title, :string
    field :description, :string
    belongs_to :inserted_by, JanjiApi.Accounts.User, foreign_key: :inserted_by_id

    timestamps()
  end

  @doc false
  def changeset(%Position{} = promise_maker, attrs) do
    promise_maker
    |> cast(attrs, [:title, :description, :inserted_by_id])
    |> validate_required([:title, :inserted_by_id])
    |> validate_length(:title, min: 3)
    |> assoc_constraint(:inserted_by)
  end
end
