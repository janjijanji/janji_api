defmodule JanjiApi.Repo.Migrations.CreatePromises do
  use Ecto.Migration

  def change do
    create table(:promises) do
      add :promise_maker_id, references(:promise_makers), null: false
      add :title, :string, null: false
      add :promised_at, :naive_datetime, null: false
      add :description, :text, null: false
      add :url, :text
      add :inserted_by_id, references(:users), null: false

      timestamps()
    end
  end
end
