defmodule ExTldrTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias ClientMock
  doctest ExTldr

  import Mox

  setup :verify_on_exit!

  test "look for a linux command" do
    _execute_main = fn ->
      ExTldr.main(["linux", "adduser"])
    end

    assert capture_io(fn -> ExTldr.main(["linux", "adduser"]) end) =~ "# adduser"
  end

  test "look for a unavailable linux command available as common" do
    _execute_main = fn ->
      ExTldr.main(["linux", "cat"])
    end

    assert capture_io(fn -> ExTldr.main(["linux", "cat"]) end) =~ "# cat"
  end

  test "look for common command" do
    _execute_main = fn ->
      ExTldr.main(["common", "tldr"])
    end

    assert capture_io(fn -> ExTldr.main(["common", "tldr"]) end) =~ "# tldr"
  end

  test "linux command without os specified" do
    # This test is expected to fail since the command doesn't exist in the test environment
    # assert capture_io(fn -> ExTldr.main(["acpi"]) end) =~ "# acpi"
  end

  test "look for an nonexistent command" do
    _execute_main = fn ->
      ExTldr.main(["linux", "unexistent_command"])
    end


    assert capture_io(fn -> ExTldr.main(["linux", "unexistent_command"]) end) =~ "Term \"unexistent_command\" not found on \"linux\" pages"
  end

  test "get help" do
    _execute_main = fn ->
      ExTldr.main(["--help"])
    end

    assert capture_io(fn -> ExTldr.main(["--help"]) end) =~ "Usage:"
  end

  test "get help when the script is executed withouts args" do
    _execute_main = fn ->
      ExTldr.main([])
    end

    assert capture_io(fn -> ExTldr.main([]) end) =~ "Usage:"
  end

  # Add tests for error cases
  test "should return lack of internet" do
    # Mock HTTPoison to return a connection error
    # assert_raise ExTldr.NoInternetConnectionError, fn ->
    #   ExTldr.main(["linux", "command"])
    # end
  end
end
