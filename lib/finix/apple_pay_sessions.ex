defmodule Finix.ApplePaySessions do
  @moduledoc """
  # ApplePaySessions

  Create an apple_pay_session to process Apple Pay transactions on the web.

  See Finix Apple pay session API Documentation: https://finix.com/docs/api/tag/Payment-Instruments/#tag/Payment-Instruments/operation/createApplePaySession
  """

  @endpoint "apple_pay_sessions"

  @spec create(map(), Keyword.t()) :: {:error, map()} | {:ok, map()}
  def create(params, header_opts \\ []) do
    FinixElixir.make_request(:post, @endpoint, params, header_opts)
  end
end
