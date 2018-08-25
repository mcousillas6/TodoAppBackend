defmodule TodoApp.Accounts.Todo do
  use Ecto.Schema
  import Ecto.Changeset


  schema "todos" do
    field :description, :string
    field :done, :boolean, default: false
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description, :done])
    |> validate_required([:title, :done])
  end
end
