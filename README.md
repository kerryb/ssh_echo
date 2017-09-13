# SSHEcho

An echo server, to allow basic testing of SSH clients. Currently only supports 'exec' commands, not interactive shells.

To start listening on a port:

    iex> SSHEcho.start_daemon 55555, "fred", "secret"
    :ok

This will now echo back any 'exec'ed commands to that port:

    $ ssh -p 55555 fred@localhost hello
    SSH server
    Enter password for "fred"
    password:
    hello
    $

Then to stop the daemon:

    iex> SSHEcho.stop_daemon 55555

### Custom message handlers

The default echo behaviour can be overridden:

    iex> SSHEcho.start_daemon 55555, "fred", "secret", &String.upcase/1
    :ok

    $ ssh -p 55555 fred@localhost hello
    SSH server
    Enter password for "fred"
    password:
    HELLO
    $

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ssh_echo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ssh_echo, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ssh_echo](https://hexdocs.pm/ssh_echo).

