# FinixElixir

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `finix_elixir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:finix_elixir, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/finix_elixir>.


## Testing with ExVCR

To add new tests that uses new endpoints, you will need add the following environment variables:
- `FINIX_USERNAME`
- `FINIX_PASSWORD`

This is required to access the real API and save request results into files under `fixtures/vcr_cassettes` folder.
Once you run `mix test`, if request/response map is not saved, it will call the API and will create a new fixture for that call.

You can delete a vcr using `mix vcr.delete`.

