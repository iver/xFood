# xFood

A mini challenge to consume the [San Francisco open data api](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat/data).

## Install & Setup

### Install

In order to run the application, you need Erlang and Elixir installed.

The preferred method of installing the prerequisite software is to use
[asdf](https://asdf-vm.com/). `asdf` should be installed via the "official download" described
[here](https://asdf-vm.com/guide/getting-started.html#official-download).
Then follow the appropriate instructions in the
[Install asdf](https://asdf-vm.com/guide/getting-started.html#_3-install-asdf) section, most likely
the **ZSH & Git**.

**Erlang and Elixir plugins:**

```terminal
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf install
```

### Getting the project

Clone the repository using git with ssh:

```terminal
git clone git@github.com:iver/xFood.git
```

If this is your first time configuring your git client, the manual on [how to connect github with ssh](https://docs.github.com/en/authentication/connecting-to-github-with-ssh) could be helpful.

### Environment Variables

To run the project locally and test the environment variables, you can be guided by the `.env.example` file.
If at any time the file is out of date, feel free to send a pull request with the change in the file.

To facilitate the assignment of environment variables on the local machine, it is recommended to use [direnv](https://direnv.net/).

### Setup the environment

* Copy `.env.example` file as `.envrc`

```terminal
cp .env.example .envrc
```

* Verify that the file has the variables assigned

```terminal
$ cat .envrc
export ECTO_HOST="localhost"
export ECTO_DB="xfood_dev"
export ECTO_USER="postgres"
export ECTO_PASS="postgres"
export ECTO_PORT=5432
export ECTO_POOL_SIZE=10
```

* Give permission to read the file to direnv

```terminal
$ direnv allow .envrc
direnv: loading ~/xfood/.envrc
direnv: export +PORT
```

* Don't forget ignore .envrc file

```terminal
echo ".envrc" >> .gitignore
```

## Start the project

To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:8080`](http://localhost:8080) from your browser.

### Logging in

To login to the application in development, visit the homepage in your
browser. Enter an email address in the "Email" field. The seed data step
above creates an account with test data under the email address
"<tester@iver.mx>", so that is the email you most likely want to use.
The password is `abcd12345678` by default.
Click on the "Submit" button.

### Testing

To run the [test watcher](https://github.com/lpil/mix-test.watch), run
`mix test.watch`.

## CI/CD

To facilitate code validation, `mix check` is used, the project is configured to compile on each commit using [GitHub Actions](https://github.com/features/actions) and [Gitlab CI](https://docs.gitlab.com/ee/ci/).

If you want to validate the code locally, just run:

```terminal
mix check
```

Currently, there are two branches (`main` and `develop`). The deployment configuration is linked to merges into the `main` branch. Nevertheless, continuous integration is active on both branches.

The GitHub Actions configuration is intended for deployment on [Fly.io](https://fly.io/). Due to time constraints, the deployment configuration has not yet been set up from GitLab, but it closely resembles the GitHub setup.

## Resources

* Official website: <https://www.phoenixframework.org/>
* Guides: <https://hexdocs.pm/phoenix/overview.html>
* Docs: <https://hexdocs.pm/phoenix>
* Forum: <https://elixirforum.com/c/phoenix-forum>
* Source: <https://github.com/phoenixframework/phoenix>
* Fly: <https://fly.io/docs/apps/launch/>