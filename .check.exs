[
  ## all available options with default values (see `mix check` docs for description)
  parallel: true,
  skipped: false,
  retry: false,
  ## list of tools (see `mix check` docs for a list of default curated tools)
  tools: [
    {:credo, "mix credo --strict -a"},
    {:ex_unit, "mix coveralls --warnings-as-errors"},
    {:sobelow, "mix sobelow --config"},
    {:doctor, "mix doctor --short"},
    {:dialyzer, "mix dialyzer --plt"},

    ## curated tools may be disabled (e.g. the check for compilation warnings)
    # {:compiler, false},
    {:npm_test, false},

    ## ...or have command & args adjusted (e.g. enable skip comments for sobelow)
    # {:sobelow, "mix sobelow --exit --skip"},

    {:compiler, env: %{"MIX_ENV" => "test"}},
    {:dialyzer, env: %{"MIX_ENV" => "test"}},
    {:ex_doc, env: %{"MIX_ENV" => "dev"}},
    {:formatter, env: %{"MIX_ENV" => "test"}},
    {:audit, "mix deps.audit"}
  ]
]
