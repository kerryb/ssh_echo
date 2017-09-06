defmodule SSHEcho do
  @moduledoc """
  Top-level module. See README for instructions.
  """
  alias SSHEcho.Controller

  def start_daemon(port, username, password) do
    Controller.start_daemon port, username, password
  end
  def stop_daemon(port), do: Controller.stop_daemon port
end
