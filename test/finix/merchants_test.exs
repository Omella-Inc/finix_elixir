defmodule Finix.MerchantsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get a merchant account" do
    test "fetch a merchant account" do
      use_cassette "merchants/get" do
        {:ok, response} = Finix.Merchants.get("MU3ZjRVavRhfYWo2GGgnjKPP")

        assert %{
                 id: "MU3ZjRVavRhfYWo2GGgnjKPP"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "merchants/get_not_found" do
        assert {:error, :not_found} = Finix.Merchants.get("not_id")
      end
    end
  end
end
