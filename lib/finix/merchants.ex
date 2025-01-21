defmodule Finix.Merchants do
  @moduledoc """
  # Merchants

  A Merchant resource represents the entity's merchant account on a processor.

  See Finix Indentities API Documentation for more info: https://finix.com/docs/api/tag/Merchants/
  """

  @endpoint "merchants"

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end
end
