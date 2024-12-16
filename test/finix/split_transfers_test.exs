defmodule Finix.SplitTransferTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get a split transfer" do
    test "retrieve a split transfer" do
      use_cassette "split_transfer/get" do
        {:ok, response} = Finix.SplitTransfers.get("split_transfer_aHU5gwUhWJihCLsyD9JBZp")

        assert %{
                 id: "split_transfer_aHU5gwUhWJihCLsyD9JBZp"
               } = response
      end
    end

    test "returns error not found" do
      use_cassette "split_transfer/get_not_found" do
        assert {:error, _} = Finix.SplitTransfers.get("not_tra_id")
      end
    end
  end
end
