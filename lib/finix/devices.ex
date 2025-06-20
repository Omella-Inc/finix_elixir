defmodule Finix.Devices do
  @moduledoc """
  # Devices

  A Device represents any flow of funds either to or from a Payment Instrument. All payments in Finix are represented by a Device.

  See Finix Devices API Documentation: https://finix.com/docs/api/tag/Devices/
  """

  @endpoint "devices"

  @spec create(String.t(), map(), Keyword.t(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def create(merchant_id, payload, header_opts \\ [], options \\ []) do
    FinixElixir.make_request(
      :post,
      "merchants/#{merchant_id}/#{@endpoint}",
      payload,
      header_opts,
      options
    )
  end

  @spec get(String.t(), Keyword.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ [], options \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts, options)
  end

  @spec get_by(
          %{:merchant_id => String.t(), :serial_number => String.t()},
          Keyword.t(),
          Keyword.t()
        ) ::
          {:error, any()} | {:ok, map() | nil}
  def get_by(
        %{serial_number: serial_number, merchant_id: merchant_id},
        header_opts \\ [],
        options \\ []
      ) do
    FinixElixir.make_request(
      :get,
      "#{@endpoint}?serial_number=#{serial_number}&merchant_id=#{merchant_id}",
      nil,
      header_opts,
      options
    )
    |> case do
      {:ok, %{page: _, _embedded: %{devices: [first_device | _]}}} ->
        {:ok, first_device}

      {:ok, %{page: _}} ->
        {:ok, nil}

      {:ok, finix_response} ->
        {
          :error,
          "Unexpected response from finix while calling devices?serial_number=#{serial_number}&merchant_id=#{merchant_id}: #{inspect(finix_response)}"
        }

      {:error, reason} ->
        {:error, reason}
    end
  end

  def update(id, payload, header_opts \\ [], options \\ []) do
    FinixElixir.make_request(:put, "#{@endpoint}/#{id}", payload, header_opts, options)
  end
end
