## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```



## 测试命令

### 1.运行所有测试
```bash
# 运行所有测试
forge test

# 使用更详细输出
forge test -v
```

### 2.不同详细级别
```bash
# 级别 0: 默认输出（只显示结果）
forge test

# 级别 1: 显示测试名称和结果
forge test -v

# 级别 2: 显示日志输出
forge test -vv

# 级别 3: 显示跟踪信息
forge test -vvv

# 级别 4: 显示详细跟踪信息
forge test -vvvv

# 级别 5: 显示所有可能的信息
forge test -vvvvv
```

## 选择性测试
### 1. 按测试名称过滤
```bash
# 运行包含 "testTransfer" 的测试
forge test --match-test "testTransfer"

# 运行以 "test" 开头的测试
forge test --match-test "test.*"

# 使用正则表达式
forge test --match-test "test.*ERC20"

```

### 2. 按合约名称过滤
```bash
# 运行特定合约的测试
forge test --match-contract "ERC20Test"

# 运行多个合约的测试
forge test --match-contract "ERC20Test|ERC721Test"
```

### 3. 排除测试
```bash
# 排除特定测试
forge test --no-match-test "testFail"

# 排除特定合约
forge test --no-match-contract "OldTest"
```
## 🔧 测试配置选项

### 1. Gas 报告
```bash
# 显示 gas 报告
forge test --gas-report

# 为特定合约显示 gas 报告
forge test --gas-report --match-contract "MyContractTest"
```
### 2. 并行测试
```bash
# 并行运行测试（默认）
forge test

# 串行运行测试
forge test --serial
```

### 3. 测试超时设置
```bash
# 设置测试超时时间（毫秒）
forge test --timeout 30000

# 禁用超时
forge test --timeout 0

```

## Fuzz 测试配置
### 1. Fuzz 测试运行次数
```bash
# 设置 fuzz 测试运行次数（默认 256）
forge test --fuzz-runs 1000

# 减少 fuzz 测试运行次数以提高速度
forge test --fuzz-runs 50
```
### 2. Fuzz 测试种子
```bash
# 使用特定种子重现 fuzz 测试失败
forge test --fuzz-seed 123456789

```
## 测试输出和报告

### 1. JSON 格式输出
```bash
# 以 JSON 格式输出测试结果
forge test --json

# JSON 输出到文件
forge test --json > test-results.json
```
### 2. 测试覆盖率
```bash
# 生成测试覆盖率报告
forge coverage

# 生成详细覆盖率报告
forge coverage --report lcov

# 生成 HTML 覆盖率报告
forge coverage --report html

# 在浏览器中查看覆盖率
forge coverage --report html && open coverage/index.html
```
### 3. 测试事件日志
```bash
# 显示所有事件日志
forge test --logs

# 显示特定级别日志
forge test --verbosity 3

```
## 网络相关测试

### 1. 使用特定网络
```bash
# 使用主网分叉进行测试
forge test --fork-url $MAINNET_RPC_URL

# 使用特定区块号的分叉
forge test --fork-url $MAINNET_RPC_URL --fork-block-number 16500000

# 使用本地节点
forge test --fork-url http://localhost:8545

```

### 2. 链配置
```bash
# 设置链 ID
forge test --chain-id 1

# 设置 gas 价格
forge test --gas-price 1000000000

# 设置区块号
forge test --block-number 12345678
```
##  调试和故障排除
### 1. 调试失败测试
```bash
# 只运行失败测试
forge test --match-test "testFail"

# 显示失败测试的跟踪
forge test --match-test "testFail" -vvv

# 调试特定测试
forge test --debug "testSpecificFunction"
```
### 2. 堆栈跟踪
```bash
# 显示完整堆栈跟踪
forge test --via-ir

# 禁用优化器以获得更好堆栈跟踪
forge test --no-optimize

```
### 3. 内存和存储转储
```bash
# 显示测试期间的状态变化
forge test -vvv

# 查看详细的存储布局
forge test --storage-layout
```
## ⚡ 性能优化
### 1. 测试优化
```bash
# 使用更快编译（开发模式）
forge test --optimize --optimizer-runs 200

# 使用更多优化运行次数（生产模式）
forge test --optimize --optimizer-runs 10000

```
### 2. 缓存管理
```bash
# 清除缓存并重新测试
forge test --force

# 忽略缓存
forge test --no-cache
```
## 🧪 高级测试场景
### 1. 带参数的测试
```bash
 # 测试特定函数带参数
forge test --match-test "testDeposit" --gas-limit 3000000

# 设置初始余额
forge test --value 1ether
```

### 2. 多合约测试
```bash
# 测试多个特定合约
forge test --match-contract "TestContract1" --match-contract "TestContract2"

# 使用配置文件中的测试设置
forge test --config-path ./config.toml
```

### 3. 自定义测试目录
```bash 
# 使用自定义测试目录
forge test --test-path ./custom-tests

# 使用多个测试目录
forge test --test-path ./tests --test-path ./integration-tests
```

## 📝 实用命令组合
### 1. 常用开发工作流
```bash 
# 快速测试并显示 gas 报告
forge test -v --gas-report --match-test "test.*"

# 调试特定失败测试
forge test --match-test "testTransfer" -vvv --gas-price 1000000000

# 生成覆盖率报告并打开
forge coverage --report html && open coverage/index.html
```

### 2. CI/CD 集成命令
```bash
# CI 环境测试（JSON 输出，无颜色）
forge test --json --no-color

# 带 gas 报告的 CI 测试
forge test --gas-report --json > test-results.json

# 检查测试是否全部通过
forge test --silent || exit 1

```
### 3. 性能测试
```bash

# 基准测试
forge test --gas-report --fuzz-runs 1000

# 压力测试
forge test --fuzz-runs 10000 --timeout 60000
```
forge test --gas-report --match-contract "AssemblyStep0" -vvvvv

forge test --gas-report --match-contract "TLoadExample" -vvvvv