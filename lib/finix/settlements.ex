defmodule Finix.Settlements do
  @moduledoc """
  # Settlements

  A Settlement is a logical construct representing a collection (i.e. batch) of Settlement Entries that will get paid out to a specific Merchant.

  https://finix.com/docs/api/tag/Settlements/
  """

  @endpoint "settlements"

  @finix_version [{"Finix-Version", "2022-02-01"}]

  @spec get(String.t(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts ++ @finix_version)
  end

  @spec update(String.t(), map(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def update(id, params, header_opts \\ []) do
    FinixElixir.make_request(:put, "#{@endpoint}/#{id}", params, header_opts ++ @finix_version)
  end

  @spec list_entries(String.t(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def list_entries(id, options \\ [], header_opts \\ []) do
    FinixElixir.make_request(
      :get,
      "#{@endpoint}/#{id}/entries",
      nil,
      header_opts ++ @finix_version,
      options
    )
  end
end
