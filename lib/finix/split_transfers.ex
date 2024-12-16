defmodule Finix.SplitTransfers do
  @moduledoc """
  # Transfers

  A split_transfer represents how the funds from a split Transfer were distributed into a Merchants Settlement.

  See Finix Split Transfers API Documentation: https://finix.com/docs/api/tag/Split-Transfers/
  """

  @endpoint "split_transfers"

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end
end
