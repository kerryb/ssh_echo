defmodule SSHEcho do
  @moduledoc """
  Top-level module. See README for instructions.
  """
  alias SSHEcho.Controller

  @doc """
  Start a daemon listening on the specified port, authenticated by the supplied
  username and password.

  Optionally, a handler for received messages can also be provided. This must
  be a function that takes and returns a string, eg:

      SSHEcho.start_daemon 12345, "foo", "bar", fn(m) -> "I received " <> m end

  If no handler is supplied, the received message will simply be echoed back.
  """
  def start_daemon(port, username, password, handler\\&(&1)) do
    Controller.start_daemon port, username, password, handler
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
