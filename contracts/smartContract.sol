pragma solidity ^0.4.18;
contract AssetTracker {
    function AssetTracker(address _machiningAddress, address _logisticAddress , address _assemblyAddress) {
        contractCreatorAddress=msg.sender;
        machiningAddress=_machiningAddress;
        logisticAddress=_logisticAddress;
        assemblyAddress =_assemblyAddress;
    }
    address contractCreatorAddress;
    address machiningAddress;
    address logisticAddress;
    address assemblyAddress;
    
    modifier onlyContractCreator() {
        require(msg.sender == contractCreatorAddress);
        _;
    }
    modifier onlyMachiningAddress() {
        require(msg.sender == machiningAddress);
        _;
    }
    modifier onlyLogisticAddress() {
        require(msg.sender == logisticAddress);
        _;
    }
    modifier onlyAssemblyAddress() {
        require(msg.sender == assemblyAddress);
        _;
    }
    function changeStatus(uint256 _id, uint256 _status) internal {
        assetStore[_id].status=_status;
    }
    
    function setContractCreator(address newContractCreator) onlyContractCreator{
        contractCreatorAddress=newContractCreator;
    }
    function setMachiningAddress(address newMachiningAddress) onlyContractCreator{
        machiningAddress=newMachiningAddress;
    }
    function setLogisticAddress(address _logisticAddress) onlyContractCreator{
        logisticAddress=_logisticAddress;
    }
    function setAssemblyAddress(address _assemblyAddress) onlyContractCreator{
        assemblyAddress=_assemblyAddress;
    }
    struct macRawMaterial {
        uint256 macRawMaterialID;
        string macRawMaterialOrigin;
        uint256 macRawMaterialQuality;
        uint256 macRawMaterialQuantity;
        
    }
    struct macProduction {
        uint256 macMachineNumber;
        uint256 macQualityOfProduct;
        uint256 macQuantityOfProduct;
    }
    struct macShipment {
        uint256 macLocationIdOnRack;
        string macLocationName;
    }
    struct logDepartment{
        uint256 logLocationIdOnRack;
        string logLocationName;
    }
    struct Asset {
        string name;
        string description;
        // possible statuses 00,10,20,21,22,30,11
        uint256 status;   
        uint256 ProductID;
        address customerAddress;
        // to be set while order placement , to be set 10 
        uint256 productionQualityLowerLimit;
        uint256 rawMaterialQualityLowerLimit;

        logDepartment logDepartmentVariable;
        macShipment macShipmentVariable;
        macProduction macProductionVariable;
        macRawMaterial macRawMaterialVariable;
        
    }
    mapping(uint256=>Asset) assetStore;
    mapping(uint256=>address) public assetIdToOwner;
    // not effective as the whole array isnt returned 
    //mapping(uint256 => uint256[]) public departmentToAssetId;
    uint256 public last=0;
    // keeps in account the ownershipCount of department
    mapping(uint256 => uint256) public ownershipCount;
    // asset id to status
    mapping(uint256 => uint256) public assetIdToStatus;
    function placeOrder(string _name , string _desc, uint256 _productionQualityLowerLimit, uint256 _rawMaterialQualityLowerLimit){
            Asset memory _asset=Asset({
                name:_name,
                description:_desc,
                status:20,
                ProductID:last,
                customerAddress:msg.sender,
                productionQualityLowerLimit:_productionQualityLowerLimit,
                rawMaterialQualityLowerLimit:_rawMaterialQualityLowerLimit,
                logDepartmentVariable:logDepartment(0,"null"),
                macShipmentVariable:macShipment(0,"null"),
                macProductionVariable:macProduction(0,0,0),
                macRawMaterialVariable:macRawMaterial(0,"null",0,0)
                // macRawMaterialID:0,
                // macRawMaterialOrigin:"null",
                // macRawMaterialQuantity:0,
                // macRawMaterialQuality:0
                //macMachineNumber:0
                //macQualityOfProduct:0,
                //macQuantityOfProduct:0,
                //macLocationIdOnRack:0
                //macLocationName:"null",
                //logLocationIdOnRack:0
                //logLocationName:"null"
                });
        //assetStore[last].logDepartmentVariable=logDepartment();
        assetStore[last]=_asset;
        assetIdToStatus[last]=20;
        ownershipCount[20]++;
        // assembly guy takes order , transferrs order to machinning guy
        assetIdToOwner[last]=machiningAddress;
        
        //departmentToAssetId[20].push(last);
        last++;

    }
    function addDetailRawMaterialStakeHolder(uint256 _id,uint256 _rawMaterialId,uint256 rawMaterialQuality,uint256 rawMaterialQuantity,string origin) onlyMachiningAddress{
        // check ownership and status.
        require(assetStore[_id].rawMaterialQualityLowerLimit<=rawMaterialQuality);
        require(assetStore[_id].status==20);
        require(assetIdToOwner[_id]==machiningAddress);
        // write data
        assetStore[_id].macRawMaterialVariable.macRawMaterialOrigin=origin;
        assetStore[_id].macRawMaterialVariable.macRawMaterialQuality=rawMaterialQuality;
        assetStore[_id].macRawMaterialVariable.macRawMaterialQuantity=rawMaterialQuantity;
        assetStore[_id].macRawMaterialVariable.macRawMaterialID=_rawMaterialId;
        // change status to next stakeholder
        changeStatus(_id,21);
        assetIdToStatus[_id]=21;
        ownershipCount[20]--;
        ownershipCount[21]++;

    }
    function addDetailProductionStakeHolder(uint256 _id,uint256 _machineNumber,uint256 _macQualityOfProduct,uint256 _macQuantityOfProduct) onlyMachiningAddress{
        
        require(assetStore[_id].productionQualityLowerLimit<=_macQualityOfProduct);
        require(assetStore[_id].status==21);
        require(assetIdToOwner[_id]==machiningAddress);
        assetStore[_id].macProductionVariable.macMachineNumber=_machineNumber;
        assetStore[_id].macProductionVariable.macQuantityOfProduct=_macQuantityOfProduct;
        assetStore[_id].macProductionVariable.macQualityOfProduct=_macQualityOfProduct;
        changeStatus(_id,22);
        assetIdToStatus[_id]=22;
        ownershipCount[21]--;
        ownershipCount[22]++;
    }
    
    function addDetailShipmentStakeHolder(uint256 _id,uint256 _macLocationIdOnRack,string _macLocationName) onlyMachiningAddress{
        require(assetStore[_id].status==22);
        require(assetIdToOwner[_id]==machiningAddress);
        assetStore[_id].macShipmentVariable.macLocationIdOnRack=_macLocationIdOnRack;
        assetStore[_id].macShipmentVariable.macLocationName=_macLocationName;
        changeStatus(_id,30);
        assetIdToStatus[_id]=30;
        ownershipCount[22]--;
        ownershipCount[30]++;
        assetIdToOwner[_id]=logisticAddress;

        
    }
    function addDetailLogistic (uint256 _id,uint256 _logLocationIdOnRack,string _logLocationName) onlyLogisticAddress {
        require(assetStore[_id].status==30);
        require(assetIdToOwner[_id]==logisticAddress);
        assetStore[_id].logDepartmentVariable.logLocationIdOnRack=_logLocationIdOnRack;
        assetStore[_id].logDepartmentVariable.logLocationName=_logLocationName;
        // order ready to be delivered 
        changeStatus(_id,11);
        assetIdToStatus[_id]=11;
        ownershipCount[30]--;
        ownershipCount[11]++;
        assetIdToOwner[_id]=assetStore[_id].customerAddress;
    }
    
    /** getters **/
    function getAssetOverview(uint256 _id)constant returns(string,
                                                    string,
                                                    uint256,
                                                    uint256,
                                                    address,
                                                    uint256,
                                                    uint256
                                                    )
    {
        return (assetStore[_id].name,
                assetStore[_id].description,
                assetStore[_id].status,
                assetStore[_id].ProductID,
                assetStore[_id].customerAddress,
                assetStore[_id].productionQualityLowerLimit,
                assetStore[_id].rawMaterialQualityLowerLimit
                );
    }
    function getAssetRawMaterialInformation(uint256 _id) constant returns(string,uint256,uint256,uint256){
        return (assetStore[_id].macRawMaterialVariable.macRawMaterialOrigin,
                assetStore[_id].macRawMaterialVariable.macRawMaterialQuantity,
                assetStore[_id].macRawMaterialVariable.macRawMaterialQuality,
                assetStore[_id].macRawMaterialVariable.macRawMaterialID
                );
    }
    function getAssetProductionInformation(uint256 _id) constant returns(uint256,uint256,uint256){
        return (
            assetStore[_id].macProductionVariable.macMachineNumber,
            assetStore[_id].macProductionVariable.macQualityOfProduct,
            assetStore[_id].macProductionVariable.macQuantityOfProduct
            );
    }
    function getAssetShipmentInformation(uint256 _id) constant returns(uint256,string){
        
        return(
            assetStore[_id].macShipmentVariable.macLocationIdOnRack,
            assetStore[_id].macShipmentVariable.macLocationName
            );
    }
    function getLogisticInformation(uint256 _id) constant returns(uint256,string){
        
        return(
            assetStore[_id].logDepartmentVariable.logLocationIdOnRack,
            assetStore[_id].logDepartmentVariable.logLocationName
            );
    }
    
    function tokensOfStakeholder(uint256 stakeHolder) constant returns (uint256[]){
        uint256 assetCount = ownershipCount[stakeHolder];

        if (assetCount == 0) {
            // Return an empty array
            return new uint256[](0);
        } else {
            uint256[] memory result = new uint256[](assetCount);
            uint256 totalLocks = last-1;
            uint256 resultIndex = 0;

            // We count on the fact that all cats have IDs starting at 1 and increasing
            // sequentially up to the totalCat count.
            uint256 lockId;

            for (lockId = 1; lockId <= totalLocks; lockId++) {
                if (assetIdToStatus[lockId] == stakeHolder) {
                    result[resultIndex] = lockId;
                    resultIndex++;
                }
            }

            return result;
        }
    }
    
}