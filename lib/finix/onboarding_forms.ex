defmodule Finix.OnboardingForms do
  @moduledoc """
  # OnboardingForms

  An Onboarding Form resource represents the merchant hosted onboard form.

  See Finix Onboarding Forms API Documentation for more info: https://docs.finix.com/api/onboarding-forms
  """

  @endpoint "onboarding_forms"

  @finix_version [{"Finix-Version", "2022-02-01"}]

  @spec get(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def get(id, header_opts \\ []) do
    FinixElixir.make_request(:get, "#{@endpoint}/#{id}", nil, header_opts ++ @finix_version)
  end

  @spec create(map(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def create(body, header_opts \\ []) do
    FinixElixir.make_request(:post, "#{@endpoint}", body, header_opts ++ @finix_version)
  end

  @spec create_link(String.t(), map(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def create_link(id, body, header_opts \\ []) do
    FinixElixir.make_request(
      :post,
      "#{@endpoint}/#{id}/links",
      body,
      header_opts ++ @finix_version
    )
  end
end
