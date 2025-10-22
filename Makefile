-include .env
.PHONY: all test clean deploy fund help install snapshot format anvil zktest

deploy-sepolia-basic:; forge script script/DeployBasicNFT.s.sol:DeployBasicNft --rpc-url $(SEPOLIA_RPC_URL) --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

deploy-sepolia-dpe:; forge script script/DeployDPENft.s.sol:DeployDPENft --rpc-url $(SEPOLIA_RPC_URL) --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

deploy-anvil-dpe:; forge script script/DeployDPENft.s.sol:DeployDPENft --rpc-url $(ANVIL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

deploy-zk-dpe:; forge script script/DeployDPENft.s.sol:DeployDPENft --rpc-url $(ZK_RPC_URL)  --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

deploy-arb-dpe:; forge script script/DeployDPENft.s.sol:DeployDPENft --rpc-url $(ARB_RPC_URL)  --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

deploy-sepolia-svg:; forge script script/DeploySVG.s.sol:DeploySVG --rpc-url $(SEPOLIA_RPC_URL)  --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

send-svg-anvil:; forge script script/Interactions.s.sol:SendSVG --rpc-url $(ANVIL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast -vvvv

mint-basic:; forge script script/Interactions.s.sol:MintBasicNFT --rpc-url $(SEPOLIA_RPC_URL)  --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

mint-dpe:; forge script script/Interactions.s.sol:MintDPENFT --rpc-url $(SEPOLIA_RPC_URL)  --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

mint-zk-dpe:; forge script script/Interactions.s.sol:MintDPENFT --rpc-url $(ZK_RPC_URL)  --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

mint-arb-dpe:; forge script script/Interactions.s.sol:MintDPENFT --rpc-url $(ARB_RPC_URL)  --account myacc --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

mint-anvil:; forge script script/Interactions.s.sol:MintDPENFT --rpc-url $(ANVIL) --private-key $(ANVIL_PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHSCAN_KEY) -vvvv

send-svg:; forge script script/Interactions.s.sol:SendSVG --rpc-url $(SEPOLIA_RPC_URL)  --account myacc --broadcast -vvvv

