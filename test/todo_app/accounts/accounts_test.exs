defmodule TodoApp.AccountsTest do
  use TodoApp.DataCase

  alias TodoApp.Accounts

  describe "users" do
    alias TodoApp.Accounts.User

    @valid_attrs %{email: "some@email", password: "some password", password_confirmation: "some password"}
    @invalid_attrs %{email: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end
  end

  describe "todos" do
    alias TodoApp.Accounts.Todo

    @valid_attrs %{description: "some description", done: true, title: "some title"}
    @update_attrs %{description: "some updated description", done: false, title: "some updated title"}
    @invalid_attrs %{description: nil, done: nil, title: nil}

    def todo_fixture(attrs \\ %{}) do
      {:ok, todo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_todo()

      todo
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Accounts.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Accounts.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      assert {:ok, %Todo{} = todo} = Accounts.create_todo(@valid_attrs)
      assert todo.description == "some description"
      assert todo.done == true
      assert todo.title == "some title"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, todo} = Accounts.update_todo(todo, @update_attrs)
      assert %Todo{} = todo
      assert todo.description == "some updated description"
      assert todo.done == false
      assert todo.title == "some updated title"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_todo(todo, @invalid_attrs)
      assert todo == Accounts.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Accounts.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Accounts.change_todo(todo)
    end
  end
end
