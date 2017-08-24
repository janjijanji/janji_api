defmodule JanjiApi.Repo.Migrations.CreatePromiseNews do
  use Ecto.Migration

  def change do
    create table(:promise_news) do
      add :promise_id, references(:promises), null: false
      add :title, :string, null: false
      add :published_at, :naive_datetime, null: false
      add :summary, :text
      add :body, :text, null: false
      add :url, :text
      add :inserted_by_id, references(:users), null: false

      timestamps()
    end
  end
end
