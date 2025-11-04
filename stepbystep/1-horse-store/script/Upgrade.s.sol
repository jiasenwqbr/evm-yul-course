// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Proxy} from "../src/proxy/Proxy.sol";
import {LogicV2} from "../src/proxy/LogicV2.sol";

contract UpgradeScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.addr(deployerPrivateKey);
        
        // 从文件读取代理地址
        // string memory json = vm.readFile("./deployment.json");
        address payable proxyAddress = payable(0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512);
        
        vm.startBroadcast(deployerPrivateKey);
        
        console.log("Upgrading proxy at:", proxyAddress);
        
        // 部署 V2 逻辑合约
        LogicV2 logicV2 = new LogicV2();
        console.log("LogicV2 deployed at:", address(logicV2));
        
        // 执行升级
        Proxy proxy = Proxy(proxyAddress);
        console.log("Current implementation:", proxy.getImplementation());
        
        proxy.upgradeTo(address(logicV2));
        
        console.log("Upgrade completed!");
        console.log("New implementation:", proxy.getImplementation());
        
        vm.stopBroadcast();
        
        // 保存新逻辑合约地址
        // vm.writeJson(
        //     vm.serializeAddress("deployment", "LOGICV2_ADDRESS", address(logicV2)),
        //     "./deployment.json"
        // );
    }
}