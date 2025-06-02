defmodule Finix.SettlementsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "get a settlement" do
    test "fetch a settlement" do
      use_cassette "settlements/get" do
        settlement_id = "ST7Zv9urzE2fkxtXq1NGMijk"
        {:ok, %{id: ^settlement_id}} = Finix.Settlements.get(settlement_id)
      end
    end
  end

  describe "update a settlement" do
    test "update a settlement" do
      use_cassette "settlements/update" do
        settlement_id = "ST3cN2PgJS9NqaqwchnHKsni"

        assert {:ok, %{id: ^settlement_id}} =
                 Finix.Settlements.update(settlement_id, %{action: "STOP_ACCRUAL"})
      end
    end
  end

  describe "list settlement entries" do
    test "list entries of a settlement" do
      use_cassette "settlements/list_entries" do
        settlement_id = "ST3cN2PgJS9NqaqwchnHKsni"
        {:ok, _} = Finix.Settlements.list_entries(settlement_id)
      end
    end
  end

  describe "list settlement funding transfers" do
    test "list funding transfers of a settlement" do
      use_cassette "settlements/list_funding_transfers" do
        settlement_id = "ST3cN2PgJS9NqaqwchnHKsni"
        {:ok, _} = Finix.Settlements.list_funding_transfers(settlement_id)
      end
    end
  end
end
