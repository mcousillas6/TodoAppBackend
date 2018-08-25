defmodule TodoAppWeb.TodoController do
  use TodoAppWeb, :controller

  alias TodoApp.Accounts
  alias TodoApp.Accounts.Todo
  alias TodoApp.Guardian

  action_fallback TodoAppWeb.FallbackController

  def index(conn, _params) do
    user = conn
      |> Guardian.Plug.current_resource
      |> Accounts.list_todos
    render(conn, "index.json", todos: user.todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    user = Guardian.Plug.current_resource(conn)
    with {:ok, %Todo{} = todo} <- Accounts.create_todo(user, todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Accounts.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Accounts.get_todo!(id)
    with {:ok, %Todo{} = todo} <- Accounts.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Accounts.get_todo!(id)
    with {:ok, %Todo{}} <- Accounts.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
