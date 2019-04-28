require IEx
defmodule SkynetServerTest do
  use ExUnit.Case

  test "when application starts 0 terminators alive" do
    assert Skynet.terminator_count() == 0
  end

  test "it create and kill a terminator" do
    {:ok, pid} = Skynet.create_terminator()
    assert Skynet.terminator_count() == 1
    # Skynet.start_tracker

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


end
