require IEx

defmodule Skynet.Terminator do
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
    if reproduce?() == true do
      IO.puts("Terminator Created")
      Skynet.create_terminator
    else
      IO.puts("Terminator Failed To Create")
      prepare_next()
    end
    {:noreply, state}
  end

  def handle_info(:battles_sarah, state) do
    if killed?() == true do
      IO.puts("Terminator Killed!")
      Skynet.kill_terminator(self())
    else
      IO.puts("Terminator Survives")
      battles_sarah()
      {:noreply, state}
    end
  end

  defp prepare_next do
    # Waits 5 Seconds To Perform Action
    Process.send_after(self(), :prepare_next, 5000)
  end

  defp battles_sarah do
    # Waits 10 Seconds To Perfome Action
    Process.send_after(self(), :battles_sarah, 10000)
  end

  def killed? do
    # Every 10 Seconds 25% chance of getting killed by sarah
    :rand.uniform <= 0.25
    #  If True kill_current_agent and print terminator killed
  end

  def reproduce? do
    #  Every 5 Seconds 20% Chanace Reproducing
    :rand.uniform <= 0.20
    # If true create new terminator and print terminator spawned
  end
end
