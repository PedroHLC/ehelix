defmodule EHelixWeb.PageController do
  use EHelixWeb, :controller

  def index(conn, _params) do
    text conn, ""
  end

  def login(conn, _params) do
    first = Emulator.login()

    response =
      %{
        first_time: first,
        token: "$$TOKEN$$",
        account_id: "$$ID$$"
      }

    json conn, response
  end

  def sign_up(conn, _params) do
    Emulator.sign_up()
    json conn, %{}
  end
end
