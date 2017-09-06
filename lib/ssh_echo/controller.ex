defmodule SSHEcho.Controller do
  @moduledoc """
  Controller for SSH daemons, allowing them to be stopped and started with
  specific ports, usernames and passwords.
  """

  alias SSHEcho.Daemon

  def start_link do
    Agent.start_link fn -> %{} end, name: __MODULE__
  end

  def start_daemon(port, username, password) do
    {:ok, pid} = Daemon.start port, username, password
    Agent.update __MODULE__, fn daemons -> Map.put daemons, port, pid end
  end

  def stop_daemon(port) do
    __MODULE__
    |> Agent.get(fn daemons -> Map.get daemons, port end)
    |> Daemon.stop
  end
end
