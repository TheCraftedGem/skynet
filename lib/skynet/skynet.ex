require IEx
defmodule Skynet do
  alias Skynet.TerminatorSupervisor
  alias Skynet.Terminator
  alias Skynet.TerminatorTracker
  use GenServer

  def terminator_count do
    Supervisor.count_children(TerminatorSupervisor).active
  end

  def create_terminator do
    DynamicSupervisor.start_child(TerminatorSupervisor, Terminator)
    # IO.puts("First Terminator Created")
  end

  def kill_terminator(pid) do
    DynamicSupervisor.terminate_child(TerminatorSupervisor, pid)
    # IO.puts("Targeted Terminator Destroyed")
  end

  def list_terminators do
    Supervisor.which_children(TerminatorSupervisor)
  end

end
