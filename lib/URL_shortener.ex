defmodule URLShortener do
  @moduledoc """
  Let's write a URL shortener module that will run in a BEAM process and can receive multiple commands:

  shorten – takes a link, shortens it and returns the short link as a response
  get – take a short link and return the original one
  flush – erase the URL shortener memory
  stop – stop the process
  What the module does is when the process starts it will recursively call the URLShortener.loop/1 function, until it receives the {:stop, caller} message.

  ## Example
        iex(22)> shortener = URLShortener.start
        #PID<0.141.0>

        iex(23)> send shortener, {:shorten, "https://ieftimov.com", self()}
        {:shorten, "https://ieftimov.com", #PID<0.102.0>}

        iex(24)> send shortener, {:shorten, "https://google.com", self()}
        {:shorten, "https://google.com", #PID<0.102.0>}

        iex(25)> send shortener, {:shorten, "https://github.com", self()}
        {:shorten, "https://github.com", #PID<0.102.0>}

        iex(26)> flush
        "8c4c7fbc57b08d379da5b1312690be04"
        "99999ebcfdb78df077ad2727fd00969f"
        "3097fca9b1ec8942c4305e550ef1b50a"
        :ok

        iex(27)> send shortener, {:get, "99999ebcfdb78df077ad2727fd00969f", self()}
        {:get, "99999ebcfdb78df077ad2727fd00969f", #PID<0.102.0>}

        iex(28)> flush
        "https://google.com"
        :ok

        iex(29)> send shortener, {:get, "8c4c7fbc57b08d379da5b1312690be04", self()}
        {:get, "8c4c7fbc57b08d379da5b1312690be04", #PID<0.102.0>}

        iex(30)> flush
        "https://ieftimov.com"
        :ok

        iex(31)> send shortener, {:get, "3097fca9b1ec8942c4305e550ef1b50a", self()}
        {:get, "3097fca9b1ec8942c4305e550ef1b50a", #PID<0.102.0>}

        iex(32)> flush
        "https://github.com"
        :ok
  """

  def start do
    spawn(__MODULE__, :loop, [%{}])
  end

  def loop(state) do
    receive do
      {:stop, caller} ->
        send(caller, "Shutting down.")

      {:shorten, url, caller} ->
        url_md5 = md5(url)
        new_state = Map.put(state, url_md5, url)
        send(caller, url_md5)
        loop(new_state)

      {:get, md5, caller} ->
        send(caller, Map.fetch(state, md5))
        loop(state)

      :flush ->
        loop(%{})

      _ ->
        loop(state)
    end
  end

  defp md5(url) do
    :crypto.hash(:md5, url)
    |> Base.encode16(case: :lower)
  end
end
