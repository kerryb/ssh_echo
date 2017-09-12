defmodule SSHEcho.Daemon do
  @moduledoc """
  An SSH daemon, using `SSHEcho.CLI`.
  """

  def start(port, username, password) do
    system_dir = Path.join(:code.priv_dir(:ssh_echo), "certs") |> String.to_charlist
    :ssh.daemon(port,
                system_dir: system_dir,
                user_passwords: [{String.to_charlist(username),
                                  String.to_charlist(password)}],
                ssh_cli: {SSHEcho.CLI, []})
  end

  def stop(daemon_ref) do
    :ok = :ssh.stop_daemon daemon_ref
  end
end
