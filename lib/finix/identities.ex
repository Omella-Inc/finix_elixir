defmodule Finix.Identities do
  @moduledoc """
  # Identities

  An Identity resource represents either a person or business in Finix. You'll create an Identity to onboard your sellers, and verify the different owners.

  See Finix Indentities API Documentation for more info: https://finix.com/docs/api/tag/Identities/
  """

  @endpoint "identities"

  @spec create(map(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def create(params, header_opts \\ []) do
    FinixElixir.make_request(:post, @endpoint, params, header_opts)
  end

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end
end
