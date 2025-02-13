defmodule Finix.SettlementQueueEntries do
  @moduledoc """
  # Settlement Queue Entries

  A Settlement Queue Entry resource represents an entry in the settlement queue used to track when and how a transfer is queued to be processed.

  https://finix.com/docs/api/tag/Settlement-Queue-Entries/
  """

  @endpoint "settlement_queue_entries"

  @finix_version [{"Finix-Version", "2022-02-01"}]

  @spec list(Keyword.t()) :: {:ok, map()} | {:error, map()}
  def list(options \\ [], header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}", nil, header_opts ++ @finix_version, options)
  end

  @spec update(map(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def update(params, header_opts \\ []) do
    FinixElixir.make_request(:put, "#{@endpoint}", params, header_opts ++ @finix_version)
  end
end
