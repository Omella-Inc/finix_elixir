defmodule Finix.Merchants do
  @moduledoc """
  # Merchants

  A Merchant resource represents the entity's merchant account on a processor.

  See Finix Indentities API Documentation for more info: https://finix.com/docs/api/tag/Merchants/
  """

  @endpoint "merchants"

  @finix_version [{"Finix-Version", "2022-02-01"}]

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts ++ @finix_version)
  end

  @spec update(String.t(), map(), Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def update(id, body, header_opts \\ [], options \\ []) do
    FinixElixir.make_request(
      :put,
      "#{@endpoint}/#{id}",
      body,
      header_opts ++ @finix_version,
      options
    )
  end

  def get_merchant_profile(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "merchant_profiles/#{id}", nil, header_opts ++ @finix_version)
  end

  def get_payout_profile(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "payout_profiles/#{id}", nil, header_opts ++ @finix_version)
  end

  def update_payout_profile(id, body, header_opts \\ []) do
    FinixElixir.make_request(:put, "payout_profiles/#{id}", body, header_opts ++ @finix_version)
  end
end
