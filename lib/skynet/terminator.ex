require IEx

defmodule Skynet.Terminator do
  use GenServer

  def start_link(_) do
    # Creates GenServer Process
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # When A Process Begins These Functions Are Run
    battles_sarah(killed?())
    spawn_next(reproduce?())

    {:ok, state}
  end

  def handle_info(:reproduce_terminator, _state) do
    IO.puts("Terminator Created")
    {:ok, pid} = Skynet.create_terminator()
    {:noreply, self(), pid}
  end

  def handle_info(:failed_to_reproduce, _state) do
    IO.puts("Terminator Failed To Create")
    spawn_next(reproduce?())
    {:noreply, self(), "Terminator Failed To Create"}
  end

  def handle_info(:terminator_killed, state) do
    IO.puts("Terminator Killed!")
    Skynet.kill_terminator(self())
    {:noreply, state}
  end

  def handle_info(:terminator_survives, _state) do
    IO.puts("Terminator Survives")
    battles_sarah(killed?())
    {:noreply, self(), "Terminator Survives"}
  end

  defp spawn_next(true) do
    # Waits 5 Seconds To Perform Action
    Process.send_after(self(), :reproduce_terminator, 5000)
  end

  defp spawn_next(false) do
    # Waits 5 Seconds To Perform Action
    Process.send_after(self(), :failed_to_reproduce, 5000)
  end

  defp battles_sarah(true) do
    # Waits 10 Seconds To Perfome Action
    Process.send_after(self(), :terminator_killed, 10000)
  end

  defp battles_sarah(false) do
    # Waits 10 Seconds To Perfome Action
    Process.send_after(self(), :terminator_survives, 10000)
  end

  def killed? do
    # Every 10 Seconds 25% chance of getting killed by sarah
    :rand.uniform() <= 0.25
  end

  def reproduce? do
    #  Every 5 Seconds 20% Chanace Reproducing
    :rand.uniform() <= 0.20
  end
end
