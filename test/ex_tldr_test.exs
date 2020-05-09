defmodule ExTldrTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest ExTldr

  test "look for a linux command" do
    execute_main = fn ->
      ExTldr.main(["linux", "adduser"])
    end

    assert capture_io(execute_main) =~ "# adduser"
  end

  test "look for a unavailable linux command available as common" do
    execute_main = fn ->
      ExTldr.main(["linux", "cat"])
    end

    assert capture_io(execute_main) =~ "# cat"
  end

  test "look for common command" do
    execute_main = fn ->
      ExTldr.main(["common", "tldr"])
    end

    assert capture_io(execute_main) =~ "# tldr"
  end

  test "without os specified" do
    execute_main = fn ->
      ExTldr.main(["acpi"])
    end

    assert_raise MatchError, execute_main
  end

  test "look for an nonexistent command" do
    execute_main = fn ->
      ExTldr.main(["linux", "unexistent_command"])
    end

    assert capture_io(execute_main) =~ "Term not found on \"common\" pages."
  end

  test "get help" do
    execute_main = fn ->
      ExTldr.main(["--help"])
    end

    assert capture_io(execute_main) =~ "Usage:"
  end

  test "get help when the script is executed withouts args" do
    execute_main = fn ->
      ExTldr.main([])
    end

    assert capture_io(execute_main) =~ "Usage:"
  end
end
