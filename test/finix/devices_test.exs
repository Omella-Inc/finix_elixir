defmodule Finix.DevicesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @sandbox_data %{
    device_id: "DVsPec2cPwzMaFz4YhKXs2qo",
    device_id2: "DVsuVx1sRzxveXf7u3LEfU7Y",
    serial_number: "2210073655",
    merchant_id: "MUb93oYCs6uxbmQJNyjhXX9C"
  }

  describe "get a device" do
    setup do: @sandbox_data

    test "fetches a device by id", %{
      device_id: device_id,
      serial_number: serial_number,
      merchant_id: merchant_id
    } do
      use_cassette "devices/get" do
        {
          :ok,
          %{id: ^device_id, serial_number: ^serial_number, merchant: ^merchant_id}
        } =
          Finix.Devices.get(device_id)
      end
    end

    test "fetches devices by serial_number and merchant_id", %{
      device_id: device_id,
      device_id2: device_id2,
      serial_number: serial_number,
      merchant_id: merchant_id
    } do
      use_cassette "devices/get_by" do
        {
          :ok,
          [
            %{id: ^device_id2, serial_number: ^serial_number, merchant: ^merchant_id},
            %{id: ^device_id, serial_number: ^serial_number, merchant: ^merchant_id}
          ]
        } =
          Finix.Devices.get_devices_by(%{serial_number: serial_number, merchant_id: merchant_id})
      end
    end

    test "returns nil when there is no device with the given serial_number and merchant_id", %{
      merchant_id: merchant_id
    } do
      use_cassette "devices/get_by_returning_no_device" do
        {:ok, []} =
          Finix.Devices.get_devices_by(%{
            serial_number: "some-invalid-serial-number",
            merchant_id: merchant_id
          })
      end
    end
  end

  describe "update a device" do
    setup do: @sandbox_data

    test "activates a device properly", %{device_id: device_id} do
      use_cassette "devices/activate_device" do
        {:ok, %{id: ^device_id, enabled: true}} =
          Finix.Devices.update(device_id, %{action: "ACTIVATE"})
      end
    end
  end

  describe "create a device" do
    setup do: @sandbox_data

    test "creates a device properly", %{serial_number: serial_number, merchant_id: merchant_id} do
      use_cassette "devices/create_device" do
        {:ok, %{serial_number: ^serial_number, enabled: false}} =
          Finix.Devices.create(merchant_id, %{
            model: "PAX_A800",
            name: "device created by finix_elixir",
            serial_number: serial_number,
            configuration_details: %{
              allow_debit: true,
              check_for_duplicate_transactions: true,
              prompt_amount_confirmation: true,
              prompt_manual_entry: false,
              bypass_device_on_capture: true,
              prompt_receipt_confirmation: false,
              display_tip_on_receipt: false,
              prompt_tip_on_screen: false,
              allow_standalone_authorizations: false,
              allow_standalone_sales: false,
              allow_standalone_refunds: false,
              tipping_details: %{
                percent_tipping_threshold: 0,
                percent_options: [18, 20, 22],
                fixed_options: [100, 150, 200],
                allow_custom_tip: true
              },
              idle_message: nil,
              idle_image_file_id: nil,
              automatic_receipt_delivery_methods: nil,
              available_receipt_methods: nil,
              prompt_for_signature: "NEVER",
              surcharge_basis_points: nil
            }
          })
      end
    end
  end
end
