defmodule SSHChannel do
  @moduledoc """
  A macro wrapping `:ssh_channel` erlang behaviour with a default implementation.
  """

  defmacro __using__(_opts) do
    quote do
      @behaviour :ssh_channel

      def init(_), do: {:ok, nil}

      def handle_ssh_msg(_, state), do: {:ok, state}

      def handle_msg(_, state), do: {:ok, state}

      def terminate(_, _), do: :ok

      def code_change(_, state, _), do: {:ok, state}

      def handle_call(_, _, state), do: {:reply, :ok, state}

      def handle_cast(_, state), do: {:noreply, state}

      defoverridable :ssh_channel
    end
  end
end
