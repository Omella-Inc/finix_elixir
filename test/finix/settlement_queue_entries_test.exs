defmodule Finix.SettlementQueueEntriesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "list settlement entries queue" do
    test "list settlement entries queue" do
      use_cassette "settlements_queue_entries/list" do
        {:ok, _} = Finix.SettlementQueueEntries.list()
      end
    end

    test "update a settlement queue entry" do
      use_cassette "settlements_queue_entries/update" do
        assert {:ok, _} =
                 Finix.SettlementQueueEntries.update(%{
                   ids: [
                     "settlement_queue_entry_nTFgdfnEBYjaCSusVeATN8"
                   ],
                   action: "RELEASE"
                 })
      end
    end
  end
end
