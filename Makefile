include .env
export

deploy:
	@forge create --rpc-url https://api.hyperliquid-testnet.xyz/evm --private-key $(PRIVATE_KEY) --broadcast src/TestToken.sol:TestToken

verify:
	@forge verify-contract --rpc-url https://api.hyperliquid-testnet.xyz/evm --verifier blockscout --verifier-url 'https://evm.hyperstats.xyz/api/' $(DEPLOYED_TOKEN_ADDRESS) src/TestToken.sol:TestToken

balance:
	cast balance $(ADDRESS) --rpc-url $(RPC_URL)

