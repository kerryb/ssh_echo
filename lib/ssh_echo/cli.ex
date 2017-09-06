defmodule SSHEcho.CLI do
  @moduledoc """
  An implementation of `:ssh_channel` behaviour that expects an 'exec'ed
  command (not an interactive session) and echos the command back.
  """

  use SSHChannel

  def handle_ssh_msg({:ssh_cm, cm, {:exec, channel_id, want_reply, data}}, state) do
    :ssh_connection.send cm, channel_id, data
    :ssh_connection.send_eof cm, channel_id
    :ssh_connection.reply_request cm, want_reply, :success, channel_id
    {:stop, channel_id, state}
  end
end
