defmodule Finix.MerchantProfileTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get a merchant profile" do
    test "retrieve a merchant profile" do
      use_cassette "merchant_profile/get" do
        {:ok, response} = Finix.Merchants.get_merchant_profile("MPt3aUsRWAUwmKkQaPb5Vtmm")

        assert %{
                 id: "MPt3aUsRWAUwmKkQaPb5Vtmm"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "merchant_profile/get_not_found" do
        assert {:error, :not_found} = Finix.Merchants.get_merchant_profile("not_id")
      end
    end
  end
end
