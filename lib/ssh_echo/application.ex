defmodule SSHEcho.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(SSHEcho.Controller, []),
    ]

    opts = [strategy: :one_for_one, name: SSHEcho.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
