defmodule FinixElixir do
  use HTTPoison.Base

  @live_url "https://finix.live-payments-api.com/"
  @sandbox_url "https://finix.sandbox-payments-api.com/"

  def process_url(endpoint) do
    api_url()
    |> URI.parse()
    |> URI.to_string()
    |> Kernel.<>(endpoint)
  end

  def process_request_headers(opts) do
    opts
    |> Enum.concat([
      {"Content-Type", "application/json;charset=UTF-8"},
      {"Authorization", "Basic " <> Base.encode64("#{get_username()}:#{get_password()}")}
    ])
  end

  def process_request_body(body) do
    Jason.encode!(body)
  end

  def process_response_body(""), do: :no_content

  def process_response_body(body) do
    body
    |> Jason.decode()
    |> case do
      {:ok, data} -> data
      {:error, _} -> {:error, body}
    end
  end

  def make_request(method, endpoint, body \\ "", headers \\ [], options \\ []) do
    options =
      options
      |> Keyword.put(:recv_timeout, options[:timeout] || 30_000)
      |> Keyword.put(:ssl, [
        {:versions, [:"tlsv1.2", :"tlsv1.3", :"tlsv1.1", :tlsv1]},
        {:verify, :verify_none}
      ])

    case request(method, endpoint, body, headers, options) do
      {:error, _} = err -> err
      {:ok, response} -> handle_response(response)
    end
  end

  defp get_username,
    do: Application.get_env(:finix_elixir, :finix_username, System.get_env("FINIX_USERNAME"))

  defp get_password,
    do: Application.get_env(:finix_elixir, :finix_password, System.get_env("FINIX_PASSWORD"))

  defp api_url do
    if Application.get_env(:finix_elixir, :sandbox, false) do
      @sandbox_url
    else
      @live_url
    end
  end

  defp handle_response(response) do
    case response.status_code do
      code when code in 200..299 -> {:ok, response.body |> keys_to_atoms()}
      401 -> {:error, :unauthorized}
      404 -> {:error, :not_found}
      405 -> {:error, :method_not_allowed}
      406 -> {:error, :not_acceptable}
      409 -> {:error, :conflict}
      code when code in 400..499 -> {:error, response.body |> keys_to_atoms()}
      500 -> {:error, response.body |> keys_to_atoms()}
    end
  end

  defp keys_to_atoms(string_key_map) when is_map(string_key_map) do
    string_key_map
    |> Jason.encode!()
    |> Jason.decode!(keys: :atoms)
  end

  defp keys_to_atoms(data), do: data
end
