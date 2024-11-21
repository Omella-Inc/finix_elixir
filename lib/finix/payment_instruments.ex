defmodule Finix.PaymentInstruments do
  @moduledoc """
  # PaymentInstruments

  A Payment Instrument resource represents the payment details of a credit card or bank account. Payment details get tokenized multiple times and each tokenization produces a unique Payment Instrument.

  See Finix Transfers API Documentation: https://finix.com/docs/api/tag/Payment-Instruments
  """

  @endpoint "payment_instruments"

  @spec create(map(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def create(params, header_opts \\ []) do
    FinixElixir.make_request(:post, @endpoint, params, header_opts)
  end

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts)
  end

  @spec list(Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def list(header_opts \\ [], options \\ []) do
    FinixElixir.make_request(:get, @endpoint, nil, header_opts, options)
  end
end
