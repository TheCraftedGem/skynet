require IEx

defmodule Skynet.Terminator do
  use GenServer

  def start_link(_) do
    # Creates GenServer Process
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # When A Process Begins These Functions Are Run
    prepare_next(reproduce?)
    battles_sarah(killed?)
    {:ok, state}
  end

  def handle_info(:prepare_next, state) do
    IEx.pry
    IO.puts("Terminator Created")
    Skynet.create_terminator
    {:noreply, state}
  end

  def handle_info(:failed_to_reproduce, state) do
    IO.puts("Terminator Failed To Create")
    prepare_next(reproduce?)
    {:noreply, state}
  end

  def handle_info(:battles_sarah, state) do
    IO.puts("Terminator Killed!")
    Skynet.kill_terminator(self())
    {:noreply, state}
  end

  def handle_info(:terminator_survives, state) do
    IO.puts("Terminator Survives")
    battles_sarah(killed?)
    {:noreply, state}
  end

  defp prepare_next(true) do
    # Waits 5 Seconds To Perform Action
    Process.send_after(self(), :prepare_next, 5000)
  end

  defp prepare_next(false) do
    # Waits 5 Seconds To Perform Action
    Process.send_after(self(), :failed_to_reproduce, 5000)
  end

  defp battles_sarah(true) do
    # Waits 10 Seconds To Perfome Action
    Process.send_after(self(), :battles_sarah, 10000)
  end

  defp battles_sarah(false) do
    # Waits 10 Seconds To Perfome Action
    Process.send_after(self(), :terminator_survives, 10000)
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
