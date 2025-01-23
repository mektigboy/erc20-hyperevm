include .env
export

RPC_URL ?= https://api.hyperliquid-testnet.xyz/evm
VERIFIER_URL ?= https://evm.hyperstats.xyz/api/
CONFIRMATIONS ?= 1

balance:
	@cast balance $(ADDRESS) --rpc-url $(RPC_URL)

token-balance:
	@cast call --rpc-url $(RPC_URL) $(DEPLOYED_TOKEN_ADDRESS) \
	"balanceOf(address)" $(ADDRESS) | \
	xargs cast --to-dec

deploy:
	@forge create --rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--broadcast \
	src/TestToken.sol:TestToken

verify:
	@forge verify-contract \
	--rpc-url $(RPC_URL) \
	--verifier blockscout \
	--verifier-url $(VERIFIER_URL) \
	$(DEPLOYED_TOKEN_ADDRESS) \
	src/TestToken.sol:TestToken

mint:
	@cast send \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--confirmations $(CONFIRMATIONS) \
	$(DEPLOYED_TOKEN_ADDRESS) \
	"mint(address,uint256)" \
	$(ADDRESS) \
	$(filter-out $@,$(MAKECMDGOALS))

burn:
	@cast send \
	--rpc-url $(RPC_URL) \
	--private-key $(PRIVATE_KEY) \
	--confirmations $(CONFIRMATIONS) \
	$(DEPLOYED_TOKEN_ADDRESS) \
	"burn(address,uint256)" \
	$(ADDRESS) \
	$(filter-out $@,$(MAKECMDGOALS))

%:
	@:
