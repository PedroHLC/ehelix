defmodule EHelixWeb.PageController do
  use EHelixWeb, :controller

  def index(conn, _params) do
    text conn, ""
  end

  def login(conn, _params) do
    Emulator.login()
    json conn, %{token: "$$TOKEN$$", account_id: "$$ID$$"}
  end

  def sign_up(conn, _params) do
    Emulator.sign_up()
    json conn, %{}
  end
end
