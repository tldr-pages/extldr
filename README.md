# ExTldr

ExTldr is an Elixir client for [tldr-pages](https://github.com/tldr-pages/tldr).

## Requirement

  - Erlang/OTP installed (it does not require Elixir, because Elixir is embedded in the script).
  - Download ExTldr. You can:
    - [Download the latest release](https://github.com/ivanhercaz/extldr/releases).
    - Clone this repository.

## Usage

Once you have downloaded ExTldr, and unzipped in the case you downloaded a release, you can execute the script: `./extldr`

The first argument of the script is the operating system, the second argument is the command/term you want search. Below there are some examples:

  - Search Linux command `adduser`: `extldr linux adduser`

  - Search a common command, `chroot`, in different operating system: `extldr common chroot`

  - Search Linux command `cat`, available in common pages due it is available in different operating systems: `extldr linux cat`

Then, if you like, you can make it globally available with a symbolic link or adding it to your `PATH`.

## Planned for next versions

Although I prefer to track possible enhancements and ideas in the issues, below there are some essentials:

  - Multilingual support.
  - Check by default the operating system in which ExTldr is being executed.

## License

ExTldr is license under the [GNU General Public License v3.0](https://github.com/ivanhercaz/extldr/blob/master/COPYING).
