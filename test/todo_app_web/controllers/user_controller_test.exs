defmodule TodoAppWeb.UserControllerTest do
  use TodoAppWeb.ConnCase

  alias TodoApp.Accounts
  alias TodoApp.Accounts.User

  @create_attrs %{email: "some email", password_hash: "some password_hash"}
  @update_attrs %{email: "some updated email", password_hash: "some updated password_hash"}
  @invalid_attrs %{email: nil, password_hash: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
end
