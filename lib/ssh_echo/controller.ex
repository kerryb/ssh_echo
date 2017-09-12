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
    {:ok, daemon_ref} = Daemon.start port, username, password
    Agent.update __MODULE__, fn daemons -> Map.put daemons, port, daemon_ref end
  end

  def stop_daemon(port) do
    __MODULE__
    |> Agent.get_and_update(fn daemons ->
      {Map.get(daemons, port), Map.delete(daemons, port)}
    end)
    |> Daemon.stop
  end

  def stop_daemons do
    __MODULE__
    |> Agent.get_and_update(fn daemons -> {Map.values(daemons), %{}} end)
    |> Enum.map(&Daemon.stop/1)
  end
end
