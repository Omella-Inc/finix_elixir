defmodule Finix.OnboardingFormsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get an onboarding form" do
    test "get an onboarding form" do
      use_cassette "onboarding_forms/get" do
        {:ok, response} = Finix.OnboardingForms.get("obf_stR87b52Qcmjq6Sve9Crjo")

        assert %{
                 id: "obf_stR87b52Qcmjq6Sve9Crjo"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "onboarding_forms/get_not_found" do
        assert {:error, :not_found} = Finix.OnboardingForms.get("not_id")
      end
    end
  end

  describe "create an onboarding form" do
    test "create an onboarding form" do
      use_cassette "onboarding_forms/create" do
        {:ok, %{id: id}} =
          Finix.OnboardingForms.create(%{
            merchant_processors: [
              %{
                processor: "DUMMY_V1"
              }
            ],
            onboarding_data: %{
              max_transaction_amount: 100_000
            },
            onboarding_link_details: %{
              return_url: "https://www.democompany.com/home",
              expired_session_url: "https://www.democompany.com/login",
              fee_details_url: "https://www.democompany.com/fee_details",
              terms_of_service_url: "https://www.democompany.com/ToS",
              expiration_in_minutes: 10080
            }
          })

        refute is_nil(id)
      end
    end
  end

  describe "create an onboarding form link" do
    test "create an onboarding form link" do
      use_cassette "onboarding_forms/create_link" do
        {:ok, %{link_url: link_url}} =
          Finix.OnboardingForms.create_link("obf_stR87b52Qcmjq6Sve9Crjo", %{
            return_url: "https://www.democompany.com/home",
            expired_session_url: "https://www.democompany.com/login",
            fee_details_url: "https://www.democompany.com/fee_details",
            terms_of_service_url: "https://www.democompany.com/ToS",
            merchant_max_transaction_amount: 100_000,
            merchant_ach_max_transaction_amount: 100_000,
            expiration_in_minutes: 10080
          })

        refute is_nil(link_url)
      end
    end
  end
end
