require IEx

defmodule Skynet.Terminator do
  alias Skynet.TerminatorTracker
  use GenServer



  def start_link(_) do
    # Creates GenServer Process
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # When A Process Begins These Functions Are Run
    prepare_next()
    battles_sarah()
    {:ok, state}
  end


  def handle_info(:prepare_next, state) do
    if reproduce? == true do
      IO.puts("Terminator Created")
      #Calls The Parent Module
      Skynet.create_terminator
    else
      IO.puts("Termiated Failed To Create")
      prepare_next()
    end
    {:noreply, state}
  end

  def handle_info(:battles_sarah, state) do
    # Do the desired work here
    if killed? == true do
      IO.puts("Terminator Killed!")
      Process.exit(self, :kill)
    else
      IO.puts("Termiated Survives")
      prepare_next()
    end
    {:noreply, state}
  end

  defp prepare_next do
    # Waits 5 Seconds To Perform Action
    Process.send_after(self(), :prepare_next, 5 * 1000)
  end

  defp battles_sarah do
    # Waits 10 Seconds To Perfome Action
    Process.send_after(self(), :battles_sarah, 10 * 1000)
  end

  def killed? do
    # Every 10 Seconds 25% chance of getting killed by sarah
    Enum.random([false, false, false, true])
    #  If True kill_current_agent and print terminator killed
  end

  def reproduce? do
    #  Every 5 Seconds 20% Chanace Reproducing
    Enum.random([false, false, false, false, true])
    # If true create new terminator and print terminator spawned
  end

end
