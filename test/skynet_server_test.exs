require IEx

defmodule SkynetServerTest do
  use ExUnit.Case
  alias Skynet.Terminator

  ## API TESTS

  test "when application starts 0 terminators alive" do
    assert Skynet.terminator_count() == 0
  end

  test "it create and kill a terminator" do
    {:ok, pid} = Skynet.create_terminator()
    assert Skynet.terminator_count() == 1

    Skynet.kill_terminator(pid)

    assert Skynet.terminator_count() == 0
  end

  test "it can create and kill multiple terminators" do
    {:ok, pid} = Skynet.create_terminator()
    {:ok, pid_2} = Skynet.create_terminator()
    {:ok, pid_3} = Skynet.create_terminator()
    {:ok, pid_4} = Skynet.create_terminator()

    assert Skynet.terminator_count() == 4

    Skynet.kill_terminator(pid)
    Skynet.kill_terminator(pid_2)
    Skynet.kill_terminator(pid_3)
    Skynet.kill_terminator(pid_4)

    assert Skynet.terminator_count() == 0
  end

  # Callback/Server Tests

  test "prepare next callback starts new terminator worker" do
    {:noreply, parent, child} = Terminator.handle_info(:reproduce_terminator, %{})

    assert Skynet.terminator_count() == 1

    is_pid(parent)
    is_pid(child)

    Skynet.kill_terminator(child)

    assert Skynet.terminator_count() == 0
  end

  test "failed to reproduce callback returns message" do
    {:noreply, pid, message} = Terminator.handle_info(:failed_to_reproduce, %{})

    is_pid(pid)
    assert message == "Terminator Failed To Create"
  end

  test "terminator killed callback returns message" do
    {:noreply, pid, message} = Terminator.handle_info(:terminator_killed, %{})

    is_pid(pid)
    assert message == "Terminator Killed"
  end

  test "terminator survives callback returns message" do
    {:noreply, pid, message} = Terminator.handle_info(:terminator_survives, %{})

    is_pid(pid)
    assert message == "Terminator Survives"
  end
end
