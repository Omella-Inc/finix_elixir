defmodule Finix.Transfers do
  @moduledoc """
  # Transfers

  A Transfer represents any flow of funds either to or from a Payment Instrument. All payments in Finix are represented by a Transfer.

  See Finix Transfers API Documentation: https://finix.com/docs/api/tag/Transfers/
  """

  @endpoint "transfers"

  @spec create(map(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def create(params, header_opts \\ []) do
    FinixElixir.make_request(:post, @endpoint, params, header_opts)
  end

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end

  @spec refund(String.t(), map(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def refund(id, params, header_opts \\ []) do
    FinixElixir.make_request(:post, "#{@endpoint}/#{id}/reversals", params, header_opts)
  end
end
