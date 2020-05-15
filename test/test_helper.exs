ExUnit.start()

Mox.defmock(
  ClientMock,
  for: HTTPoison.Base
)
