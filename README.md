# Tic-Tac-Toe in Elixir

This is a game of tic-tac-toe implemented in Elixir. It features move validation and computer players.

## Installing Elixir and Mix

The [Elixir website](http://elixir-lang.org/install.html) has some instructions on how to get set up with Elixir and mix. If you have Homebrew installed on your computer, the command is simply:

```
brew update
brew install elixir
```

Those with MacPorts can run:

```
sudo port install elixir
```

Follow the instructions on the aforementioned website to ensure that the ```/path/to/elixir/bin``` directory is contained in the ```PATH``` variable.

## Development

This project uses mix as its build tool. If you want to play around with the app in a REPL, mix will automatically set it up and load all of the modules associated with the project:

```
iex -S mix
```

## Testing

This project uses ExUnit as its testing framework. You can run the entire suite of tests using the command:

```
mix test
```

You can also run an individual test file by specifying its path:

```
mix test test/<name of file>.exs
```

## Playing a Game of Tic-Tac-Toe

You can build an executable file using the following command:

```
mix escript.build
```

This will generate a file called ```tic_tac_toe``` in the root directory of the project. Then, you can start a game using ```./tic_tac_toe``` (you might need to use ```chmod``` to ensure that the program is executable).
