defmodule EHelix.Emulator.Server do
  def initial_model do
    %{}
  end

  def handle_request(_, state) do
    {%{}, state}
  end
end
