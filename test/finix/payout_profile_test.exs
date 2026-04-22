defmodule Finix.PayoutProfileTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get a payout profile" do
    test "retrieve a payout profile" do
      use_cassette "payout_profile/get" do
        {:ok, response} = Finix.Merchants.get_payout_profile("POczhL6r6daw7E67k7YCAUq")

        assert %{
                 id: "POczhL6r6daw7E67k7YCAUq"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "payout_profile/get_not_found" do
        assert {:error, :not_found} = Finix.Merchants.get_payout_profile("not_id")
      end
    end
  end

  describe "update a payout profile" do
    test "update a payout profile" do
      use_cassette "payout_profile/update" do
        {:ok, response} =
          Finix.Merchants.update_payout_profile("POczj6f5RLtd8in1sZjfTdh", %{
            type: "NET",
            net: %{
              frequency: "MONTHLY",
              day_of_month: 28,
              funding_requirement: "DEFAULT",
              payment_instrument_id: "PI5RcHz8aAQkrTL1uWi7WbnY",
              rail: "NEXT_DAY_ACH",
              submission_delay_days: 0
            }
          })

        assert %{
                 type: "NET",
                 net: %{
                   frequency: "MONTHLY"
                 }
               } = response
      end
    end
  end
end
