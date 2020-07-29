# LearnGenserver

> Learn GenServer by Building Your Own URL Shortener

## Running

### Example

```elixir
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
```

## Credits

[OTP in Elixir](https://ieftimov.com/post/otp-elixir-genserver-build-own-url-shortener/)

## About Me

[Magak Emmanuel](https://magak.me)

## License

[![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=for-the-badge)](#)

[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source-200x33.png?v=103)](#)

Happy coding, Star before Fork 😊💪💯
