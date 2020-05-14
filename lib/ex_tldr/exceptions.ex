defmodule NoInternetConnectionError do
  defexception message:
                 "There is not internet connection or there are problems with the connection."
end

defmodule UnexpectedError do
  defexception message:
                 "An unexpected error has occurred. If you want, you can report it in https://github.com/tldr-pages/extldr\nIf you do it, please, share the error shown below."
end
