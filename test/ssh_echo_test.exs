defmodule SSHEchoTest do
  use ExUnit.Case
  doctest SSHEcho

  setup do
    SSHEcho.stop_daemons
    on_exit fn -> SSHEcho.stop_daemons end
  end

  test "echoes (non-interactive) commands sent to it" do
    SSHEcho.start_daemon 10_001, "test", "secret"
    {:ok, conn} = SSHEx.connect(ip: 'localhost', port: 10_001,
                                user: "test", password: "secret")
    response = conn
               |> SSHEx.stream("test command\nwith multiple lines")
               |> Enum.map(fn {:stdout, data} -> data end)
               |> Enum.join
    assert response == "test command\nwith multiple lines"
  end

  test "allows daemons to be stopped individually" do
    SSHEcho.start_daemon 10_002, "test", "secret"
    SSHEcho.start_daemon 10_003, "test", "secret"
    SSHEcho.stop_daemon 10_003
    assert match?({:ok, _},
                  SSHEx.connect(ip: 'localhost', port: 10_002,
                                user: "test", password: "secret"))
    assert match?({:error, :econnrefused},
                  SSHEx.connect(ip: 'localhost', port: 10_003,
                                user: "test", password: "secret"))
  end

  test "allows all daemons to be stopped at once" do
    SSHEcho.start_daemon 10_002, "test", "secret"
    SSHEcho.start_daemon 10_003, "test", "secret"
    SSHEcho.stop_daemons
    assert match?({:error, :econnrefused},
                  SSHEx.connect(ip: 'localhost', port: 10_002,
                                user: "test", password: "secret"))
    assert match?({:error, :econnrefused},
                  SSHEx.connect(ip: 'localhost', port: 10_003,
                                user: "test", password: "secret"))
  end
end
