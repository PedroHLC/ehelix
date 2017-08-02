defmodule EHelixWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: EHelixWeb
      import Plug.Conn
      import EHelixWeb.Router.Helpers
      alias EHelix.Emulator
    end
  end

  def view do
    quote do
      alias EHelix.Emulator
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      alias EHelix.Emulator
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import EHelixWeb.Gettext
      alias EHelix.Emulator
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
