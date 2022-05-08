defmodule FunctionServerBasedOnArweave.CodeFetchers.NFT do
  alias Components.ExHttp
  require Logger

  defp get_data(func_str, params) do
    payload =
      func_str
      |> ABI.encode(params)
      |> Base.encode16(case: :lower)

    "0x" <> payload
  end

  def get_from_nft(code_id) do
    ar_txid =
      do_get_from_nft(code_id)
      |> String.slice(2..-1)
      |> Base.decode16!(case: :lower)
      |> ABI.TypeDecoder.decode_raw([:string])
      |> List.first()

    ArweaveSdkEx.get_content_in_tx(Constants.get_arweave_node(), ar_txid)
  end

  def do_get_from_nft(code_id) do
    Logger.info("do get from nft #{Constants.get_contract_endpoint()}, and code_id is #{code_id}")

    result =
      ExHttp.http_post(Constants.get_contract_endpoint(), %{
        "jsonrpc" => "2.0",
        "id" => 7,
        "method" => "eth_call",
        "params" => [
          %{
            from: "0x0000000000000000000000000000000000000000",
            data: get_data("code(uint256)", [code_id |> String.to_integer()]),
            to: Constants.get_contract_addr()
          }
        ]
      })

    case result do
      {:ok, value} ->
        Map.get(value, "result")

      {:error, _} ->
        Process.sleep(60000)
        do_get_from_nft(code_id)
    end
  end
end
