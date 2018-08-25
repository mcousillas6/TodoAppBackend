defmodule TodoAppWeb.UserController do
  use TodoAppWeb, :controller

  alias TodoApp.Accounts
  alias TodoApp.Accounts.User
  alias TodoApp.Guardian

  action_fallback TodoAppWeb.FallbackController

  @spec create(any(), map()) :: any()
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
      {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("jwt.json", jwt: token)
    end
  end

  @spec sign_in(any(), map()) :: {:error, :unauthorized} | Plug.Conn.t()
  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} -> conn |> render("jwt.json", jwt: token)
      _ -> {:error, :unauthorized}
    end
  end

  @spec show(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "show.json", user: user)
  end
end
