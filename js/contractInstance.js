if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    // set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("https://ropsten.infura.io/TJSJL5u9maRXnaZrSvnv"));
}

web3 = new Web3(web3.currentProvider);
web3.eth.defaultAccount = web3.eth.accounts[0];
var AssetTrackerRopstenAddress = '0x7f275a042801ff6deaad9e4f56b6b802b84ed5eb';
var AssetTrackerABI = web3.eth.contract (
    [
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                },
                {
                    "name": "_logLocationIdOnRack",
                    "type": "uint256"
                },
                {
                    "name": "_logLocationName",
                    "type": "string"
                }
            ],
            "name": "addDetailLogistic",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                },
                {
                    "name": "_machineNumber",
                    "type": "uint256"
                },
                {
                    "name": "_macQualityOfProduct",
                    "type": "uint256"
                },
                {
                    "name": "_macQuantityOfProduct",
                    "type": "uint256"
                }
            ],
            "name": "addDetailProductionStakeHolder",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                },
                {
                    "name": "_rawMaterialId",
                    "type": "uint256"
                },
                {
                    "name": "rawMaterialQuality",
                    "type": "uint256"
                },
                {
                    "name": "rawMaterialQuantity",
                    "type": "uint256"
                },
                {
                    "name": "origin",
                    "type": "string"
                }
            ],
            "name": "addDetailRawMaterialStakeHolder",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                },
                {
                    "name": "_macLocationIdOnRack",
                    "type": "uint256"
                },
                {
                    "name": "_macLocationName",
                    "type": "string"
                }
            ],
            "name": "addDetailShipmentStakeHolder",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_name",
                    "type": "string"
                },
                {
                    "name": "_desc",
                    "type": "string"
                },
                {
                    "name": "_productionQualityLowerLimit",
                    "type": "uint256"
                },
                {
                    "name": "_rawMaterialQualityLowerLimit",
                    "type": "uint256"
                }
            ],
            "name": "placeOrder",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_assemblyAddress",
                    "type": "address"
                }
            ],
            "name": "setAssemblyAddress",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "newContractCreator",
                    "type": "address"
                }
            ],
            "name": "setContractCreator",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_logisticAddress",
                    "type": "address"
                }
            ],
            "name": "setLogisticAddress",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "newMachiningAddress",
                    "type": "address"
                }
            ],
            "name": "setMachiningAddress",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "name": "_machiningAddress",
                    "type": "address"
                },
                {
                    "name": "_logisticAddress",
                    "type": "address"
                },
                {
                    "name": "_assemblyAddress",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "name": "assetIdToOwner",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                }
            ],
            "name": "getAssetOverview",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                },
                {
                    "name": "",
                    "type": "string"
                },
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "address"
                },
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                }
            ],
            "name": "getAssetProductionInformation",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                }
            ],
            "name": "getAssetRawMaterialInformation",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                },
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                }
            ],
            "name": "getAssetShipmentInformation",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_id",
                    "type": "uint256"
                }
            ],
            "name": "getLogisticInformation",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                },
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "last",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        }
    ]
);
var ContractInstance = AssetTrackerABI.at(AssetTrackerRopstenAddress);
