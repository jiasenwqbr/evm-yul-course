// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Proxy} from "../src/proxy/Proxy.sol";
import {LogicV1} from "../src/proxy/LogicV1.sol";
// import {LogicV2} from "../src/proxy/LogicV2.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        
        vm.startBroadcast(deployerPrivateKey);

        console.log("Deployer:", deployer);
        
        // 部署 V1 逻辑合约
        LogicV1 logicV1 = new LogicV1();
        console.log("LogicV1 deployed at:", address(logicV1));
        
        // 准备初始化数据
        bytes memory initData = abi.encodeWithSelector(
            LogicV1.initialize.selector,
            deployer,
            "MyUpgradeableContract"
        );
        
        // 部署代理合约
        Proxy proxy = new Proxy(
            address(logicV1),
            deployer,
            initData
        );
        console.log("Proxy deployed at:", address(proxy));
        
        vm.stopBroadcast();
    }
}

/**
  Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
  LogicV1 deployed at: 0x5FbDB2315678afecb367f032d93F642f64180aa3
  Proxy deployed at: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
 */