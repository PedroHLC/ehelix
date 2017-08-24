defmodule EHelixWeb.PageController do
  use EHelixWeb, :controller

  def index(conn, _params) do
    text conn, ""
  end

  def login(conn, _params) do
    response =
      %{
        first_time: is_nil(Emulator.get()),
        token: "$$TOKEN$$",
        account_id: "$$ID$$"
      }

    json conn, response
  end

  def sign_up(conn, _params) do
    json conn, %{}
  end
end
