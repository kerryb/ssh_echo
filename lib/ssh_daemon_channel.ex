defmodule SSHDaemonChannel do
  @moduledoc """
  A macro wrapping `:ssh_daemon_channel` erlang behaviour with a default
  implementation.
  """

  defmacro __using__(_opts) do
    quote do
      @behaviour :ssh_daemon_channel

      def init(_), do: {:ok, nil}

      def handle_ssh_msg(_, state), do: {:ok, state}

      def handle_msg(_, state), do: {:ok, state}

      def terminate(_, _), do: :ok
      defoverridable :ssh_daemon_channel
    end
  end
end
