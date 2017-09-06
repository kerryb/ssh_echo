defmodule SSHEchoTest do
  use ExUnit.Case
  doctest SSHEcho

  setup do
    SSHEcho.start_daemon 54_321, "test", "secret"
    on_exit fn -> SSHEcho.stop_daemon 54_321 end
  end

  test "echoes (non-interactive) commands sent to it" do
    {:ok, conn} = SSHEx.connect(ip: 'localhost', port: 54_321,
                                user: "test", password: "secret")
    response = conn
               |> SSHEx.stream("test command\nwith multiple lines")
               |> Enum.map(fn {:stdout, data} -> data end)
               |> Enum.join
    assert response == "test command\nwith multiple lines"
  end
end
