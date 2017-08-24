defmodule JanjiApi.PromiseMakers.Term do
  use Ecto.Schema
  import Ecto.Changeset
  alias JanjiApi.PromiseMakers.Term

  schema "promise_maker_terms" do
    belongs_to :promise_maker_position, JanjiApi.PromiseMakers.Position, foreign_key: :promise_maker_position_id
    belongs_to :promise_maker, JanjiApi.PromiseMakers.PromiseMaker, foreign_key: :promise_maker_id
    field :from_time, :naive_datetime
    field :thru_time, :naive_datetime
    belongs_to :inserted_by, JanjiApi.Accounts.User, foreign_key: :inserted_by_id

    timestamps()
  end

  @doc false
  def changeset(%Term{} = promise_maker, attrs) do
    promise_maker
    |> cast(attrs, [:promise_maker_position_id, :promise_maker_id, :from_time, :thru_time, :inserted_by_id])
    |> validate_required([:promise_maker_position_id, :promise_maker_id, :from_time, :inserted_by_id])
    |> assoc_constraint(:promise_maker_position)
    |> assoc_constraint(:promise_maker)
    |> assoc_constraint(:inserted_by)
  end
end
