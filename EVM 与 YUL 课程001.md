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

![image-20250901105301055](images/image-20250901105301055.png)

So how do we determine which address an account have? In case of externally owned accounts, everything starts with private key. So the user generates private key for them and from this private key, the public key is being deduced. Next, the public key is being hashed and the rightmost 160 bits are taken. Those are then treated as an address account. In case of contract accounts, we have two ways of creating an address. If a smart contract is created by create opcode, its address is taken from hash of sender address and the sender nonce and actually the rightmost 20 bytes from this hash are taken. 

那么，我们如何确定一个账户拥有哪个地址呢？在外部拥有账户的情况下，一切都从私钥开始。因此，用户为他们生成私钥，并从这个私钥中推导出公钥。接下来，公钥被哈希，并取最右边的160位。然后将这些位视为地址账户。在合约账户的情况下，我们有两种创建地址的方法。如果智能合约是通过create操作码创建的，那么它的地址是从发送者地址和发送者nonce的哈希值中获取的，实际上从这个哈希值中获取最右边的20个字节。

```solidity
initialisation_code = memory[offset:offset+size]
address = keccak256(0xff + sender_address + salt + keccak256(initialisation_code))[12:]
```



In case of create2, the address is taken from the constant ff added with sender address, the sender provided salt and ketchup of initialization code and similarly to create, it is hashed and rightmost 20 bytes are taken as an address of the contract. And now that we know a bit about accounts, let's move to the transaction. 

![image-20250901113440995](images/image-20250901113440995.png)

So transaction is a single cryptographically signed instruction.And as you saw here, like only the externally owned account has private key to sign anything, that means that the transaction can be only created by externally owned account. 

在create2的情况下，地址是从常量ff中获取的加上发送者地址、发送者提供的salt和初始化代码的keccak哈希值，与create类似，它被哈希，最右边的20个字节被作为合约的地址。现在我们对账户有了一些了解，让我们转向交易。因此，交易是一个单独的密码学签名的指令。正如你在这里看到的，只有外部拥有账户拥有私钥来签署任何东西，这意味着交易只能由外部拥有账户创建。

![image-20250901115429463](images/image-20250901115429463.png)

![image-20250901115808907](images/image-20250901115808907.png)

In EVM, there are two kinds of transaction. One is contract creation. A second is a message call.The difference between them technically is in order to create a smart contract, you have to send transaction to the zero address and have  nonzero length data array. Otherwise, the transaction is treated as a message call. And in a message call, you can either call other externally owned account or contract account. Actually, on the broader level, EVM doesn't really care what you are calling. You can also call account that doesn't exist and it will be okay. Now let's look how contract creation looks more in detail. We have work state before contract creation that we have some specific addresses and their state. And then we are sending transaction again to address zero and nonzero data array, which signifies that this is the init code of the smart contract that you will use. And then EVM executes this init code and puts whatever it returns on the blockchain. And this is stored inside code. Additionally, if anything is set in storage, it is also added here. New address is being created and now you have new smart contract. In case of message call, let's say that you are sending transaction to the address N and it has its account state with input data. This can be either externally owned account or contract account. And after this transaction, its state is being updated. As you can see here, code is not changing here, only storage. That's because EVM doesn't allow you to change the code under specific address. Of course, there are ways to work around that, but we will not talk about it here. If you are interested, you can check out how smart contract proxies work. But what the transaction really consists of? We already spoke about it having a transaction recipient, optional data, but what else is there? So each transaction has nonce, as I described before, to prevent transaction replay attacks. It also has two very important parts, which are gas price and gas limit. 

![image-20250901115934934](images/image-20250901115934934.png)

![image-20250901160006761](images/image-20250901160006761.png)

在EVM中，有两种类型的交易。一种是合约创建。 第二种是消息调用。它们之间的区别在于，从技术上讲，为了创建一个智能合约，你必须将交易发送到零地址，并且拥有非零长度的数据数组。否则，该交易将被视为消息调用。在消息调用中，你可以调用其他外部拥有账户或合约账户。实际上，在更广泛的层面上，EVM并不真正关心你调用的是什么。你也可以调用不存在的账户，这也没关系。现在让我们更详细地看看合约创建是如何进行的。在合约创建之前，我们有一些特定的word状态地址和它们的状态。然后我们再次将交易发送到地址零和非零你将使用的智能合约的初始化代码。数据数组，这表明这是然后EVM执行这个初始化代码，并将它返回的任何内容放在区块链上。这被存储在代码中。此外，如果在存储中设置了任何内容，它也会被添加到这里。正在创建一个新地址，现在你有了新的智能合约。在消息调用的情况下，假设你正在发送交易到地址N，它有它的账户状态和输入数据。这可以是外部拥有账户或合约账户。在这个交易之后，它的状态将被更新。正如你在这里看到的，代码没有改变，只有存储改变了。这是因为EVM不允许你更改特定地址下的代码。 当然，有一些方法可以解决这个问题，但是我们不会在这里讨论它。如果你有兴趣，你可以了解一下智能合约代理是如何工作的。但是交易真正包含什么呢？我们已经说过它有一个交易接收者，可选数据，但是还有什么呢？因此，每个交易都有nonce，正如我之前描述的，以防止交易重放攻击。它还有两个非常重要的部分，即gas price和gas limit。

We will talk about gas a bit later, but in a nutshell, you are saying how much calculation expressed in gas you are willing to do and how much you are willing to pay for it. Next one, we have recipient, which is either address or zero.If this is contract creation, we have value, which is the native coin value. In case of Ethereum, for example, it's Ether. So if this was Ethereum, then the value would mean how much Ether you want to send with your transaction. Next, we have VRNS, which are transaction signature. This actually allows to prove that you are the person that wants to execute this transaction, because you are the only one that has private key. And if you are signing something, that means that you want to perform such action. And finally, we have data. In this slide, it shows us init or data, but actually this is just one field, data. But in case of contract creation, this field serves as a smart contract init code. And now on to the messages. Message is passed between two accounts, and it consists of data, which is just a set of bytes and value. And messages can be either triggered by transaction, which is what we spoke about before, or it can be triggered by EVM code. So smart contract accounts can also call other smart contracts or externally owned accounts. And this is all fine, but how do transactions land in this globally shared database?

![image-20250901160259485](images/image-20250901160259485.png)

![image-20250901160416734](images/image-20250901160416734.png) 

![image-20250901161833472](images/image-20250901161833472.png)

![image-20250901162006261](images/image-20250901162006261.png)

It is a bit tricky, because at first it can be a bit unintuitive, because there is no single party that runs Ethereum virtual machine. Actually, you have multiple parties running the EVM, and they all reach the consensus of what the world state is. That means that you can think about blockchain as a globally shared decentralized transactional database. So as you can see in this slide, when external actor is sending some transaction, they are using the interface to call the machine that is running the Ethereum node, which has current world state. And then each of the nodes communicates with one another to propagate the current state. Having shared state between nodes is great, but it poses some issues. And the biggest one of them is how do you guarantee atomicity and order? And EVM solves that by having atomic operations. That means that the transaction either fully executes and everything is committed, or there is some error during the transaction execution, and it's reverted to the previous state. EVM solves problem of ordering of transactions simplest way possible, and that is that every transaction has to be executed sequentially. There is no possibility of executing two transactions at the same time. But what about the order of transactions? If we have, for example, two external actors, and actor B first submits two transactions, and then actor A submits three transactions, how do we guarantee that the order of the transaction will be preserved? 

我们稍后会讨论gas，但简而言之，你是在说你愿意进行多少以gas表示的计算以及你愿意为此支付多少费用。 接下来是 recipient（接收者），它可以是一个地址或者零地址。如果是合约创建，我们有 value（值），它是原生代币的价值。例如，在以太坊的例子中，它是 Ether。所以如果这是以太坊，那么 value 就意味着有多少Ether 你想随你的交易一起发送。接下来，我们有 VRNS，也就是交易签名。这实际上可以证明你是想要执行此交易的人，因为只有你拥有私钥。如果你签名了某些东西，那就意味着你想要执行这样的操作。最后，我们有 data（数据）。在这个幻灯片中，它向我们展示了 init 或 data，但实际上这只是一个字段，data。但在合约创建的情况下，这个字段用作智能合约的初始化代码。现在我们来看消息。消息在两个账户之间传递，它由 data 组成，它只是一组字节和 value。消息可以由交易触发，也就是我们之前所说的，或者它可以由 EVM 代码触发。因此，智能合约账户也可以调用其他智能合约或外部拥有的账户。这一切都很好，但是交易如何进入这个全局共享的数据库？这有点棘手，因为起初它可能有点不直观，因为没有单一的一方运行以太坊虚拟机。实际上，你有多个方在运行 EVM，他们都达成关于世界状态是什么的共识。这意味着你可以把区块链看作是一个全球共享的去中心化的交易数据库。所以正如你在这个幻灯片中看到的，当外部参与者发送一些交易时，他们正在使用接口来调用机器该机器正在运行以太坊节点，该节点具有当前的世界状态。然后每个节点彼此通信以传播当前状态。在节点之间共享状态很好，但它带来了一些问题。其中最大的问题是如何保证原子性和顺序？EVM 通过具有原子操作来解决这个问题。这意味着交易要么完全执行并且一切都提交，或者在交易执行期间出现一些错误，并且它恢复到之前的状态。EVM 以最简单的方式解决了交易排序的问题，那就是每个交易都必须按顺序执行。不可能同时执行两个交易。但是交易的顺序呢？例如，如果我们有两个外部参与者，参与者 B 首先 提交两个交易，然后参与者 A 提交三个交易，我们如何保证交易的顺序会被保留？

actually, we cannot. What EVM does, it keeps the transaction pool, which it calls mempool, and all the transactions that are submitted to the Ethereum node first are going into mempool, and then miner, or in case of current EVM state, the validator determines the order of the transactions. Usually, miners are incentivized by high fees. That means that if you are willing to pay more for executing your transaction, then you will be more likely to have your transaction included first. Now let's go a bit more into details around EVM architecture. Ethereum virtual machine has few main components. One of them is virtual read-only memory, where the EVM code is loaded. We have account storage, which is persisted, and we have the volatile state that is there only for the time of executing the transaction. And it consists of program counter, which is the number of current instructions executed. We have gas available, which just means how much more computation we are willing to pay for.We have stacks, where all the intermediate operation results are stored, and we have volatile memory. So going through a simple example, let's say that we have an externally owned account that submits a transaction to swap some token A or token B. So at first, when the transaction is being executed, the call starts in the smart contract, EVM loads the smart contract code, program counter is set to zero, gas available to the gas limit, and then the bytecode is being executed.And during execution, it puts intermediate values to stack and memory. It also uses account storage to read persisted state, and the transaction goes on. If there is some state needs to be updated, for example, user balances, it is being stored in the account storage, and then transaction ends. The EVM code is not required anymore, and all this machine state is being removed, and what's left is the persisted world state. EVM has multiple places where it stores the data during execution of smart contracts, and one of them is stack. Stack can hold up to 124 elements, each of them is 256 bits, which is 32 bytes, and it is being used for basically every computation that it does. If it adds something, subtracts, divides anything, most of the upcodes are using values stored at stack to perform the calculations. Then we have memory, and next we have memory, and memory is just a volatile array.It differs from the stack in a way that it can hold very long chunks of data. For example, you can put there your whole contract or some long strings or whatever you want, which is not possible in case of stack, and it's volatile, and it means that after the smart contract execution, the memory is erased.And finally, we have storage.This is what is persisted in the EVM world state. Storage consists of key to value mappings, and each key is 256 bits, and each value is as well 256 bits.And also you can see on this slide that there are no registers. 

![image-20250901162506660](images/image-20250901162506660.png)

![image-20250901162740361](images/image-20250901162740361.png)

实际上，我们不能。EVM 所做的是，它保留了交易池，它称之为 mempool，所有提交给以太坊节点的交易首先进入 mempool，然后矿工，或者在当前 EVM 状态下，验证者确定交易的顺序。通常，矿工会受到高费用的激励。这意味着如果你愿意为执行你的交易支付更多费用，那么你更有可能让你的交易首先被包含。现在让我们更详细地了解 EVM 架构。以太坊虚拟机有几个主要组件。其中之一是虚拟只读内存，EVM 代码被加载到这里。我们有 account storage（账户存储），它是持久化的，我们还有易失性的状态，它只在执行交易时存在。它由 program counter（程序计数器）组成，它是当前执行的指令数。我们有 gas available（可用 gas），这仅仅意味着我们还愿意为多少计算 付费。 我们有 stacks（栈），所有中间操作结果都存储在这里，我们有 volatile memory（易失性内存）。所以通过一个简单的例子，假设我们有一个外部拥有的账户提交了一个交易来交换一些代币 A 或代币 B。所以首先，当交易被执行时，调用开始于智能合约中，EVM 加载智能合约代码，program counter设置为零，gas available 设置为 gas limit，然后 bytecode（字节码）被执行。 在执行期间，它将中间值放入 stack 和 memory。它还使用 account storage 来读取持久化的状态，交易继续进行。the 如果有一些状态需要更新，例如，用户余额，它被存储在 account storage 中，然后交易结束。EVM 代码不再需要，所有这些机器状态被移除，剩下的是持久化的世界状态。 EVM 有多个地方在智能合约执行期间存储数据，其中之一是 stack。Stack 最多可以容纳 1024 个元素，每个元素是 256 位，也就是 32 字节，它基本上用于它所做的每一次计算。如果它添加、减去、除以任何东西，大多数操作码都使用存储在 stack 中的值来执行计算。然后我们有 memory，接下来我们有 memory， memory 只是一个易失性数组。它与 stack 的不同之处在于它可以容纳非常长的数据块。例如，你可以把你的整个合约或者一些长的 字符串或任何你想要的东西放在那里，这在stack 中是不可能的，它是易失性的，这意味着在智能合约 执行之后，memory 被擦除。  最后，我们有 storage。这是在 EVM 世界状态中持久化的内容。Storage 由键值映射组成，每个键是 256 位，每个值也是 256 位。而且你也可以在这个幻灯片上看到，没有寄存器。

![image-20250901163053202](images/image-20250901163053202.png)

![image-20250901163315206](images/image-20250901163315206.png)

 Why is that? So basically you have two most common ways of building your state machine.One is register-based machine, and one is stack-based machine. Stack-based is super simple to implement. However, it requires much overhead over registers because you have single stack where you are using all of your data for calculations. However, in case of registers, you have multiple of them, and you can store intermediate values inside each registers and do calculations directly on the registers.However, it comes with the cost of complexity, and you will see that multiple times in case of EVM that the design is to prefer simplicity and security over like complexity and robustness. Going a bit deeper inside stack, you can see it here that this is 1024 elements array, each having 256 bits. And what is important, you have direct access to the topmost 16 elements of the stack, which I guess you fell into this problem stack before and you do not even know why. I will talk about it a bit more in details later. So as I already said, all the operations are performed on stack. All the adds, multiplies, shifts, and everything that you may think. So you can access them with many instructions as push, pop, copy, swap, and others.We will go more into details of that later. Next, we have memory. And this is like a bit unfortunate because in this slide, it is depicted similar to the stack. However, you can think about memory more as a continuous array of data. And as I said, this is linear and can be addressed at byte level. So you can take one single byte from the whole array of memory and override it. There are only four memory-related opcodes. This is mstore, mstore8, which stores a single byte, mload, and mson. And each new memory that you are accessing is initialized to zero. Like basically everything inside of the VM, you do not have null values here. Default value is always zero.That's why you should be very careful when handling zero values.And finally, we have storage, which is key-value store, mapping keys to 256 bytes values. You can access the storage via sstore or sload instructions. And I will add here that this is the most expensive operation that you have. So you should do everything to minimize amount of sstores and sloads. And why is that? We will go more into details about that when we will describe the gas and pricing.Finally, how the EVM code work. I have EVM codes open now to show you how the EVM code can be represented. EVM code is nothing more than set of bytes and each byte EVM value has like specific operation code and each byte word has assigned operation that it does. So it can be shown as a mnemonic here. So for example, you see here this code that we have set of operation. First, we are pushing one byte, which is 42. Remember that zero X means that this is hexadecimal. Then we are pushing zero, storing it into memory. Again, pushing one byte, which is 32. And there is a difference. You can see it here. This is no one X. That means that 32 is in decimal. Then again, we are pushing zero and we are returning. These opcodes are in mnemonic representation. Apart from that, you may have bytecode. So you can see in bytecode the same situation. Number 60, which is push one and then 42, which means that we are putting 42 in hexadecimal to the stack. Then again, 60 and zero that again mean we are pushing one byte in this case, zero. The same thing, just different representation. And when you put it like that, this is how the EVM can understand what is to be executed. And the assembly view is for the reader to better understand what is happening inside of assembly. 



为什么呢？ 所以基本上你有两种最常见的构建状态机的方法。一种是基于寄存器的机器，一种是基于栈的机器。基于栈的机器非常容易实现。然而，它比寄存器需要更多的开销，因为你有一个单一的栈你在那里使用所有的数据进行计算。然而，在寄存器的情况下，你有多个寄存器，你可以将中间值存储在每个寄存器中，并进行计算 直接在寄存器上进行。然而，它带来了复杂性的代价，你将会看到在 EVM 的情况下多次出现，设计是为了优先考虑简单性和安全性，而不是复杂性和健壮性。更深入地了解 stack，你可以在这里看到这是一个 1024 个元素的数组，每个元素有 256 位。重要的是，你可以直接访问最上面的 16 个的元素，我想你以前也遇到过这个问题甚至不知道为什么。我稍后会更详细地讨论它。正如我已经说过的，所有的操作都在 stack 上执行。所有的加法、乘法、移位，以及你可能想到的任何东西。所以你可以使用许多指令来访问它们，例如 push、pop、copy、swap， 等等。 我们稍后会更详细地讨论这些。接下来，我们有 memory。这有点不幸，因为在这个幻灯片中，它被描述得类似于 stack。然而，你可以把 memory 更多地看作是一个连续的数据数组。正如我所说，它是线性的，并且可以在字节级别寻址。所以你可以从整个 memory 数组中取出一个字节并覆盖它。只有四个与 memory 相关的操作码。它们是 mstore、mstore8（存储单个字节）、mload 和 msize。你访问的每个新的 memory 都被初始化为零。就像虚拟机中的所有东西一样，这里没有空值。 默认值始终为零。 这就是为什么你在处理零值时应该非常小心。 256 最后，我们有 storage，它是键值存储，将 256位键映射到 256 位值。你可以通过 sstore 或 sload 指令访问 storage。我将在此补充一点，这是你拥有的最昂贵的操作。所以你应该尽一切努力减少 sstore 和 sload 的数量。这是为什么呢？ 当我们描述 gas 和定价时，我们会更详细地介绍这一点。 最后，EVM 代码是如何工作的。我现在打开了 EVM 代码，向你展示 EVM 代码是如何表示的。代码只不过是一组字节，每个字节值都有特定的操作码，每个字节字都被分配了它执行的操作。所以它可以作为助记符显示在这里。例如，你在这里看到的这段代码，我们有一组操作。首先，我们压入一个字节，也就是 42。请记住，0x 表示这是十六进制。然后我们压入 0，将其存储到内存中。再次压入一个字节，也就是 32。这里有一个区别。你可以在这里看到它。这里没有 x。这意味着 32 是十进制。然后我们再次压入 0，然后返回。这些操作码以助记符表示。除此之外，你可能还有字节码。所以你可以在字节码中看到相同的情况。数字 60，也就是 push1，然后是 42，这意味着我们将十六进制的 42 放入堆栈中。然后再次，60 和 0 再次意味着我们压入一个字节，在本例中是 0。同样的事情，只是不同的表示形式。当你这样放置它时，这就是 EVM可以理解要执行什么。汇编视图是为了让读者更好地理解汇编内部发生了什么。

![image-20250901171637057](images/image-20250901171637057.png)

![image-20250901172520711](images/image-20250901172520711.png)



Okay, and just quickly to the execution model, how EVM works. So first we are loading our EVM code and we are going through them one by one. Each time we are changing process counter, we are decreasing the gas available.Then we are pushing and popping from the stack and having elements on the stack. We can now put the elements into memory or the storage. And let's quickly go through this specific code. Let's try to run it and let's see. So you can see here that we have process counter, which starts at zero. And in our first step, we are pushing 42. If we are going next, our process counter increased by two, because we have two operations. First is push one, this is our first byte. And 42 is our second byte, our second word. So we actually increased the process counter by two. And you can see here in our stack that we pushed the exact number that we wanted. Next one, we are pushing zero. So you can see here that we have all of these values that we already pushed here and we are calling mstore. mstore takes two value.First is where you want to put something. And second of all is the value that you want to put.Okay, when we execute that, in our case, you can see that we put in the memory offset zero, the value of 42. And you can see here that process counter increased by one, because mstore is a single operation. Next again, we are pushing 20. You can see here that we did not use hexadecimal, but normal decimals. But in case of bytecode, this is 20. 20 is like hexadecimal representation of number 32 in decimal. So we again pushed 20 in hexadecimal. Now we are pushing zero and we are calling return. Return takes two values from stack.First it's offset, the memory offset where it has to start and 20 is length in memory of bytes that it has to return.So when we go here, okay, this is the end. So we can see that our return value is 42, because well, we set EVM that it has to return this value. And this is one of the most simple programs that you may have inside of EVM,but it shows you more or less how EVM treats the code. Next up, let's quickly look at message calls. So EVM apart from doing calculations inside of single smart contract, it can send messages to other contracts by call, delegate call, call code or static call instruction. 

好的，快速了解一下执行模型，EVM 是如何工作的。首先，我们加载 EVM 代码，然后逐个执行。 每次我们更改程序计数器时，我们都会减少可用的 gas。然后我们从堆栈中压入和弹出，并在堆栈上放置元素。我们现在可以将元素放入内存或存储中。让我们快速浏览一下这段特定的代码。让我们尝试运行它，看看会发生什么。所以你可以在这里看到我们有一个程序计数器，它从 0 开始。在我们的第一步中，我们压入 42。如果我们下一步，我们的程序计数器会增加 2，因为我们有两个操作。第一个是 push1，这是我们的第一个字节。42 是我们的第二个字节，我们的第二个字。所以我们实际上将程序计数器增加了 2。你可以在我们的堆栈中看到，我们压入了我们想要的准确数字。下一个，我们压入 0。所以你可以在这里看到我们有所有这些值我们已经在这里压入了，我们正在调用 mstore。 mstore 接受两个值。第一个是你想要放置东西的位置。 第二个是你要放置的值。好的，当我们执行它时，在我们的例子中，你可以看到我们将值 42 放入内存偏移量 0 中。你可以在这里看到程序计数器增加了 1，因为mstore 是一个单一操作。接下来，我们再次压入 20。你可以在这里看到我们没有使用十六进制，而是使用了普通的十进制。但在字节码的情况下，这是 20。20 就像十进制数字 32 的十六进制表示。所以我们再次压入十六进制的 20。现在我们压入 0，然后调用 return。 Return 从堆栈中获取两个值。第一个是偏移量，它必须开始的内存偏移量，以及 20 是它必须返回的内存中的字节长度。所以当我们到这里时，好的，这是结尾。所以我们可以看到我们的返回值是 42，因为我们设置 EVM 必须返回这个值。 这是你可能在 EVM 中拥有的最简单的程序之一，但它或多或少地向你展示了 EVM 如何处理代码。接下来，让我们快速看一下消息调用。因此，EVM 除了在单个智能合约中进行计算外，它可以通过 call、delegate call、callcode 向其他合约发送消息或 staticcall 指令。

However, there's a limit to that. You cannot have call stack bigger than 1, 024 levels. That means you cannot call 1, 024 times or more because the execution will just revert. This is kind of protection to not exploit the EVM. However, in real life, this is not very realistic to have such a long call stack. And this is because of the diminishing gas being sent with every call. And we will talk about it a bit later. So how it works. First, we are putting into stack all the elements that are required in the call. You are putting into memory the calldata that you want to pass. And then you are executing the call instruction. And the call creates the new call context for you.  So it creates new stack and new memory and calls new smart contracts. And then you are executing the calling smart contract the same way as you executed the first one.But now you have the new call value, new stack and new memory. And after execution of the called smart contract ends, it returns to the calling contract and it returns by using return instruction and return instruction, as we already saw in the EVM codes playground, takes a parameter of memory offset and memory length to be returned. And finally, we are reaching gas and fees. So EVM uses gas as a measure of computational complexity. And you can imagine gas the similar way how it's treated inside of the car. So your car takes more or less the same amount of gas per mile, but the gas price on the gas station may be different. The same thing is here. Each time you are doing any calculation, you are adding something, putting something to memory, executing different operation, you will use the gas. So when you start transaction, you are setting the gas price that you want to pay and gas limit. And first of all, before executing, EVM checks if you really have the funds required to run this transaction up to the gas limit that you set. And then with every operation, it diminishes the gas that you have available right now until the execution of transaction either ends or reverts because there is no gas left. And EVM also have the concept of gas refund whenever you are removing something from the storage. This is the way how EVM hours people for removing storage, because the design is to store the least amount of the storage on chain that you can.So when the execution ends, you were awarded a bit of the gas for the amount of storage that's cleared. 

但是，这有一个限制。你的调用堆栈不能大于 1024 层。这意味着你不能调用 1024 次或更多次，因为执行将恢复。这是一种防止利用 EVM 的保护措施。但是，在现实生活中，拥有如此长的调用堆栈不是很现实。这是因为每次调用都会发送越来越少的 gas。我们稍后会讨论这个问题。那么它是如何工作的呢？首先，我们将调用中所需的所有元素放入堆栈中。你将要传递的 calldata 放入内存中。然后你执行 call 指令。call会为你创建新的调用上下文。因此，它会创建新的堆栈和新的内存，并调用新的智能合约。 然后你以相同的方式执行调用的智能合约 就像你执行第一个智能合约一样。但现在你有了新的调用值、新的堆栈和新的内存。调用智能合约执行结束后，它会返回到调用合约，它通过使用 return 指令返回，并且 return正如我们在 EVM 代码 playground 中已经看到的那样，指令接受一个要返回的内存偏移量和内存长度参数。最后，我们来谈谈 gas 和费用。EVM 使用 gas 作为计算复杂性的度量。你可以想象 gas 的方式与汽车内部的处理方式类似。因此，你的汽车每英里消耗的 gas 大致相同，但加油站的 gas 价格可能不同。这里也是一样。每次你进行任何计算、添加某些内容、将某些内容放入内存、执行不同的操作时，你都会使用 gas。因此，当你启动交易时，你正在设置 gas 价格你想要支付的 gas 价格和 gas 限制。首先，在执行之前，EVM 会检查你是否真的有运行此交易所需的资金，直到你设置的 gas 限制。然后，每次操作都会减少你拥有的 gas直到交易执行结束或恢复，因为没有剩余 gas。EVM 也有 gas 退款的概念，每当你从存储中删除某些内容时。这是 EVM 奖励人们删除存储的方式，因为 设计是在链上存储尽可能少的存储量。因此，当执行结束时，你将获得一些gas，用于清除的存储量。

But here's the question, why do we even need gas? This is to prevent all the kinds of griefing attacks or denial of service attacks that you can think of.Imagine that there were no fees whatsoever and you can like freely execute everything that you want inside of EVM. Just imagine the amount of hacks and griefing that it will introduce, like people using, for example, Ethereum to mine Bitcoin or anything, because if they did not have to pay anything for the transactions, they will just have like free execution. And this is not profitable to anyone. And as you probably know, the blockchain rely on the notion of economical incentive for all the parties using it. We will now quickly go to the example that we had before, and we can see here how the gas works. So total gas consumed, this is a bit misleading because we did not execute anything yet, and we already consumed 21, 000 gas. 
Why is that? 
You have to know that each transaction in EVM costs constant value of 21,000, again, to prevent any griefings for the node operators, for validators, and then each operation costs some gas. You can see that current operation, which is push one, it costs free gas. If you move to next step, you can see that our total gas consumed was increased by three. Next operation, we have again push one, which costs again free gas. This added to our total gas, and now mstore, and the amount of gas consumed, but this instruction is a bit misleading, and we will go into a bit into that in the future episodes. But it said that it would cost free gas, but you can see that it burned six gas. Next two operations cost free, and the final return operation costs nothing. This is actually exception, and there are just a few of the opcodes that are not taking any gas. One of them is return. Second of them is stop. We have revert, and we have invalid opcode. This is special opcode, so it actually ends the execution of the transaction. But again, we'll go into details of it later. And finally, what I would quickly want to go through are events and locks. So apart from the on-chain state of the EVM, you can also have off-chain part, which are the locks. You can emit locks when executing transaction. However, you can use them only off-chain.There is no way of reading emitted event inside of the smart contract. And this is actually very useful for off-chain agents that are listening for any state changes on-chain, because locks are queryable, and you can easily read events emitted by a smart contract in specific transaction. Okay, and that's all concerning high-level EVM design. Next, we will go into details into each of the sections that I described here, starting from memory location. So stay tuned. 

但这里有一个问题，我们为什么需要 gas 呢？这是为了防止你能想到的所有类型的恶意攻击或拒绝服务攻击。想象一下，没有任何费用，你可以自由地在 EVM 内部执行你想要的一切。想象一下它会引入多少黑客攻击和恶意行为， 例如，人们使用以太坊来挖掘比特币或任何东西，因为如果他们不必为交易支付任何费用，他们将拥有免费执行权。这对任何人都没有好处。正如你可能知道的那样，区块链依赖于所有使用它的各方的经济激励。我们现在将快速转到我们之前的示例，我们可以在这里看到 gas 是如何工作的。因此，总 gas 消耗量，这有点误导，因为我们尚未执行任何操作，但我们已经消耗了 21000 gas。这是为什么呢？你必须知道，EVM 中的每笔交易都会花费一个恒定值即 21000，同样是为了防止节点运营商的任何恶意行为，对于验证者，然后每个操作都会花费一些 gas。你可以看到当前的操作，也就是 push one，它消耗 free gas。如果你进入下一步，你可以看到我们的总 gas消耗增加了 3。下一个操作，我们再次执行 push one，它仍然消耗 free gas。这增加到我们的总 gas 中，现在是 mstore，以及 gas 的数量消耗量，但是这个指令有点误导性，我们将在以后的剧集中对此进行更深入的探讨。但它说会消耗 free gas，但你可以看到它消耗了 6 个 gas。接下来的两个操作消耗 free gas，最后的 return 操作不消耗任何 gas。这实际上是例外，只有少数操作码不消耗任何 gas。其中一个是 return。第二个是 stop。我们有 revert，还有 invalid opcode。这是一个特殊的操作码，它实际上结束了交易的执行。同样，我们稍后会详细介绍。最后，我想快速介绍的是 events 和 logs。因此，除了 EVM 的链上状态之外，你还可以拥有链下部分，也就是 logs。你可以在执行交易时发出 logs。 但是，你只能在链下使用它们。无法在智能合约内部读取发出的 event。这对于链下代理来说非常有用，它们监听链上任何状态变化，因为 logs 是可查询的，并且你可以轻松读取智能合约在特定交易中发出的 event。好的，以上就是关于高级 EVM 设计的全部内容。接下来，我们将详细介绍我在这里描述的每个部分，从内存位置开始。敬请关注。

## 链上数据位置

视频 AI 总结： 该视频主要讲解了以太坊虚拟机（EVM）中的数据存储位置，包括 Stack（栈）、Memory（内存）、Storage（存储）、Calldata（调用数据）和 Code（代码）。EVM 作为栈机器，通过这些数据位置来存储和管理智能合约运行过程中的数据。理解这些数据位置的特性和使用方式，对于编写高效且安全的智能合约至关重要。

关键信息：

- **Stack（栈）**：LIFO（后进先出）结构，用于存储操作数和中间值，容量有限（1024个元素），操作成本较低，但访问深度受限。
- **Memory（内存）**：线性数据分配，临时存储区域，可扩展，用于存储外部调用返回的数据、创建合约等，有内存扩展成本（二次方级别），断电后数据丢失。
- **Storage（存储）**：持久化存储，键值对存储，用于保存合约状态，成本最高，数据在链上永久保存。
- **Calldata（调用数据）**：只读数据，存储外部调用合约时传入的参数，成本较低。
- **Code（代码）**：存储智能合约的字节码，不可变，最大尺寸为 24KB。
- EVM 通过 Stack 管理智能合约运行中的操作数，Memory 用于临时数据存储，Storage 用于持久化数据，Calldata 传递输入参数，Code 存储合约代码。
- EVM 有保护机制，防止过度使用 Memory 导致崩溃。
- 理解不同数据位置的特性，有助于优化智能合约的 Gas 消耗。























































