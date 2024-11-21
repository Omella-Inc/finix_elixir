defmodule Finix.PaymentInstrumentsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create a payment instrument" do
    test "create a payment instrument" do
      use_cassette "payment_instruments/create" do
        {:ok, response} =
          Finix.PaymentInstruments.create(%{
            type: "TOKEN",
            token: "TKkMoyQ7FNgV2rdkgeHEKVgj",
            identity: "ID5Kz3kHdaMTXZWL5TKZufGL"
          })

        refute response == %{}
        refute response[:id] == nil
      end
    end
  end

  describe "get a payment instrument" do
    test "get a payment instrument" do
      use_cassette "payment_instruments/get" do
        {:ok, response} = Finix.PaymentInstruments.get("PIg95MiZrNa4W18DP1oZi9N")

        assert %{
                 id: "PIg95MiZrNa4W18DP1oZi9N"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "payment_instruments/get_not_found" do
        assert {:error, :not_found} = Finix.PaymentInstruments.get("not_id")
      end
    end
  end

  describe "list payment instrument" do
    test "search a payment instrument by owner id" do
      use_cassette "payment_instruments/list" do
        {:ok, response} =
          Finix.PaymentInstruments.list([],
            params: %{"owner_identity_id" => "ID5Kz3kHdaMTXZWL5TKZufGL"}
          )

        assert %{
                 _embedded: %{
                   payment_instruments: [
                     %{id: "PIg95MiZrNa4W18DP1oZi9N", identity: "ID5Kz3kHdaMTXZWL5TKZufGL"} | _
                   ]
                 }
               } = response
      end
    end
  end
end
