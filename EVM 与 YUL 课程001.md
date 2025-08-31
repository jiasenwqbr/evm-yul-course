# EVM 与 YUL 课程

## EVM设计

视频 AI 总结： 该视频是关于以太坊虚拟机（EVM）的迷你系列的第一集，旨在帮助开发者、安全研究员和 DevOps 工程师理解 EVM 的底层原理。视频从高层次概括了 EVM 的概念，将其描述为一个分布式状态机，通过交易改变世界状态。视频还介绍了 EVM 的关键组件，包括账户、交易、区块、内存、堆栈和存储，以及 gas 的作用和 EVM 的执行模型。

关键信息：

- EVM 是一个分布式状态机，通过交易改变世界状态。
- 世界状态是地址到账户状态的映射。
- 账户分为外部拥有账户（EOA）和合约账户。
- 交易由 EOA 发起，可以是合约创建或消息调用。
- 区块包含多个交易，由验证者决定交易顺序。
- EVM 有只读内存、持久化存储和易失性状态。
- Gas 用于衡量计算复杂度，防止拒绝服务攻击。
- EVM 代码由字节码组成，通过操作码执行。
- 事件（logs）用于链下监听状态变化，无法在合约内读取。

​      Hello there and welcome to my channel. I'm Delirious, I'm independent security researcher performing solo audits, team audits and bug hunting. Today I present to you mini-series on EVM, which is foundational topic for any web-free tech guy, be it smart contracts developer,security researcher or DevOps engineer. I share with you everything you need to know to read, review and write EVM native code. However, I won't spend much time describing topics like peer-to-peer consensus nodes and other topics not directly related to virtual machine executing the code. Additionally, there's a prerequisite, it is not an introductory course. I assume that you can write code in Solidity and have general knowledge on how blockchain works. If you don't, please check out Patrick Conley's full course on Solidity and read foundational topics description from official Ethereum docs. All additional materials are put down in the video description. Okay, it's time to dive in. 

​     大家好，欢迎来到我的频道。我是Delirious，我是一名独立的安全研究员，进行单独审计、团队审计和漏洞挖掘。今天我向大家介绍关于EVM的迷你系列，EVM是任何Web3技术人员的基础主题，无论是智能合约开发者，安全研究员还是DevOps工程师。我将与你分享阅读、审查和编写EVM原生代码所需的一切知识。但是，我不会花太多时间描述像点对点共识节点以及其他与执行代码的虚拟机没有直接关系的主题。此外，还有一个前提条件，这不是一个入门课程。我假设你可以用Solidity编写代码，并且对区块链的工作原理有一般的了解。如果你不了解，请查看Patrick Conley关于Solidity的完整课程并阅读以太坊官方文档中关于基础主题的描述。所有其他材料都放在视频描述中。好了，是时候深入了解了。

In this module, I described EVM from the high level. This will make going through the specifics easier to understand.In this episode, I'll use Ethereum EVM illustrated by Pakenobu which gives valuable insights into EVM. But first of all, let's talk about what Ethereum virtual machine is. Generally, it can be thought of as a distributed state machine, defining a state transition function. As you can see in this slide, we have some initial world state and we define state transition function, which in case of EVM is transaction. And after applying that, we are ending up with a new word state.Well, actually, transactions are not executed as a single entity, but are packed into blocks and then executed as a whole block.Selecting transactions that go into block are not restricted by EVM, and the validator preparing the blocks have full discretion over what goes inside of it. This allows them to extract additional value by putting the transactions in specific order or picking the most profitable ones or even creating and placing their own transactions in the middle to manipulate the outcome of the transactions. You should always keep that in mind and make sure that the contracts that you work on have proper protection against that. 

在本模块中，我从高层次描述EVM。这将使理解具体细节更容易。在本集中，我将使用Pakenobu绘制的以太坊EVM图示，它提供了对EVM的宝贵见解。但首先，让我们谈谈以太坊虚拟机是什么。一般来说，它可以被认为是一个分布式状态机，定义了一个状态转换函数。正如你在这张幻灯片中看到的，我们有一些初始的world状态，我们定义了状态转换函数，在EVM的情况下，就是交易。应用之后，我们最终得到一个新的word状态。实际上，交易不是作为单个实体执行的，而是打包成区块，然后作为一个整体区块执行。选择进入区块的交易不受EVM的限制，并且准备区块的验证者对区块内的内容有完全的决定权。这允许他们通过将交易放入特定顺序或选择最有利可图的交易，甚至创建并将他们自己的交易放在中间来操纵交易的结果，从而提取额外的价值。你应该始终牢记这一点，并确保你所使用的合约有适当的保护措施来防止这种情况。

![image-20250829155945542](images/image-20250829155945542.png)

![image-20250829160117218](images/image-20250829160117218.png)

Next, let's discuss how blocks are modifying the word state.  As you can see in this slide, each block provides update to the word state and each new block builds upon previous word state. From the point of view of implementation, you can think about EVM  as a chain of blocks. That's why the name blockchain. 
接下来，让我们讨论区块是如何修改word状态的。正如你在这张幻灯片中看到的，每个区块都提供了对world状态的更新，并且每个新区块都建立在之前的word状态之上。从实现的角度来看，你可以把EVM看作是一个区块的链条。这就是为什么叫区块链。

![image-20250829160402082](images/image-20250829160402082.png)

So what exactly is world state? In simplest words, the world state is a mapping between address and account state. An account is a key object in the world state. It uniformly identifies single entity living within the virtual machine.Its identifier is an account address. 

![image-20250829164559832](images/image-20250829164559832.png)

![image-20250829164721045](images/image-20250829164721045.png)

In EVM, it's a 20 bytes long stream of bytes.Each account also consists of an account state.Account state consists of its address, which is its key, and its state. The state of each address consists of nonce, which is number only used once.In this case, it's current number of transactions that is being executed.

![image-20250829164955845](images/image-20250829164955845.png)

![image-20250831204126872](images/image-20250831204126872.png)

This is to prevent signature replay attacks because it makes sure that each single transaction has a unique identifier, which is used once and then increased. Apart from that, address also has its balance. In case of Ethereum, it's Ether. In case of other EVM implementations, it may differ.Apart from that, each account has storage hash, which is just an index to account storage, and its code hash, which also is an index, but to EVM code. And there are two types of accounts in EVM.One is externally owned account, which is owned by external actor.That means any user of the blockchain can be me, you, whoever. And the most important part here is that it has private key from which public key is being deduced and from the hash of public key, an address is created. So externally owned account is just an entity that has private key and signs transaction with this private key. The second type of account is smart contract account, which contains code and storage. It by itself cannot initiate transactions. However, it can receive transactions and call other addresses. So in case of externally owned account, storage hash is hash of zero and code hash is also code hash of zero because externally owned accounts do not possess any storage nor the EVM code.In case of contracts account, storage hash is a pointer to the hash storage of smart contract and code hash is a hash of the bytecode that the smart contract consists of. 

那么，worldstate到底是什么？最简单的说，worldstate是地址和账户状态之间的映射。账户是worldstate中的一个关键对象。它统一地标识了存在于虚拟机中的单个实体。它的标识符是一个账户地址。在EVM中，它是一个20字节长的字节流。每个账户也由一个账户状态组成。账户状态由其地址（即其密钥）及其状态组成。每个地址的状态由nonce组成，nonce是一个只使用一次的数字。在这种情况下，它是当前正在执行的交易的数量。这是为了防止签名重放攻击，因为它确保每个单独的交易都有一个唯一的标识符，该标识符只使用一次，然后递增。除此之外，地址也有它的余额。在以太坊的情况下，它是以太币。在其他EVM实现中，它可能会有所不同。除此之外，每个账户都有storagehash，它只是一个指向账户存储的索引，以及它的codehash，它也是一个索引，但指向EVM代码。EVM中有两种类型的账户。一种是外部拥有账户（ExternallyOwnedAccount,EOA），它由外部参与者拥有。这意味着区块链的任何用户都可以是我、你、任何人。这里最重要的是它有私钥从中推导出公钥，并从公钥的哈希值中创建一个地址。所以外部拥有账户只是一个拥有私钥的实体并使用此私钥签署交易。第二种类型的账户是智能合约账户，它包含代码和存储。它本身不能发起交易。但是，它可以接收交易并调用其他地址。因此，在外部拥有账户的情况下，storagehash是零的哈希值，codehash也是零的codehash，因为外部拥有账户不拥有任何存储或EVM代码。在合约账户的情况下，storagehash是指向智能合约的哈希存储的指针，codehash是智能合约组成的字节码的哈希值。

So how do we determine which address an account have? In case of externally owned accounts, everything starts with private key. So the user generates private key for them and from this private key, the public key is being deduced. Next, the public key is being hashed and the rightmost 160 bits are taken. Those are then treated as an address account. In case of contract accounts, we have two ways of creating an address. If a smart contract is created by create opcode, its address is taken from hash of sender address and the sender nonce and actually the rightmost 20 bytes from this hash are taken. 

那么，我们如何确定一个账户拥有哪个地址呢？在外部拥有账户的情况下，一切都从私钥开始。因此，用户为他们生成私钥，并从这个私钥中推导出公钥。接下来，公钥被哈希，并取最右边的160位。然后将这些位视为地址账户。在合约账户的情况下，我们有两种创建地址的方法。如果智能合约是通过create操作码创建的，那么它的地址是从发送者地址和发送者nonce的哈希值中获取的，实际上从这个哈希值中获取最右边的20个字节。

In case of create2, the address is taken from the constant ff added with sender address, the sender provided salt and ketchup of initialization code and similarly to create, it is hashed and rightmost 20 bytes are taken as an address of the contract. And now that we know a bit about accounts, let's move to the transaction. So transaction is a single cryptographically signed instruction.And as you saw here, like only the externally owned account has private key to sign anything, that means that the transaction can be only created by externally owned account. 

在create2的情况下，地址是从常量ff中获取的加上发送者地址、发送者提供的salt和初始化代码的keccak哈希值，与create类似，它被哈希，最右边的20个字节被作为合约的地址。现在我们对账户有了一些了解，让我们转向交易。因此，交易是一个单独的密码学签名的指令。正如你在这里看到的，只有外部拥有账户拥有私钥来签署任何东西，这意味着交易只能由外部拥有账户创建。



















































