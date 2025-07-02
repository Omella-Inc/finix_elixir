defmodule Finix.TransferTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "create a payment transfer" do
    test "create a payment transfer" do
      use_cassette "transfer/create" do
        {:ok, response} =
          Finix.Transfers.create(%{
            merchant: "MU3ZjRVavRhfYWo2GGgnjKPP",
            currency: "USD",
            amount: 2995,
            source: "PI9XHJBq7bTtuhL3ooU2RrYS",
            tags: %{
              test: "sale"
            },
            idempotency_id: "b52fee22-19d8-4171-ac75-3954f4c86b25"
          })

        refute response == %{}
        refute response[:id] == nil
      end
    end

    test "error 402 when creating a payment transfer" do
      use_cassette "transfer/create_error_402" do
        {:error, _} =
          Finix.Transfers.create(%{
            merchant: "MU3ZjRVavRhfYWo2GGgnjKPP",
            currency: "USD",
            amount: 1_000_000_000,
            source: "PI9XHJBq7bTtuhL3ooU2RrYS",
            tags: %{
              test: "sale"
            },
            idempotency_id: "b52fee22-19d8-4171-ac75-3954f4c86b31"
          })
      end
    end
  end

  describe "get a payment transfer" do
    test "retrieve a payment transfer" do
      use_cassette "transfer/get" do
        {:ok, response} = Finix.Transfers.get("TRjXjwbmxBMTxFhqxjno6PRE")

        assert %{
                 id: "TRjXjwbmxBMTxFhqxjno6PRE"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "transfer/get_not_found" do
        assert {:error, :not_found} = Finix.Transfers.get("not_tra_id")
      end
    end
  end

  describe "refund a payment" do
    test "refund a payment" do
      use_cassette "transfer/refund" do
        {:ok, response} =
          Finix.Transfers.refund("TRjXjwbmxBMTxFhqxjno6PRE", %{
            refund_amount: 100,
            idempotency_id: "b52fee22-19d8-4171-ac75-3954f4c86b27"
          })

        refute response == %{}
        refute response[:id] == nil
      end
    end
  end

  describe "list transfers" do
    test "retrieve a payment transfer" do
      use_cassette "transfer/list" do
        {:ok, _} = Finix.Transfers.list()
      end
    end
  end
end
