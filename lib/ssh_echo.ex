defmodule SSHEcho do
  @moduledoc """
  Top-level module. See README for instructions.
  """
  alias SSHEcho.Controller

  @doc """
  Start a daemon listening on the specified port, authenticated by the supplied
  username and password.
  """
  def start_daemon(port, username, password) do
    Controller.start_daemon port, username, password
  end

  @doc """
  Stop the daemon on a particular port.
  """
  def stop_daemon(port), do: Controller.stop_daemon port

  @doc """
  Stop all daemons.
  """
  def stop_daemons, do: Controller.stop_daemons
end
