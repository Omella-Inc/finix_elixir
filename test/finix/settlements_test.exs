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
end
