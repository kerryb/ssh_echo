defmodule SSHEcho.Controller do
  @moduledoc """
  Controller for SSH daemons, allowing them to be stopped and started with
  specific ports, usernames and passwords.
  """

  alias SSHEcho.Daemon

  def start_link do
    Agent.start_link fn -> %{} end, name: __MODULE__
  end

  def start_daemon(port, username, password, handler) do
    {:ok, daemon_ref} = Daemon.start port, username, password
    Agent.update __MODULE__, fn daemons -> Map.put daemons, port, {daemon_ref, handler} end
  end

  def stop_daemon(port) do
    __MODULE__
    |> Agent.get_and_update(fn daemons ->
      with {daemon, _} = Map.get(daemons, port) do
        {daemon, Map.delete(daemons, port)}
      end
    end)
    |> Daemon.stop
  end

  def stop_daemons do
    __MODULE__
    |> Agent.get_and_update(fn daemons ->
      {Map.values(daemons) |> Enum.map(fn {daemon, _} -> daemon end), %{}}
    end)
    |> Enum.map(&Daemon.stop/1)
  end

  def reply_to(data, port) do
    Agent.get(__MODULE__, fn daemons ->
      with {_, handler} = Map.get(daemons, port) do
        handler
      end
    end).(data)
  end
end
