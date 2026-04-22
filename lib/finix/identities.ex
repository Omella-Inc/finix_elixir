defmodule Finix.Identities do
  @moduledoc """
  # Identities

  An Identity resource represents either a person or business in Finix. You'll create an Identity to onboard your sellers, and verify the different owners.

  See Finix Indentities API Documentation for more info: https://finix.com/docs/api/tag/Identities/
  """

  @endpoint "identities"

  @finix_version [{"Finix-Version", "2022-02-01"}]

  @spec create(map(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def create(params, header_opts \\ []) do
    FinixElixir.make_request(:post, @endpoint, params, header_opts)
  end

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end

  @spec get_merchants(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get_merchants(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}/merchants", nil, header_opts)
  end

  @spec list(Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def list(header_opts \\ [], options \\ []) do
    FinixElixir.make_request(:get, @endpoint, nil, header_opts, options)
  end

  @spec create_user(String.t()) :: {:ok, map()} | {:error, map()}
  def create_user(identity_id) do
    FinixElixir.make_request(:post, "#{@endpoint}/#{identity_id}/users", %{}, @finix_version)
  end
end
