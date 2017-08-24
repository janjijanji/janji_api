defmodule JanjiApi.Repo.Migrations.CreatePromisePosts do
  use Ecto.Migration

  def change do
    create table(:promise_posts) do
      add :promise_id, references(:promises), null: false
      add :promise_maker_term_id, references(:promise_maker_terms)
      add :title, :string, null: false
      add :body, :text, null: false
      add :inserted_by_id, references(:users), null: false

      timestamps()
    end
  end
end
