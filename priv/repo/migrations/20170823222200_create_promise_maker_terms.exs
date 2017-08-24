defmodule JanjiApi.Repo.Migrations.CreatePromiseMakerTerms do
  use Ecto.Migration

  def change do
    create table(:promise_maker_terms) do
      add :promise_maker_position_id, references(:promise_maker_positions), null: false
      add :promise_maker_id, references(:promise_makers), null: false
      add :from_time, :naive_datetime, null: false
      add :thru_time, :naive_datetime
      add :inserted_by_id, references(:users), null: false

      timestamps()
    end
  end
end
