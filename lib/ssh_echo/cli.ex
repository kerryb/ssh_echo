defmodule SSHEcho.CLI do
  @moduledoc """
  An implementation of `:ssh_channel` behaviour that expects an 'exec'ed
  command (not an interactive session) and echos the command back.
  """

  use SSHDaemonChannel
  alias SSHEcho.Controller

  def handle_ssh_msg({:ssh_cm, cm, {:exec, channel_id, want_reply, data}}, state) do
    with [sockname: {_, port}] = :ssh.connection_info(cm, [:sockname]),
         reply = data |> to_string |> Controller.reply_to(port) do
      :ssh_connection.send cm, channel_id, reply
      :ssh_connection.send_eof cm, channel_id
      :ssh_connection.reply_request cm, want_reply, :success, channel_id
      {:stop, channel_id, state}
    end
  end
end
