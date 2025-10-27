Alright, so here we are in our VS code, our opcodes FV. For this course, I do have GitHub pilot installed and set to on for this. And I do highly recommend you coding along with an AI extension or an AI buddy. I promise you it's going to make you so much faster.If there is a VS code extension that is AI friendly, that's not GitHub copilot. I recommend that as well because Microsoft is kind of dominating right now. 
好的，我们现在在 VS Code 中，这是我们的 opcodes FV。在本课程中，我确实安装了 GitHub Copilot 并将其设置为开启。我强烈建议你使用 AI 扩展或 AI 助手一起编写代码。我保证这会让你快很多。如果有一个对 AI 友好的 VS Code 扩展，但不是 GitHub Copilot。我也推荐它，因为微软现在有点占主导地位。

So let's go ahead and open up our terminal. Let's create a new folder with `MKDIR one-horse-store` or whatever you want to call it. Let's open that up like this. I have an issue in VS Code for why that keeps coming up. Looks like Max is having an issue with the recording, and now we're in a new folder here. We're going to use Forge, and of course, you know the drill: set up our new Foundry project. Great! We have Foundry set up here, so let's pop over to the readme, delete everything, and let's start our first task, which is going to be really easy: write a basic simple storage/horse store contract.

那么让我们开始吧。让我们打开终端。让我们创建一个新文件夹，使用 `MKDIR one-horse-store` 或者任何你想叫的名字。让我们像这样打开它。我在 VS Code 中遇到了一个问题，不知道为什么它一直出现。看起来 Max 在录制时遇到了问题，现在我们在这里创建了一个新文件夹。我们将使用 Forge，当然，你知道该怎么做：设置我们的新 Foundry 项目。太棒了！我们在这里设置了 Foundry，所以让我们转到 readme 文件，删除所有内容，然后开始我们的第一个任务，这将非常容易：编写一个基本的 simple storage / horse store 合约。

If you want, you can even go right to the GitHub associated with this and you can just go to SRC, horse store V1, horsestore.sol and copy this. You know what? I'm even just going to do that because it's really simple. Let's delete all these. Delete. Goodbye. In SRC we're going to make a new folder: Horse store V1 and in here new file horsestore.sol. I'm going to paste this in here.

如果你愿意，你甚至可以直接去与此相关的 GitHub，你可以直接去 SRC，horse store V1，horsestore.sol 并复制它。你知道吗？我甚至就打算这么做，因为它真的很简单。让我们删除所有这些。删除。再见。在 SRC 中，我们将创建一个新文件夹：Horse store V1，在这里新建文件 horsestore.sol。我将在这里粘贴它。

Additionally, if you're going through this code base, we also in the V1 section have this horse store symbolic.t.sol. For this section, we're actually not going to be doing this, but actually in the next section we're going to come back to horse store to actually set up a real minimalistic symbolic execution or formal verification test. So if you see this in the code base and you're like, what the heck is that? Don't worry about this until the next section, the math masters section, where we're going to introduce you to formal verification.

此外，如果你正在浏览此代码库，我们也在 V1 部分有这个 horse store symbolic.t.sol。在本节中，我们实际上不会这样做，但实际上在下一节中，我们将回到 horse store 来实际设置一个真正的极简符号执行或形式验证测试。所以如果你在代码库中看到这个，你会想，这到底是什么？在下一节，即数学大师节之前，不要担心这个，在那里我们将向你介绍形式验证。

So if this is looking like gibberish to you, you need to go back and you need to finish the advanced foundry section or even the basic solidity section. This should be very familiar to you. Like I said, we have a storage variable up here, number of horses. We have an update function, a way to update it, and we have a way to read it. So from a solidity perspective, this is incredibly minimal code.

所以如果这对你来说看起来像乱码，你需要回去，你需要完成高级 Foundry 部分或甚至是基本的 Solidity 部分。这对你来说应该非常熟悉。就像我说的，我们这里有一个存储变量，马的数量。我们有一个更新函数，一种更新它的方法，我们有一种读取它的方法。所以从 Solidity 的角度来看，这是非常少的代码。

However, if we pull up our terminal and we do forge build, this should work. We get successful. We can now come to the out folder, go into the horse store.json. And I'm actually going to do, pull up the command palette here with command shift P, or you can also do view command palette or whatever it is, or just Google how to pull up the command palette on VS code. And I'm going to do format document, just so that the JSON kind of forms nicely. And then I'm also going to pull up the command palette and do toggle word wrap, which makes it look horrible, but it'll help us a lot.

但是，如果我们打开终端并执行 forge build，这应该可以工作。我们得到了成功。我们现在可以来到 out 文件夹，进入 horse store.json。我实际上要做的是，使用 command shift P 调出命令面板，或者你也可以执行 view 命令面板或任何东西，或者只是谷歌如何调出 VS Code 上的命令面板。我将执行格式化文档，以便 JSON 格式良好。然后我还将调出命令面板并执行切换自动换行，这使它看起来很糟糕，但它会帮助我们很多。

So this is our horse store.json. So this is really the output of our compiler. This is all this stuff. Obviously, we have the ABI, we're going to minimize that. And then we have the bytecode, which is really what we're gonna be looking at, the deployed bytecode, method identifiers, and then some other stuff. There's a whole bunch of stuff in here, but whatever. This bytecode and this bytecode is what we're going to be looking at both of these bytecodes. And they do something different.

所以这是我们的 horse store.json。所以这实际上是我们的编译器的输出。这就是所有这些东西。显然，我们有 ABI，我们将最小化它。然后我们有 bytecode，这实际上是我们将要查看的内容，已部署的 bytecode，方法标识符，然后是一些其他的东西。这里有很多东西，但随便吧。这个 bytecode 和这个 bytecode 是我们要查看的这两个 bytecode。它们做的事情不同。

If you followed along in Cypher and updraft, we've kind of told you what the differences in these are, but we'll make it a little bit more clear in a minute. Now, in any smart contract, when it's created, or when you send a transaction to it, you're always sending this calldata or working with this calldata. You're always sending raw bytes, raw data to the blockchain.

如果你一直在关注 Cypher 和 updraft，我们已经告诉了你这些差异是什么，但我们在一分钟内会更清楚一点。现在，在任何智能合约中，当它被创建时，或者当你发送一个交易给它时，你总是发送这个 calldata 或使用这个 calldata。你总是将原始字节，原始数据发送到区块链。

And if you scroll down into the transaction, you can see we just view the original of this transaction. This is exactly what was sent to the blockchain. So when I send a transaction, we're going to have all this calldata, right? And this could, this data could be literally anything. We're assuming the smart contract that we send this calldata to has a way to process or understand what this calldata is supposed to do.

如果你向下滚动到交易中，你可以看到我们只是查看此交易的原始数据。这正是发送到区块链的内容。所以当我发送一个交易时，我们将拥有所有这些 calldata，对吗？这可以，这些数据可以实际上是任何东西。我们假设我们发送此 calldata 的智能合约有一种方法来处理或理解此 calldata 应该做什么。

And if we look at a contract and we scroll all the way to the bottom, we see all this hex, all this random data down here. It's this random data. It's all this hex that's responsible for processing that calldata and governing what the smart contract actually does. It's all of this hex that makes up the different opcodes or the machine readable instructions.

如果我们看一个合约，我们一直滚动到最底部，我们看到所有这些十六进制，所有这些随机数据都在这里。就是这些随机数据。正是所有这些十六进制负责处理该 calldata 并控制智能合约实际执行的操作。正是所有这些十六进制构成了不同的操作码或机器可读指令。

Every one byte or every two characters in this hex essentially makes up an opcode. There's some exceptions when you like push raw values in the stack, but we'll talk about that later. We as human beings are terrible at understanding machine level code. We don't really know how zero and ones work. We don't know how to work with thousands of transistors at a time. We don't really know how to send instructions to transistors very easily.

此十六进制中的每个字节或每两个字符本质上构成一个操作码。当你喜欢将原始值压入堆栈时，有一些例外，但我们稍后再谈。我们人类不擅长理解机器级代码。我们不太了解零和一是如何工作的。我们不知道如何一次处理数千个晶体管。我们不太清楚如何轻松地向晶体管发送指令。

So when we write code, we write it in what's called higher level languages like solidity that are more easy for human beings to understand machines. However, machines don't understand solidity. They understand machine code at the lowest level. The Ethereum virtual machine is exactly that it's a machine. And so in order for it to do anything, it needs very specific instructions that tell it, Hey, put this data in storage. Hey, put this data in memory. Hey, put this data in the stack.

因此，当我们编写代码时，我们用所谓的更高级的语言编写，例如 Solidity，这更容易让人类理解机器。但是，机器不理解 Solidity。它们在最低级别理解机器代码。以太坊虚拟机正是如此，它是一台机器。因此，为了让它做任何事情，它需要非常具体的指令告诉它，嘿，把这个数据放到存储中。嘿，把这个数据放到内存中。嘿，把这个数据放到堆栈中。

We'll learn about the stack later, et cetera. And it's all of these and all of these machine readable instructions are also known as op codes. So this Ethereum virtual machine that you've heard a lot about before this magical thing that doesn't really exist. However, it's implemented. So the Ethereum virtual machine is, is this fake machine that says, okay, when you send data to the blockchain to Ethereum, convert that to, you know, send money, send tokens or whatever.

我们稍后会学习堆栈，等等。所有这些以及所有这些机器可读指令也称为操作码。所以你之前听说过的以太坊虚拟机这个实际上并不存在的魔法事物。但是，它已经实现了。所以以太坊虚拟机是，是这个虚假的机器，它说，好的，当你将数据发送到以太坊区块链时，转换该数据为，你知道，发送金钱，发送代币或任何东西。

And all of those instructions of the Ethereum virtual machine are in these op codes, these op codes for the EVM. So whenever you say, for example, Hey, store the number seven at storage slot0, there's a set of op codes that are going to do that. They're a set of machine readable codes. It's all these op codes combined that make up the EVM op codes are machine readable codes. And it's the combination of all these op codes that make up the EVM.

以太坊虚拟机的所有这些指令都在这些操作码中，这些 EVM 的操作码。所以无论何时你说，例如，嘿，将数字 7 存储在存储槽 0 中，都有一组操作码将执行该操作。它们是一组机器可读代码。正是所有这些操作码的组合构成了 EVM 操作码，操作码是机器可读代码。正是所有这些操作码的组合构成了 EVM。

So the EVM is really just this agreed upon set of op codes that we say does stuff. It's a virtual machine because there's technically no like Ethereum machine. Whenever you run a node, your computer actually pretends to be this stack machine, this Ethereum virtual machine. Don't worry about that too much for now. Op codes are these very specific machine level instructions. And you can see a list of them.

所以 EVM 实际上只是这组约定的操作码，我们说它会做一些事情。它是一个虚拟机，因为从技术上讲，没有像以太坊机器这样的东西。每当你运行一个节点时，你的计算机实际上会假装成这个堆栈机，这个以太坊虚拟机。现在不要太担心这个。操作码是这些非常具体的机器级指令。你可以看到它们的列表。

If you go to the ethereum.org website, op codes are pretty common in computer science is also known as instruction, machine code, instruction code, instruction, syllable. There's a ton of different words for it. Op codes in general are very common in computer science as a whole. However, in the smart contracts themselves, these need to be a set of these op codes, these need to be a set of these machine readable instructions.

如果你去 ethereum.org 网站，操作码在计算机科学中非常常见，也称为指令、机器代码、指令代码、指令、音节。有很多不同的词来形容它。总的来说，操作码在整个计算机科学中非常常见。但是，在智能合约本身中，这些需要是一组这些操作码，这些需要是一组这些机器可读指令。

So that when we do send calldata, when we do send data to the smart contracts, they have a way to actually interpret the calldata and work with the calldata. And if we scroll all the way down to the bottom, we can see the actual contract creation code, we can see deployed bytecode, etc. And all of these in the contract creation code and deployed bytecode is going to be op codes.

所以当我们发送 calldata，当我们发送数据到智能合约时，它们有一种方法可以实际解释 calldata 并使用 calldata。如果我们一直滚动到底部，我们可以看到实际的合约创建代码，可以看到部署的 bytecode 等。所有这些在合约创建代码和部署的 bytecode 中都将是 op codes。

Typically, each two of these digits is going to be a so this six zero at the start of this contract, we can actually copy this. And I'm going to go to one of my favorite sites for learning about op codes, evm codes, I can paste that 60 in and I can see what the 60 stands for. So the 60 op code, which, which again is going to be the hex, so we can do cast to base OX six deck, which is the 96 op code, or we can see the binary, this is what the binary of that op code looks like.

通常，每两个数字将是一个，所以这个合约开头的 60，我们实际上可以复制它。我将前往我最喜欢的网站之一学习 op codes，EVM codes，我可以粘贴 60 进去，然后我可以看看 60 代表什么。所以这个 60 op code，它，再次强调，将是十六进制，所以我们可以转换为 OX six deck，也就是 96 op code，或者我们可以看到二进制，这就是该 op code 的二进制形式。

So this 60 op code stands for the push one op code, which is going to place one byte item onto the stack, we'll learn what the stack is in a little bit, but there's going to be some familiar op codes in here, like m store and s store and s load and m load, right, we've learned about those in the Foundry full course when learning about some gas optimizations.

所以这个 60 op code 代表 push one op code，它会将一个字节的项目放到堆栈上，我们稍后会学习什么是堆栈，但是这里会有一些熟悉的 op codes，比如 m store 和 s store 和 s load 和 m load，对吧，我们在 Foundry full course 中学习 gas 优化时了解过这些。

So this contract is just this massive set of these op codes, which essentially tell our machines exactly how to process this calldata that gets sent to them. In the Ethereum world, we can actually change or add op codes through the Ethereum improvement proposals. As of recording a few months ago, they added the push zero op code, which was awesome.

所以这个合约只是这些 op codes 的一个巨大的集合，它本质上告诉我们的机器如何精确地处理发送给它们的 calldata。在以太坊世界中，我们实际上可以通过以太坊改进提案来更改或添加 op codes。在几个月前录制时，他们添加了 push zero op code，这太棒了。

So just to recap, in a smart contract, a smart contract is going to be a set of op codes combined, where in the contract code, every two of these hexes stands for one byte. And each op code is one byte long. And we can see what each one of these op codes does. Again, there are going to be some scenarios where it's not every two, because for example, we could do like push four where we place four bytes onto the stack.

所以简单回顾一下，在智能合约中，智能合约将是一组 op codes 的组合，其中在合约代码中，每两个十六进制数代表一个字节。每个 op code 都是一个字节长。我们可以看到每个 op code 的作用。同样，在某些情况下，不是每两个，因为例如，我们可以执行 push four，我们将四个字节放到堆栈上。

So we would see like a 63 and then four bytes instead of two op codes back to back, right. So but don't worry about that too much for now. Main thing is, boom, this is an op code 60 stands for push 160 stands for push one, boom, 60. This is not an op code, this is going to be how much is going to be pushed to the stack. This is an op code 52 is another op code, which stands for m store. So lots of op codes.

所以我们会看到像 63 这样的东西，然后是四个字节，而不是两个 op codes 背靠背，对吧。所以，但现在不用太担心。最重要的是，砰，这是一个 op code，60 代表 push 1，60 代表 push one，砰，60。这不是一个 op code，这将是推送到堆栈的字节数。这是一个 op code，52 是另一个 op code，代表 m store。所以有很多 op codes。

If this isn't making sense to you right now, it's okay, it will. Okay, now that we've learned about op codes, we're actually going to go ahead and rewrite our horse store.sol into huff. Why are we learning huff? Well, again, if you learn huff, surprisingly, all of this EVM op code stuff just becomes easier because it really becomes easy to see how these smart contracts work at the lowest level.

如果这现在对你来说没有意义，没关系，它会的。好的，现在我们已经了解了 op codes，我们实际上要继续将我们的 horse store.sol 重写为 huff。我们为什么要学习 huff？嗯，再说一次，如果你学习 huff，令人惊讶的是，所有这些 EVM op code 的东西变得更容易了，因为它真的很容易看到这些智能合约如何在最低级别上工作。

So let's go ahead and get started working with and installing huff. In order for us to install huff, we need to install the huff documentation. If you're following along with the course GitHub, we scroll down into our curriculum, we have a link to the huff documentation right in the GitHub there. And this is the huff documentation, you can go ahead and go to the getting started and follow along with the docs here in order to install huff.

所以让我们开始使用和安装 huff。为了安装 huff，我们需要安装 huff 文档。如果你正在关注课程 GitHub，我们向下滚动到我们的课程中，我们在 GitHub 中有一个指向 huff 文档的链接。这是 huff 文档，你可以继续前往入门指南，并按照此处的文档进行操作以安装 huff。

I find that the easiest way to install huff is to first install this huff up command. And all we need to do to install it is to run this, run this command, which will download this sh bit, and then run bash on it. So I'm going to go ahead and install huff up by pasting this into your terminal. Great. And after this run successfully, again, you'll probably need a Linux like environment in order to do this, you'll get an output that looks something like detected your preferred shell is bash and added huff to your path, and it'll add this to your bash RC.

我发现安装 huff 最简单的方法是首先安装这个 huff up 命令。我们安装它所需要做的就是运行这个，运行这个命令，它将下载这个 sh bit，然后在其上运行 bash。所以我要通过将此粘贴到你的终端中来安装 huff up。太棒了。在此成功运行后，同样，你可能需要像 Linux 这样的环境才能做到这一点，你将获得一个看起来像检测到你首选的 shell 是 bash 并将 huff 添加到你的路径的输出，它会将其添加到你的 bash RC。

So you need to run this command first, and then run huff up to install the huff compiler. Once huff up is done, you should be able to do huff, huff C dash dash version, and get an output that looks like this. Now depending on the shell that you're working with, you want to make sure that it actually was correctly added to your your bash RC, your bash profile or your ZCH or whatever config file that your shell works with.

所以你需要先运行这个命令，然后运行 huff up 来安装 huff 编译器。一旦 huff up 完成，你应该能够执行 huff，huff C dash dash version，并获得一个看起来像这样的输出。现在，根据你正在使用的 shell，你想要确保它实际上已正确添加到你的 bash RC，你的 bash profile 或你的 ZCH 或你的 shell 使用的任何配置文件。

So I want you to go ahead and actually delete your shell by hitting a little trash can or closing out of the terminal or whatever, pulling it back up and then doing huff C dash dash version again. If you don't get an output here, but you got an output last time, that means that huff wasn't correctly added to your bash RC or your bash profile or your ZCH or whatever terminal you're working with config file.

所以我想让你继续删除你的 shell，通过点击一个小垃圾桶或关闭终端等，将其拉回并再次执行 huff C dash dash version。如果你在这里没有得到输出，但上次得到了输出，这意味着 huff 没有正确添加到你的 bash RC 或你的 bash profile 或你的 ZCH 或你正在使用的任何终端配置文件。

If you're running into issues here, this is a great time to chat with ChatGPT, Google around, figure out exactly what's going on here. If you're not using WSL, you can of course use the Windows installation or whatever installation process you want here. But remember, installing stuff is often the most frustrating part of development work. So don't get too frustrated if it doesn't work right away and be sure to Google around and ask your AI buddies for help. Or of course, come to the GitHub discussions associated with this course.

如果你在这里遇到问题，这是一个很好的时机与 ChatGPT 聊天，在 Google 上搜索，弄清楚这里到底发生了什么。如果你不使用 WSL，你当然可以使用 Windows 安装或你想要的任何安装过程。但请记住，安装东西通常是开发工作中最令人沮丧的部分。所以如果它没有立即工作，不要太沮丧，并且一定要在 Google 上搜索并向你的 AI 伙伴寻求帮助。或者，当然，可以参加与本课程相关的 GitHub 讨论。

As we're coding along here, be sure to use the docs as a reference guide as well, because the docs are going to be the most up to date. The docs are incredibly helpful, and there's a whole ecosystem around the huff code bases. But great. Now that we have huff C installed, we can actually start writing some huff smart contracts. Let's actually rewrite our horse store in huff and rewriting it in huff will actually teach us how smart contracts work at the lowest level and will teach us a ton about these opcodes.

当我们在这里进行编码时，请务必使用文档作为参考指南，因为文档将是最新的。这些文档非常有用，并且围绕 huff 代码库有一个完整的生态系统。但是太棒了。现在我们已经安装了 huff C，我们可以开始编写一些 huff 智能合约。让我们实际上用 huff 重写我们的 horse store，用 huff 重写它实际上会教我们智能合约如何在最低级别上工作，并且会教我们很多关于这些 opcodes 的知识。

To get started rewriting our smart contract in huff, let's go ahead and create a new file. We'll call it horse store.huff. And what's cool is now that we're, and what's cool about this is because we have these two smart contracts should be exactly the same. This one just written in a different language. When we actually go to write tests, we can write one suite of tests and just apply it to both contracts. This is also known as differential testing.

要开始用 huff 重写我们的智能合约，让我们继续并创建一个新文件。我们将其命名为 horse store.huff。很酷的是，现在我们，这件事很酷的是因为我们有两个智能合约应该完全相同。这个只是用不同的语言编写的。当我们实际去编写测试时，我们可以编写一套测试，然后将其应用于两个合约。这也称为差异测试。

And if done with fuzzing, it's sometimes called differential fuzzing. And it's incredibly powerful for people looking to build code bases in solidity, and then optimize them in a much faster, much more powerful lower level language like huff. You write your main smart contracts in solidity, so they're easier to read easier to understand. And then you either formally verify or you fuzz them against your gas optimized edition that you actually deployed to the blockchain.

如果使用模糊测试完成，有时称为差异模糊测试。对于希望在 Solidity 中构建代码库，然后在更快、更强大的像 huff 这样的低级语言中优化它们的人来说，它非常强大。你用 Solidity 编写你的主要智能合约，所以它们更容易阅读，更容易理解。然后你要么形式化验证，要么针对你的实际部署到区块链的 gas 优化版本进行模糊测试。

But anyways, let's get started working with huff here. Now when we work with a solidity smart contract, let's say we deployed this contract on chain. If I call the function read number of horses, we almost kind of magically get it to return this number of horses. You know, for example, if I had deployed this smart contract, this our horse store in remix, right, I deployed it down here, I do read number, we almost kind of magically get the response zero back when I call one to update the number of horses and rerun.

但无论如何，让我们开始在这里使用 huff。现在，当我们使用 Solidity 智能合约时，假设我们在链上部署了这个合约。如果我调用函数 read number of horses，我们几乎有点神奇地让它返回这个马的数量。你知道，例如，如果我部署了这个智能合约，这个我们的 horse store 在 remix 中，对吧，我在这里部署了它，我执行 read number，我们几乎有点神奇地得到了响应零，当我调用 one 来更新马的数量并重新运行时。

Sorry, I was kind of zoomed out. But you get the picture. When I call read number of horses, I very almost magically get this one to get returned to us. But when we actually make this call, when we actually make any call, if I actually call update number of horses again, in remix, and we can see this in founder two, you know that we actually send the input that we sent is actually a whole bunch of binary itself a whole bunch of just data itself.

抱歉，我有点缩小了。但你明白了。当我调用 read number of horses 时，我几乎神奇地得到了这个 one 返回给我们。但是当我们实际进行此调用时，当我们实际进行任何调用时，如果我实际上再次调用 update number of horses，在 remix 中，我们可以在 founder two 中看到这一点，你知道我们实际发送的输入实际上是一大堆二进制本身就是一大堆数据本身。

So if I copy this binary of the input of update horse, put a little comment here, paste it, it's actually this kind of ridiculous jumble of numbers. When we call update horse number, and we add a value here, this data that gets input to the smart contract is called the calldata. So this whole thing is the calldata. And it's this calldata that tells our smart contract, hey, this is what I want you to do.

所以如果我复制更新马匹的输入的这个二进制文件，在这里加一点注释，粘贴一下，实际上是这种荒谬的数字组合。当我们调用 update horse number，并且在这里添加一个值时，输入到智能合约的这个数据被称为 calldata。所以整个东西就是 calldata。正是这个 calldata 告诉我们的智能合约，嘿，这是我希望你做的事情。

So how does Solidity know that this jumble of numbers tells the EVM tells our smart contract, hey, update that number of horses, this jumble of letters. So we have two questions here. How do Remix know that when we press this update number of horses to send this exact data string to our smart contract? And then number two, how does Remix even know to update this storage variable with this jumble of binary bytes data? Like how did this happen?

那么 Solidity 怎么知道这堆数字告诉 EVM 告诉我们的智能合约，嘿，更新马匹的数量，这堆字母。所以我们这里有两个问题。Remix 怎么知道当我们按下这个更新马匹数量的按钮时，会发送这个精确的数据字符串到我们的智能合约？然后第二个问题，Remix 怎么知道用这堆二进制字节数据来更新这个存储变量？这是怎么发生的？

So these are the two questions that we're going to answer now. And we're going to answer them by learning Huff. Let's start by answering this first question. Where did this data come from? Now, if you've taken the Foundry advanced course, you know what a function selector is, you know, we have this update horse number and a uint256. The two of these are the function signature, and we can hash them to make the function selector.

所以这是我们现在要回答的两个问题。我们将通过学习 Huff 来回答这些问题。让我们从回答第一个问题开始。这些数据从哪里来的？现在，如果你参加过 Foundry 高级课程，你就知道什么是函数选择器了，你知道，我们有这个 update horse number 和一个 uint256。这两个是函数签名，我们可以哈希它们来生成函数选择器。

So if I do cast sig, update number, update horse number, uint256, I get this OXCDFEA2E or whatever it is, right? Let me actually copy copy paste this from Remix. So this as we can see, actually matches the first part of this huge chunk of data that was sent in. So this is what's known as the function selector, right? So when we send this data to our smart contract, we're saying, Hey, use the function that has the selector.

所以如果我执行 cast sig, update number, update horse number, uint256, 我会得到这个 OXCDFEA2E 或者其他什么，对吧？让我实际上从 Remix 复制粘贴这个。所以我们可以看到，这实际上匹配了发送进来的这大块数据的第一部分。所以这就是所谓的函数选择器，对吧？所以当我们发送这个数据到我们的智能合约时，我们是在说，嘿，使用具有该选择器的函数。

So this CDFEA2E matches right here. So somehow solidity knows our smart country knows to take the first four bytes of the calldata and use that to actually pick which function we're referring to. This is actually called function dispatching. And it's something that solidity does natively for us. So there's no code in here that basically says, you know, if the calldata has four bytes that match the update horse number function selector, you should call it doesn't have that. It does that natively for us when it compiles.

所以这个 CDFEA2E 正好匹配这里。所以 solidity 知道，我们的智能合约知道获取 calldata 的前四个字节，并用它来实际选择我们指的是哪个函数。这实际上被称为函数分发。这是 solidity 为我们原生做的事情。所以这里没有代码基本上说，你知道，如果 calldata 有四个字节匹配 update horse number 函数选择器，你应该调用它，它没有那个。它在编译时为我们原生完成。

Now, instead of update horse number, we do cast sig read number of horses. This would be the function selector, right? And so when we send this calldata to our smart contract, our smart contract goes, Ah, okay, I'm going to dispatch your function call to read number of horses, because that's what your function selector tells me to do. So again, this happens on the back end for solidity, solidity sets up this function dispatching for us.

现在，如果我们不用 update horse number，而是执行 cast sig read number of horses。这将是函数选择器，对吧？所以当我们发送这个 calldata 到我们的智能合约时，我们的智能合约会说，啊，好的，我将分发你的函数调用到 read number of horses，因为那是你的函数选择器告诉我要做的。所以再次说明，这发生在 solidity 的后端，solidity 设置这个函数分发为我们。

But if we're going to write our smart contract in pure opcodes, which essentially is what Huff does, we actually have to write that function dispatcher ourself. So this is already one of the most powerful things that we can learn right from working with Huff is function dispatching. So again, the flow will look like we send the calldata, our smart contract reads our calldata and goes, Okay, what function selector are you looking for? Ah, you're looking for this function, I'm going to route your call to that function.

但是如果我们要在纯操作码中编写我们的智能合约，这本质上就是 Huff 所做的，我们实际上必须自己编写那个函数分发器。所以这已经是我们可以从使用 Huff 中学到的最强大的东西之一，就是函数分发。所以再次说明，流程看起来像我们发送 calldata，我们的智能合约读取我们的 calldata 并说，好的，你要找哪个函数选择器？啊，你要找这个函数，我将把你的调用路由到那个函数。

In a way, us sending calldata to a smart contract is going to be the same as us calling like a Python script, or a JavaScript script. And we need an entry point for our calldata to be processed. In Huff, we call that entry point main. In the binary, it'll just take your calldata and execute it through whatever binary is there. But we'll talk about that in a bit. And again, I know I'm throwing a lot of terminology at you here, but I promise it'll make sense.

在某种程度上，我们发送 calldata 到智能合约与我们调用像 Python 脚本或 JavaScript 脚本是一样的。我们需要一个入口点来处理我们的 calldata。在 Huff 中，我们称这个入口点为 main。在二进制文件中，它只会获取你的 calldata 并通过任何存在的二进制文件来执行它。但我们稍后会讨论这个问题。再次说明，我知道我在这里向你抛出了很多术语，但我保证它会变得有意义。

Just follow along with me for now, we're going to really dial this in for you. So we need to actually code this function dispatching. So in order for us to have an entry point for our calldata, we need to define a function that we're going to call main in Huff. Now the Huff language does have functions, but for the most part, we're going to ignore functions exist in Huff. And we're just going to work with macros. For all intents and purposes, macros essentially are functions, they're a little bit different, don't worry about the difference for now.

现在先跟着我，我们将真正为你深入了解这一点。所以我们需要实际编写这个函数分发。所以为了让我们有一个 calldata 的入口点，我们需要定义一个我们将在 Huff 中称为 main 的函数。现在 Huff 语言确实有函数，但在大多数情况下，我们将忽略 Huff 中存在函数。我们将只使用宏。就所有意图和目的而言，宏本质上是函数，它们有点不同，现在不用担心差异。

So we're going to write a main function, which will do this function dispatching. And remember, we don't have to do this in Solidity. But we do have to do this in Huff. And importantly, we do have to do this in our bytecode as well. So learning how to do it in Huff will teach us how it's done in the bytecode. So let's get started. So we're going to define macro main like this. Now I am going to put the rest of the syntax for this, but don't worry about what it means quite yet.

所以我们将编写一个 main 函数，它将执行这个函数分发。记住，我们不必在 Solidity 中这样做。但我们必须在 Huff 中这样做。重要的是，我们还必须在我们的字节码中这样做。所以学习如何在 Huff 中做到这一点将教会我们如何在字节码中完成。让我们开始吧。所以我们将像这样定义宏 main。现在我将为它添加其余的语法，但暂时不用担心它的含义。

I'm going to say takes zero, returns zero. So this is how you define a macro, which is basically a function in Huff. Define macro, name of the macro, and then takes and returns. So the takes and returns refer to what it's going to take off the stack and return onto the stack. But don't worry about that yet. Boom, we have our main function. Oops, I'm sorry, the main macro needs to be uppercase, not lowercase.

我将说 takes zero, returns zero。所以这是你如何定义一个宏，它基本上是 Huff 中的一个函数。定义宏，宏的名称，然后是 takes 和 returns。所以 takes 和 returns 指的是它将从堆栈中取出什么，以及返回到堆栈上什么。但暂时不用担心。砰，我们有了我们的 main 函数。哎呀，对不起，main 宏需要大写，而不是小写。

Now we can even test that this compiles by running Huff C on it. So we'll do Huff C, src, Horstor v1, Horstor.huff, and we'll get compiling and then no output, which means it compiles successfully. We can actually rerun the command and do dash B, and we'll actually get the bytecode associated with just this smart contract. So just this smart contract, just this bit of Huff returns all of this bytecode here, all of these little opcodes.

现在我们甚至可以通过在其上运行 Huff C 来测试它是否编译。所以我们将执行 Huff C, src, Horstor v1, Horstor.huff，我们将得到编译，然后没有输出，这意味着它编译成功了。我们实际上可以重新运行该命令并执行 dash B，我们将实际获得与此智能合约关联的字节码。所以仅仅这个智能合约，仅仅这一小段 Huff 返回了所有这里的字节码，所有这些小操作码。

And we're going to come back to what those opcodes mean. But when we do the dash B, we get the output of the binary here. Boom, we have a minimal Huff smart contract, which looks like this. And this is the smallest, most basic smart contract you can have. And we haven't done anything really. Now, additionally, I have some syntax highlighting in here. I'm using a Huff extension. So if you're using VS Code, and you want to have some syntax highlighting for Huff, install this extension, it'll give you these nice little highlightings here.

我们将回到这些操作码的含义。但是当我们执行 dash B 时，我们在这里得到了二进制文件的输出。砰，我们有了一个最小的 Huff 智能合约，它看起来像这样。这是你可以拥有的最小、最基本的智能合约。我们还没有真正做任何事情。现在，此外，我在这里有一些语法高亮显示。我正在使用一个 Huff 扩展。所以如果你正在使用 VS Code，并且你想要一些 Huff 的语法高亮显示，安装这个扩展，它会给你这些漂亮的小高亮显示。

So we're still in the process of trying to make the function dispatcher, right? We're still in the process of us trying to code this bit that says, okay, if this is your function selector, call this function. But we saw actually when we when we compile this, we got this output here. But clearly, we still haven't coded our function dispatcher, we just coded this main function. So what the what is this? What is this code doing?

所以我们仍然在尝试制作函数分发器，对吧？我们仍然在尝试编写这一部分代码，它说，好的，如果这是你的函数选择器，调用这个函数。但是我们看到，实际上当我们编译这个时，我们得到了这个输出。但显然，我们仍然没有编写我们的函数分发器，我们只是编写了这个 main 函数。那么这是什么？这段代码在做什么？

Well, when you compile any smart contract, most smart contracts are compiled into three or four different sections, the contract creation code, the runtime code, and then the metadata and sometimes constructors and whatever else the compiler feels like doing the solidity compiler does this nice little bit of op code syntax where it adds a little invalid op code between the different sections. So it's even easier to tell which section is which.

好吧，当你编译任何智能合约时，大多数智能合约都被编译成三个或四个不同的部分，合约创建代码，运行时代码，然后是元数据，有时是构造函数以及编译器想做的任何其他事情，solidity 编译器会添加一个小的操作码语法，它在不同的部分之间添加一个小的无效操作码。所以更容易分辨哪个部分是哪个。

So after contract creation, they pop a little invalid. After the runtime, they pop a little invalid. After the metadata, they don't pop anything because the contract's done. But these three sections are typically how a smart contract is created. The first section or the contract creation part of the code is what code that tells the blockchain to actually store the smart contract. This first chunk here, even if we have no what's called runtime code, this is still our contract creation bytecode.

所以在合约创建之后，他们会弹出一个小的无效操作码。在运行时之后，他们会弹出一个小的无效操作码。在元数据之后，他们不会弹出任何东西，因为合约已经完成。但这三个部分通常是创建智能合约的方式。第一部分或代码的合约创建部分是告诉区块链实际存储智能合约的代码。这里的第一个块，即使我们没有所谓的运行时代码，这仍然是我们的合约创建字节码。

So when we finish this in Huff, we're actually gonna have two sections, we're gonna have the contract creation bytecode, we're gonna have this runtime code, and we're not going to have any metadata, but we could add metadata if we want. Solidity and Vyper natively add metadata to their smart contracts. We'll go through what this contract creation bytecode typically does. But this is a minimalist example of what the contract creation bytecode looks like.

所以当我们用 Huff 完成这个时，实际上会有两个部分，我们将有 contract creation bytecode，我们将有这个 runtime code，并且不会有任何 metadata，但是如果需要，我们可以添加 metadata。Solidity 和 Vyper 原生地将 metadata 添加到它们的智能合约中。我们将介绍 contract creation bytecode 通常做什么。但这是一个 contract creation bytecode 样子的极简示例。

All this contract creation bytecode is responsible for doing is taking your smart contract and saving it on chain. Because in order for us to deploy any smart contract, here's an example of a transaction that created a smart contract. In order for us to deploy a smart contract, we once again, we send Ethereum some calldata, we send it just a huge lump of binary. So in this giant lump of calldata in this giant lump of binary, the first section of this is going to be yes, this contract creation bytecode.

所有这些 contract creation bytecode 负责做的是获取你的智能合约并将其保存在链上。因为为了部署任何智能合约，这里有一个创建智能合约的交易示例。为了部署智能合约，我们再次向以太坊发送一些 calldata，我们发送给它一大块二进制数据。因此，在这巨大的 calldata 块中，在这巨大的二进制文件中，第一部分将是，是的，这个 contract creation bytecode。

All this usually says is essentially, hey, take the binary after me and stick it on chain. That's essentially all the contract creation bytecode does. And we'll go through the opcodes and how this actually works. But essentially, it says hey, copy this, copy the next chunk of code, save it on chain, please and thank you. And that's essentially how the contract creation bytecode works. So even though we have no runtime code, we haven't coded anything, Huff is smart enough to know that we at least need a contract creation bytecode.

通常所有这些都表示，嘿，获取我之后的二进制文件并将其放在链上。这基本上就是 contract creation bytecode 所做的全部。我们将介绍操作码以及这实际上是如何工作的。但本质上，它说，嘿，复制这个，复制下一个代码块，将其保存在链上，请谢谢。这基本上就是 contract creation bytecode 的工作方式。因此，即使我们没有 runtime code，我们也没有编写任何代码，Huff 足够聪明，知道我们至少需要一个 contract creation bytecode。

And even if we compile this Huff smart contract that doesn't do anything, we have this contract creation bytecode here. You can actually typically tell that something is a contract creation bytecode by looking for the code copy opcode. So we talked about opcodes in the Foundry Flow course. But as we know, all these little 60 all these little numbers are referring to some type of opcode. And there's a phenomenal website that teaches us all these opcodes and actually gives us a little playground to try them out and teaches us what they do.

即使我们编译这个什么都不做的 Huff 智能合约，我们这里有这个 contract creation bytecode。实际上，通常可以通过查找 code copy opcode 来判断某个东西是否是 contract creation bytecode。因此，我们在 Foundry Flow 课程中讨论了操作码。但正如我们所知，所有这些小的 60，所有这些小的数字都指向某种类型的操作码。并且有一个非常棒的网站，可以教我们所有这些操作码，实际上，它为我们提供了一个小型的试验场来尝试它们，并教我们它们的作用。

But the opcode that actually says, hey, stick this smart contract on chain is going to be this opcode called code copy. So typically, if you see this code copy opcode, or the 39 opcode, that's an indication that you're looking at the contract creation part of the code base. Typically, you can still have this in the runtime. But if you're looking for a quick litmus test of what section of the code you're in, you can look for this 39.

但是实际上说，嘿，把这个智能合约放在链上的操作码将是这个名为 code copy 的操作码。因此，通常，如果你看到此 code copy opcode 或 39 opcode，这表明你正在查看代码库的 contract creation 部分。通常，你仍然可以在 runtime 中使用它。但是，如果你正在寻找一个快速的石蕊测试来确定你所在的代码部分，你可以查找此 39。

And if we look in here, we do indeed see, okay, so we see F3, 3D, 39, we do indeed see there's a code copy opcode in this contract creation bytecode. So again, we're going to go over what this does in a little bit. Make sense? Okay, let's continue. Now in Solidity, when we're working with variables, Solidity almost kind of magically just knows where to put them. They know magically if it's a memory variable, or if it's a storage variable, and what variables to kill after a program has ended.

如果我们在其中查找，我们确实看到，好的，所以我们看到 F3、3D、39，我们确实看到此 contract creation bytecode 中有一个 code copy opcode。所以，我们稍后将再次介绍它的作用。明白了吗？好的，让我们继续。现在在 Solidity 中，当我们使用变量时，Solidity 几乎有点神奇地知道将它们放在哪里。他们神奇地知道它是 memory 变量还是 storage 变量，以及程序结束后要销毁哪些变量。

So number of horses here is clearly a storage variable. So after a program finishes, it'll keep that value to persist. However, some memory variable like if I added youint256, hello equals seven. Once the transaction to update horse number finishes, this hello variable will be inaccessible. It won't matter anymore. So how does Solidity know what to keep and what to get rid of? And how does it compute all this different stuff? And we have to ask this question in order to answer this question.

所以这里的马匹数量显然是一个 storage 变量。因此，程序完成后，它将保留该值以保持持久性。但是，一些 memory 变量，例如如果我添加了 uint256，hello 等于 7。一旦更新马匹数量的交易完成，此 hello 变量将无法访问。它不再重要。那么 Solidity 如何知道要保留什么以及要摆脱什么？以及它如何计算所有这些不同的东西？我们必须提出这个问题才能回答这个问题。

So I kind of reformatted our questions here, because we're getting more and more. And also, more importantly, how does the EVM know what to do with this? Does it just stick everything in storage for a little bit and then move it around? Unlike in Solidity, Solidity will kind of magically say, okay, this call data, I know where to put it, I know what to do with it. But guess what? We are writing HuffCode. We are essentially going to be doing the opcodes ourselves here.

所以我在这里重新格式化了我们的问题，因为我们得到越来越多的东西。而且，更重要的是，EVM 如何知道如何处理这个问题？它是否只是将所有内容暂时存储在 storage 中，然后再移动它？与 Solidity 不同，Solidity 会神奇地说，好的，这个 call data，我知道把它放在哪里，我知道该怎么处理它。但是猜猜怎么着？我们正在编写 HuffCode。我们本质上将在这里自己完成操作码。

Now in order for us to understand what places we can put stuff, we want to take a look at this tweet from a very prevalent smart contract developer in the space, Pascal. And I'll have this image in the GitHub associated with this course. He gave us this image of some of the most important places we can actually store data once transient storage comes into play. Transient storage isn't quite a thing quite yet. Don't worry about that for now.

现在，为了让我们了解我们可以将东西放在哪些地方，我们想看看来自该领域一位非常流行的智能合约开发人员 Pascal 的这条推文。我将在与本课程相关的 GitHub 中提供此图像。他给了我们这张图片，其中包含了一些最重要的地方，一旦瞬态存储发挥作用，我们实际上可以存储数据。瞬态存储还不是一件完全确定的事情。暂时不用担心。

But these are some of the different things that the EVM actually can work with and keep track of. The most important ones that we're going to be looking at are going to be the stack, memory, and storage. There's also obviously the EVM code itself. We have a program counter and available gas. Transient storage doesn't quite exist yet. And it's not super important for what we're going to be covering here. But we are going to focus on the stack, memory and account storage.

但这些是 EVM 实际上可以使用和跟踪的不同事物。我们将要研究的最重要的内容是 stack、memory 和 storage。显然还有 EVM 代码本身。我们有一个程序计数器和可用的 gas。瞬态存储还不存在。对于我们在这里要介绍的内容来说，它并不是非常重要。但我们将重点关注 stack、memory 和 account storage。

So when we're looking to grab this data and work with this data, if we want to do any type of computations, we first need to figure out where do we want to do computations? Where do we want to put this data? So the EVM is what's known as a stack machine. And of all these places, the cheapest places gas wise to do stuff is going to be on the stack. And we actually know this because we go back to this EVM .codes website, we have this minimum gas, which gives us a clue as to how much gas each one of these operations are going to do.

因此，当我们希望获取此数据并使用此数据时，如果我们想进行任何类型的计算，我们首先需要弄清楚我们要在哪里进行计算？我们想把这些数据放在哪里？因此，EVM 被称为堆栈机。在所有这些地方中，gas 方面最便宜的地方是在堆栈上。我们实际上知道这一点，因为我们回到这个 EVM .codes 网站，我们有这个最小 gas，它为我们提供了一个线索，关于每个操作将执行多少 gas。

This add operation, what it does is it takes the first two items on the stack and returns onto this stack data structure, the addition of the two of them, and it costs around three gas. And if you look for another add opcode, you'll see that the only way to add two things in the EVM world is on the stack. So at some point or another, if you want to add anything, it needs to be on the stack. EVM is known as a stack machine or stack state machine, where most of the operations we're going to be working with are going to be putting stuff on and pulling stuff off of what's called a stack.

这个 add 操作，它所做的是获取前两个堆栈上的项目，并返回到此堆栈数据结构上，即这两个项目的加法，它花费大约三个 gas。如果你查找另一个 add 操作码，你会发现，在 EVM 世界中添加两个东西的唯一方法是在堆栈上。因此，在某个时候，如果你想添加任何东西，它需要放在堆栈上。EVM 被称为堆栈机或堆栈状态机，其中我们将要使用的大多数操作都将把东西放在一个叫做堆栈的东西上，然后把东西从上面拉下来。

Now the stack is going to be the main data structure that we work with when it comes to working with Ethereum. And you can think of it literally as a stack, like a stack of pancakes or a stack of books. Whenever we have an object on the stack, if we push something to the stack, that's when we basically drop it from the top and stick it to the top of the stack. If we want to add a new item to the stack, well, guess what? Same thing. We got to bring it to the top and drop it onto the top of the stack.

现在，堆栈将是我们在使用以太坊时使用的主要数据结构。你可以将其字面上理解为一个堆栈，例如一堆煎饼或一堆书。每当我们在堆栈上有一个对象时，如果我们将某些东西推入堆栈，那时我们基本上从顶部放下它并将其放在堆栈的顶部。如果我们想向堆栈添加一个新项目，那么，猜猜怎么着？同样的事情。我们必须将其带到顶部并将其放到堆栈的顶部。

Now we have an item on the bottom of the stack and an item on top of this object on the stack. If we wanted to get the value in here, let's say this was some seven, let's say this was a hundred. If we wanted to get to this seven, we would need to first pull off the 100 and then pull off the seven. This is how the EVM works. And this is how we're going to do most operations. So whenever we see any of these opcodes that we're going to be learning about, we can kind of visually represent what they're doing with an object that looks like this.

现在我们在堆栈的底部有一个项目，堆栈上此对象的顶部有一个项目。如果我们想获得此处的价值，假设这是某个 7，假设这是 100。如果我们想得到这个 7，我们需要首先拉下 100，然后拉下 7。这就是 EVM 的工作方式。这就是我们将进行大多数操作的方式。因此，每当我们看到我们将要学习的任何这些操作码时，我们可以用视觉方式表示它们正在做什么，使用看起来像这样的对象。

So most of what we're going to be doing is on the stack. Now, the other two important places that we can put and do stuff is going to be memory and storage. Now, unlike the stack where you have to pull things on and off one at a time, memory, you can really stick any variable, any place that you want. And at the end of your transaction, everything in there goes away. Storage kind of works the same. You can think of it as a giant array where we can stick data wherever we want, whenever we want.

因此，我们将要做的绝大多数事情都在堆栈上。现在，我们可以放置和执行操作的另外两个重要位置是 memory 和 storage。现在，与堆栈不同，在堆栈中，你必须一次拉入和拉出一个东西，memory，你可以真正地粘贴任何变量，任何你想要的地方。在你的交易结束时，其中的所有内容都会消失。Storage 的工作方式类似。你可以把它想象成一个巨大的数组，我们可以把数据放在任何我们想放的地方，无论何时我们想放。

And when the transaction completes, storage persists. However, as we know, as we've learned before, anytime we interact with storage, it's going to be incredibly expensive. We go to our opcodes, the S-store opcode, which saves a word to storage, costs substantially more than our M-store opcode, which saves a word to memory. M-store, minimum of 3. S-store, minimum of 100. So storage is always going to be a lot more expensive. But these are going to be the main places we can work with data.

当交易完成时，storage 会持久存在。然而，正如我们所知，正如我们之前学到的，任何时候我们与 storage 交互，它都会非常昂贵。我们来看一下我们的操作码，S-store 操作码，它可以保存一个 word 到 storage 中，它的成本比 M-store 操作码高得多，M-store 操作码将一个 word 保存到 memory 中。M-store，最低 3 个 gas。S-store，最低 100 个 gas。所以 storage 总是会贵很多。但这些将是我们处理数据的主要场所。

You can think of memory like a giant array. You think of storage like a giant array that persists after the transaction completes. And the stack is literally a stack of pancakes. And the stack is where we're going to do most of our stack computation and most of our operations. So anytime you want to add stuff, you want to subtract stuff, you want to do anything, you have to do it in the stack. There's sometimes we have to do some stuff in memory and we'll point those out when we get to them.

你可以把 memory 想象成一个巨大的数组。你可以把 storage 想象成一个巨大的数组，它在交易完成后仍然存在。而 stack 实际上就是一叠煎饼。stack 是我们将进行大部分计算和大部分操作的地方。所以任何时候你想添加东西，你想减少东西，你想做任何事情，你都必须在 stack 中进行。有时我们必须在 memory 中做一些事情，当我们遇到它们时，我们会指出来。

Now, like we said, there are a couple other places you can actually store data and work with stuff. But for the most part, just think stack, memory or storage. That's where stuff is. That's where data is going to go. And all of these opcodes, all they essentially do is do stuff to the stack, memory and storage. That's basically it with the stack being the most important piece. In fact, right at the top of all these opcodes, you can see this little stack input and stack output.

现在，就像我们说的，还有其他几个地方你可以实际存储数据和处理东西。但在大多数情况下，只需考虑 stack、memory 或 storage。东西就在那里。数据将放在那里。所有这些操作码，它们本质上所做的就是对 stack、memory 和 storage 进行操作。基本上就是这样，其中 stack 是最重要的部分。事实上，在所有这些操作码的顶部，你可以看到这个小的 stack 输入和 stack 输出。

Most opcodes say okay, A is going to be the top of the stack, B is right underneath the stack. And what the add opcode is going to do, it's going to take the A opcode plus the B opcode and then return on top of the stack A plus B. So if we have a stack here, and we want to use the add opcode, we would need to have two stuff on the stack. Well, in order to get stuff on the stack, we actually need to use a push opcode.

大多数操作码都说，好的，A 将是 stack 的顶部，B 就在 stack 的下面。操作码将要做的是，它将获取 A 操作码加上 B 操作码，然后在 stack 的顶部返回 A 加 B。所以如果这里有一个 stack，并且我们想使用 add 操作码，我们需要在 stack 上放两个东西。为了把东西放到 stack 上，我们实际上需要使用 push 操作码。

And there's a whole bunch of push opcodes here. The push opcode has a push and then the number of bytes you want to place in the stack, except for push zero, which always pushes zero onto the stack. So let's say we called push one with a value of 0x01. What we would do is we would push one onto the stack. And now this is on our stack with a value of one. Remember, we're always going to be working with hex data. So 0x01 is going to equal one.

这里有很多 push 操作码。push 操作码有一个 push，然后是你想要放在 stack 中的字节数，除了 push zero，它总是将零推到 stack 上。假设我们用 0x01 的值调用 push one。我们要做的就是将 1 推到 stack 上。现在它就在我们的 stack 上，值为 1。记住，我们总是要处理十六进制数据。所以 0x01 等于 1。

Now let's say we called push again with push one. So we're going to push one byte code on and then instead we do 0x03, which is going to equal three. So now we have three on top of the stack and one right underneath it. If we came along and said okay, we want to now do the add opcode, what's going to happen is our add opcode is going to look at the top of the stack and right underneath the stack and say, okay, we're going to add three plus one. And the resulting value on the stack is going to be what the addition of them is.

现在假设我们再次调用 push，使用 push one。所以我们将推送一个字节码，然后改为我们做 0x03，它将等于 3。所以现在我们在 stack 的顶部有 3，在它下面有 1。如果我们过来并说，好的，我们现在想做 add 操作码，将会发生的是我们的 add 操作码将查看 stack 的顶部和紧挨着的下面 stack，然后说，好的，我们将加 3 加 1。stack 上的结果值将是它们的加法结果。

So you can almost think of them being pulled off, our little add code going, okay, three plus one is four. So we're going to do four here, four, boop, and now stick that on the stack. If this is what our stack looked like, we had four, maybe three at the bottom, maybe one here, and we called the add opcode. Remember, it only applies to the two top on the stack. So essentially it would say, okay, let's take these. One plus four is five. So now the data here is going to be five. Let's stick that back on the stack.

所以你几乎可以认为它们被拉下来了，我们的小 add 代码说，好的，3 加 1 是 4。所以我们在这里做 4，4，噗，现在把它放在 stack 上。如果这是我们的 stack 的样子，我们有 4，也许底部有 3，这里可能有 1，我们调用了 add 操作码。记住，它只适用于 stack 上最上面的两个。所以本质上它会说，好的，让我们拿走这些。1 加 4 是 5。所以现在这里的数据将是 5。让我们把它放回 stack 上。

And after an add opcode works, this is what it will look like. So that's an example of working with two really important opcodes, the push opcode and the add opcode. Push is going to stick stuff into the stack. Add is going to take stuff off the stack and combine them. And you can read all the different inputs and stack outputs in EVM.Codes. They do a great job of that as well. And we'll see in a little bit how opcodes like mstore and sstore take stuff off the stack, but then stick stuff into memory as a result of what's on the stack.

在 add 操作码工作之后，它会是这个样子。所以这是一个使用两个非常重要的操作码的例子，push 操作码和 add 操作码。Push 将把东西放入 stack 中。Add 将从 stack 中取出东西并将它们组合起来。你可以在 EVM.Codes 中阅读所有不同的输入和 stack 输出。他们在这方面也做得很好。我们稍后会看到像 mstore 和 sstore 这样的操作码如何从 stack 中取出东西，然后将东西放入 memory 中，作为 stack 上内容的结果。

So we'll see that in a bit. How do we make this contract dispatch our calldata so that when we send a calldata telling it to update our horse numbers, it actually updates our horse numbers. Okay, let's continue doing that now. So we now know when somebody is going to call our horse store smart contract, they're going to call with something that might look like this, right? They're going to send it this giant lump of data.

所以我们稍后会看到。我们如何使这个合约分发我们的 calldata，以便当我们发送一个 calldata 告诉它更新我们的马匹数量时，它实际上更新了我们的马匹数量。好的，让我们现在继续这样做。所以我们现在知道当有人要调用我们的 horse store 智能合约时，他们会调用一些可能看起来像这样的东西，对吧？他们会发送给它这个巨大的数据块。

Let's find the function selector so we can route it to the code that actually updates the number of horses, which we haven't written yet, but we will. Now that we know that the EVM is a stack machine, and in order for us to do this function selector routing, we need to do some computation on the stack. Let's try to actually get this to work now. Now, just for this beginning part, I'm going to do two things. I'm going to have our little stack over here, and I'm going to push stuff onto the stack to make it a little bit more obvious what's actually going on.

让我们找到函数选择器，以便我们可以将其路由到实际更新马匹数量的代码，我们还没有编写，但我们会编写。现在我们知道 EVM 是一台 stack 机器，并且为了让我们进行这个函数选择器路由，我们需要在 stack 上进行一些计算。让我们现在尝试实际让它工作。现在，仅对于这开始的部分，我将做两件事。我将在这里有一个小 stack，并且我将把东西推到 stack 上，使它更明显实际发生了什么。

But the second bit here is we are going to do a little bit of magic just in the beginning of this main function to do this function dispatching, because there are a couple of opcodes that are going to be a little confusing the first time you look at them. Once again, stick with me. I promise this will make sense as we go back over it. So the first thing that we want to do is we actually want to push zero onto the stack to do some stuff later.

但这里的第二点是我们将做一个小小的技巧，就在这个 main 函数的开头来进行这个函数分发，因为有一些操作码在你第一次看到它们时会有点令人困惑。再一次，跟着我。我保证当我们回顾它时，这会有意义的。所以我们想做的第一件事是我们实际上想要将零推到 stack 上，以便稍后做一些事情。

So typically, to do that, you would have the push zero opcode, which would literally just push zero onto the stack, boop, like this. In Huff, Huff is actually smart enough to know that if you just do 0x00 like this, it's smart enough to say, oh, okay, this is the push zero opcode, and they want to push zero on the stack. And similarly, if I wanted to do like push 1 0x01, if I want to push one byte onto the stack with the value 0x01, I wouldn't even need to have the push one opcode in Huff.

所以通常，要做到这一点，你会有 push zero 操作码，它会直接将零推到 stack 上，噗，像这样。在 Huff 中，Huff 实际上足够聪明，知道如果你只是像这样写 0x00，它足够聪明，会说，哦，好的，这是 push zero 操作码，他们想要将零推到 stack 上。类似地，如果我想做像 push 1 0x01 这样的操作，如果我想用值 0x01 将一个字节推到 stack 上，我甚至不需要在 Huff 中使用 push one 操作码。

Huff is smart enough to know that if I put 0x01, they know that I mean push one 0x01. Because obviously, this is one byte long. If I did this, it would be smart enough to make that push two because this is of course two bytes long. So when doing push opcodes in Huff, you just need to put the actual value that you want to push onto the stack. So in our Huff now, when somebody calls this smart contract, and when somebody sends any calldata to this smart contract, the only thing this smart contract will do right now is push zero onto the stack. That's it.

Huff 足够聪明，知道如果我放 0x01，他们知道我的意思是 push one 0x01。因为很明显，这是一个字节长。如果我这样做，它会足够聪明，把它变成 push two，因为这当然是两个字节长。所以在 Huff 中进行 push 操作码时，你只需要放入你想要推到 stack 上的实际值。所以在我们的 Huff 中，现在当有人调用这个智能合约，并且当有人向这个智能合约发送任何 calldata 时，这个智能合约现在将做的事情是将零推到 stack 上。就是这样。

And in fact, we can even compile this with Huff C, SRC, Horstor V1, Horstor.Huff. And let's add the binary. And we can see our code is a little longer than just the contract creation bytecode now. Now, after the F3, after that contract creation code, we now have this 5F, which if we go back to EVM.Codes, 5F is indeed it's the push zero opcode. So we can see just by adding this push zero opcode in our Huff, we've added the 5F opcode.

事实上，我们甚至可以用 Huff C, SRC, Horstor V1, Horstor.Huff 编译它。让我们添加二进制文件。我们可以看到我们的代码比合约创建字节码长一点。现在，在 F3 之后，在合约创建代码之后，我们现在有这个 5F，如果我们回到 EVM.Codes，5F 确实是 push zero 操作码。所以我们可以看到，仅仅通过在我们的 Huff 中添加这个 push zero 操作码，我们就添加了 5F 操作码。

And now there's a 5F added into our smart contract. This means that once again, since this is our main function, and since it's the first, anytime anybody says any data to the smart contract, we just push zero onto the stack. That's it. So this doesn't do anything yet, except for push zero on the stack. But cool. So we're already starting to code with pure opcodes. Very exciting. Okay, what next? Okay, well, somebody is going to send us some calldata, right? And they're going to have the function selector embedded in the call data.

现在我们的智能合约中添加了一个 5F。这意味着，再一次，因为这是我们的主函数，并且因为它是第一个被调用的函数，任何时候有人向智能合约发送任何数据，我们只是将零压入堆栈。就是这样。所以这段代码目前什么都不做，除了将零压入堆栈。但是很酷。所以我们已经开始用纯操作码进行编码了。非常令人兴奋。好的，下一步是什么？好的，那么，有人会向我们发送一些 calldata，对吧？他们会将函数选择器嵌入到 calldata 中。

So we want to actually get their calldata. And to do to get this first chunk, we're going to need to do some operations, right? We're gonna need to say, hey, give me the calldata, but like only the first four bytes. So to do any type of operations, what do we do? You guessed it, we got to stick it on the stack. And I want you to keep that in mind. Anytime you want to do any operations, you got to stick it on the stack.

所以我们实际上想要获取他们的 calldata。为了获取第一块数据，我们需要做一些操作，对吧？我们需要说，嘿，给我 calldata，但是只需要前四个字节。所以要进行任何类型的操作，我们该怎么做？你猜对了，我们必须把它放到堆栈上。我希望你记住这一点。任何时候你想做任何操作，你都必须把它放到堆栈上。

So if we go back to our evm.codes, we can look for calldata load. And this is the opcode that actually loads our calldata onto the stack. So you can even read it in evm.codes. So what it's going to do is it's going to take a stack input and give a stack output. And the stack input of calldata load is why we actually pushed the zero onto the stack in the first place. So what calldata load is going to do is it's going to look at the calldata, and it's going to grab whatever value is at the top of the stack and use this as the bytes offset.

所以如果我们回到 evm.codes，我们可以查找 calldata load。这正是将 calldata 加载到堆栈上的操作码。所以你甚至可以在 evm.codes 中阅读它。所以它将要做的是它会接受一个堆栈输入并给出一个堆栈输出。calldata load 的堆栈输入就是为什么我们实际上首先将零压入堆栈的原因。所以 calldata load 将要做的是它会查看 calldata，并且它会获取任何位于堆栈顶部的值，并将其用作字节偏移量。

So if this was one, if we pushed one onto here, what our calldata load would do is it would look at our calldata and go, okay, I'm going to load this calldata, but I'm going to ignore the first byte and start from here. We don't want it to ignore the first byte because that first byte includes part of the function selector. So as of now, here's what our stack looks like. And usually when I'm coding, I like to visualize the stack in comments as well.

所以如果这是 1，如果我们在这里压入 1，那么我们的 calldata load 会做的是它会查看我们的 calldata 并说，好的，我要加载这个 calldata，但我会忽略第一个字节并从这里开始。我们不希望它忽略第一个字节，因为第一个字节包含函数选择器的一部分。所以到目前为止，这就是我们的堆栈的样子。通常，在编码时，我也喜欢在注释中可视化堆栈。

So if I have 0x0, 0x0, which pushes zero to the stack, I also like to do these comments where I have like a little brackets and like a zero in here, which says, okay, at the bottom of our stack is zero. So this little comment here and this image are supposed to represent the same thing. If I were to add like 0x02, I would then do something like this, where I would say two comma zero, where the left side is going to be the top of the stack and the right side is going to be the bottom of the stack.

所以如果我有 0x0, 0x0，它会将零压入堆栈，我也喜欢做这些注释，我在注释中有一个小括号，里面有一个零，表示，好的，在我们堆栈的底部是零。所以这里的小注释和这个图像应该表示相同的事情。如果我要添加像 0x02 这样的东西，那么我会做一些事情像这样，我会说 2 逗号 0，其中左边是堆栈的顶部，而右边是堆栈的底部。

As a stack image over here, that would look like this. So I'm going to keep this commented out for now, but as I'm coding along, this is how in the comments in your code, you can also keep track of what the stack looks like. So I'm going to delete that for now. So since we have zero on the stack right now, when we do the calldata load opcode, and this is how you do it in Huff, you literally just write the name of it. It's just going to put the calldata right onto the stack starting from the zero with byte.

作为这里的堆栈图像，它看起来会像这样。所以我现在将保持注释状态，但是当我沿着编码时，这就是在代码的注释中，你也可以跟踪堆栈的样子。所以我现在要删除它。所以既然我们现在在堆栈上有零，当我们执行 calldata load 操作码时，这就是你在 Huff 中执行它的方式，你只需写下它的名字。它只是将 calldata 直接放到堆栈上，从第零个字节开始。

So it's going to add the entire calldata right onto the stack. And you might be confused, you might be saying, hey, we replaced the zero with the calldata. Like why, why do we do that? Well, what happened was we had this calldata, we have this calldata that's being sent to our smart contract. And we called the calldata opcode. And what it did was it says, okay, let's pop off this zero. And let's stick this calldata on starting from the zero with since if you start from the zero with byte, that's just all the calldata, we just said, okay, we've popped off the zero.

所以它会将整个 calldata 添加到堆栈上。你可能会感到困惑，你可能会说，嘿，我们替换了 calldata 中的零。像为什么，我们为什么要这样做？好吧，发生的事情是我们有这个 calldata，我们有这个发送到我们智能合约的 calldata。我们调用了 calldata 操作码。它所做的是它说，好的，让我们弹出这个零。让我们从第零个开始粘贴这个 calldata，因为如果你从第零个字节开始，那就是所有的 calldata，我们只是说，好的，我们已经弹出了零。

And now all that's on the stack is the calldata is this big, big thing right here. So cool. Now we have the whole calldata onto our stack here. Great. What's next? Next is the hard part. And if you don't understand this part, that's totally okay. Because what we need to do is we need to lop off all of this, right? Because just this is our function selector. So how do we cut down the calldata to just the function selector, we have this huge, huge, huge thing. And we only want this.

现在堆栈上所有的是 calldata，是这个大东西。太酷了。现在我们这里有整个 calldata 在我们的堆栈上。太棒了。下一步是什么？接下来是困难的部分。如果你不理解这部分，那完全没问题。因为我们需要做的是我们需要去掉所有这些，对吧？因为只有这个是我们的函数选择器。那么我们如何将 calldata 减少到只有函数选择器，我们有这个巨大的东西。我们只想要这个。

How do we cut it down, there must be an opcode that will help us do this pretty easily. So there's a lot of approaches we can take to do this. But one of the easiest and most efficient ones is going to be this SHR. This is where we're going to shift the bits towards the least significant one. And to do this, you need two values on the stack, you need a shift number of bits to shift to the right, and the value, the 32 bytes that you want to shift.

我们如何减少它，必须有一个操作码可以帮助我们轻松地做到这一点。所以我们可以采取很多方法来做到这一点。但是最简单和最有效的方法之一将是这个 SHR。在这里，我们将把这些位向最低有效位移动。要做到这一点，你需要堆栈上的两个值，你需要一个要向右移动的位数，以及该值，你要移动的 32 个字节。

So this SHR is the right shift for bits. But for the SHR opcode, let's say this is our text, this is our hex here. 0x01021. So this is in bytes, of course, right? Each two of these, oh, excuse me, let's get rid of that one. This is a byte and this is a byte. And as we know, one byte equals eight bits. So the shift opcode is how many bits to shift to the right.

所以这个 SHR 是位右移。但是对于 SHR 操作码，假设这是我们的文本，这是我们的十六进制。0x01021。所以这当然是以字节为单位的，对吧？每两个，哦，对不起，让我们去掉那个。这是一个字节，这是一个字节。我们知道，一个字节等于八位。所以 shift 操作码是要向右移动多少位。

So if we look at this as being two sets of eight bits, we can actually rewrite this. You can use cast if we want, we do cast dash dash two base, grab this and say bin for binary. And boom, this is it in bits or in its binary. We go 1, 2, 3, 4, 5, 6, 7, 8. This first part represents the 02. And this one over here represents the 01. Right? If I change this to like an F1, we're going to see we're going to get a much different value.

所以如果我们把这个看作是两组八位，我们实际上可以重写它。如果需要，可以使用 cast，我们执行 cast --to-base，抓住这个并说 bin 表示二进制。这是它以位或二进制形式表示的。我们数 1, 2, 3, 4, 5, 6, 7, 8。第一部分代表 02。这边这个代表 01。对吧？如果我把它改成 F1，我们会看到我们会得到一个非常不同的值。

0xf102 with, it's going to be a lot bigger, obviously, because that F1 is now going to use all eight bits. So 1, 2, 3, 4, 5, 6, 7, 8. Boom. This is the 02 and this is going to be the F1. Okay. Hopefully you're following along with me. If you're not following along with me, play with this cast to base between bin, deck and hex. So this is the hex. This is the bin. And then what was deck? Deck 6,100, whatever, right? That's the decimal equivalent of that binary.

0xf102，它会大得多，很明显，因为 F1 现在将使用所有八位。所以 1, 2, 3, 4, 5, 6, 7, 8。砰。这是 02，这将是 F1。好的。希望你跟着我。如果你没有跟着我，请使用这个 cast 命令在 bin、deck 和 hex 之间进行转换。所以这是十六进制。这是二进制。那么 deck 是什么？Deck 6,100，随便什么，对吧？那是该二进制的十进制等效值。

Anyways. So this is the binary representation of this hex. So if we say this is the value that we want to shift and we want to shift it by two, well, what are we going to get? Well, we're going to shift off these two values here and shift everything else to the right. So now this is going to be our value. 1, 2, 3, 4, 5, 6, 7, 8. This is going to be what's left. And we can pull up cast and see what this is in both hex and in decimals.

无论如何。所以这是这个十六进制的二进制表示。所以如果我们说这是我们想要移动的值，并且我们想要将其移动两位，那么我们将得到什么？好吧，我们将在这里移出这两个值，然后移动其他所有内容向右。所以现在这将是我们的值。1, 2, 3, 4, 5, 6, 7, 8。这将是剩下的。我们可以调出 cast，看看这是什么十六进制和十进制。

And we'll put a 0B at the front of this to tell cast this is a binary. But if we take this and we do cast, you can actually do dash dash to base, or you can actually just do to base, paste this in with the 0B to tell Foundry it's a binary. And we say hex, we get resulted with 0x40, which again, if we do the decimal, we get 64. So if we shift over two bits, 0, 0, 1, 2, excuse me, we shift over two bits, we get 0x40.

我们将在其前面放置一个 0B，以告诉 cast 这是一个二进制。但是如果我们采用这个并执行 cast，实际上可以执行 --to-base，或者实际上可以直接执行 to-base，粘贴这个，并在其中包含 0B，以告诉 Foundry 这是一个二进制。我们说 hex，我们得到的结果是 0x40，如果再次我们执行十进制，我们得到 64。所以如果我们右移两位，0，0，1，2，不好意思，我们右移两位，得到 0x40。

Let's shift over two more bits, right? So let's go, let's do four bits, right? So that would be two more. Copy this, do the same thing, paste it in, decimal is going to be 16. The hex is going to be 0x10. So what this right shift does is it just pushes the whole thing to the right, a number of bits until we're left with whatever's left over. We can actually validate if we did this correct in our heads, right?

让我们再右移两位，好吗？所以我们来，我们做四位，好吗？所以这将是再加两个。复制这个，做同样的事情，粘贴进去，十进制将是 16。十六进制将是 0x10。所以这个右移的作用就是将整个东西向右推，若干位，直到我们剩下剩余的东西。我们实际上可以验证一下，看看我们是否在脑海中做对了，对吧？

So we had this 0x012. Let's say we have the 0x012, we want to push it by four, we said we got what? We got 16. We can actually see that this is correct by trying this out right in our even.codes.playground. So there's this playground tab here where you can actually switch to playing with YUL, Solidity, byte codes, and then opcodes as well. So we're going to go to mnemonic because that's going to be opcodes.

所以我们有这个 0x012。假设我们有 0x012，我们想把它推四位，我们说我们得到了什么？我们得到了 16。我们实际上可以通过尝试来验证这是正确的，就在我们的 even.codes.playground 中。所以这里有一个 playground 标签，你可以在这里切换到使用 YUL、Solidity、字节码，以及操作码。所以我们要去 mnemonic，因为它将是操作码。

SHR needs a value and then a shift. So shift needs to be the top of the stack. So first thing we need to do is we need to push, push two, this onto our stack, right? So we're going to push this onto our stack so that this is now it's on the stack. Then we need to push one, four. So we're going to push this onto the stack. We're going to push four onto the stack. And then we're going to do a right shift.

SHR 需要一个值，然后是一个 shift。所以 shift 需要在堆栈的顶部。所以我们需要做的第一件事是我们需要 push，将 two，这个 push 到我们的堆栈上，对吧？所以我们要把这个 push 到我们的堆栈上，这样这个现在它就在堆栈上了。然后我们需要 push one，four。所以我们要把这个 push 到堆栈上。我们要把 four push 到堆栈上。然后我们要做一个右移。

So when we do this, so when we do this playground here, what's going to happen is we're going to push 0x0102 onto the stack. Then we're going to push 0x04 onto the stack. Then we're going to call SHR, which is going to shift this to the right by four. And what we're going to be left with is poof, this value shifted to the right by four. So let's see what this looks like when we actually run this in our playground here.

所以当我们这样做，所以当我们在这里做这个 playground 时，将会发生的是，我们将把 0x0102 push 到堆栈上。然后我们将把 0x04 push 到堆栈上。然后我们将调用 SHR，它将把这个向右移动四位。我们将剩下的是，这个值向右移动了四位。所以让我们看看当我们实际在我们的 playground 中运行它时会是什么样子。

If we click run, and we zoom out just a hair, we have our opcodes up here. And down here, we'll have our stack storage, etc. So there's not really a way for me to keep both in frame at the same time. But I guess we'll, we'll have to make do here. So if I want to step into this, we can go opcode by opcode. So first, let's do the push to 0102. Boom, step into it. After that executes, we scroll down here, we now see 102 is now on the stack.

如果我们点击运行，然后稍微缩小一点，我们这里有我们的操作码。在下面，我们将有我们的堆栈存储等等。所以实际上我没有办法同时将两者都放在画面中。但我想我们必须在这里凑合一下。所以如果我想单步执行，我们可以逐个操作码地执行。所以首先，让我们执行 push 到 0102。砰，单步执行。执行完之后，我们向下滚动，我们现在看到 102 现在在堆栈上。

So now we're going to push. Oops, excuse me, this should be push 0x04. Push 0x04. Sorry, let's run that again. 0102. Great. Now we're going to push 10x04. Okay, let's run that. Okay, great. Now our stack has 0x04 at the top and 0x0102 at the bottom of the stack. Based off our calculations here, we should return 16. So now let's go ahead and step into it. We get 10 on the stack. And this is the hex here.

所以现在我们要 push。哎呀，不好意思，这应该是 push 0x04。Push 0x04。抱歉，让我们再运行一次。0102。太棒了。现在我们要 push 10x04。好的，让我们运行它。好的，太棒了。现在我们的堆栈顶部有 0x04，底部有 0x0102。根据我们这里的计算，我们应该返回 16。所以现在让我们继续单步执行。我们在堆栈上得到 10。这是这里的十六进制。

So if we do cast to base 0x10 decimal, we see we do indeed get 16. So our math here is right. And we've learned how a right shift with all of our bits works. Now, when we do this calldata load opcode, the calldata load can only put 32 bytes onto the stack. So if this is our calldata, again, we have 1, 2, 3, 4, 5, 6, 7, 8, 9, 10. 1, 2, 3, 4, 5, 6, 7, 8, 9, 20. 1, 2, 3, 4, 5, 6, 7, 8, 9, 30. 1, 2, 3, 4, 5, 6, 7, 8, 9, 40. 1, 2, 3, 4, 5, 6, 7, 8, 9, 50. 1, 2, 3, 4, 5, 6, 7, 8, 9, 60. 1, 2, 3, 4, 64.

所以如果我们转换为 0x10 十进制，我们看到我们确实得到了 16。所以我们这里的数学是正确的。我们已经了解了右移是如何处理所有位的。现在，当我们执行这个 calldata load 操作码时，calldata load 只能将 32 字节放入堆栈。所以如果这是我们的 calldata，我们再次有 1, 2, 3, 4, 5, 6, 7, 8, 9, 10。1, 2, 3, 4, 5, 6, 7, 8, 9, 20。1, 2, 3, 4, 5, 6, 7, 8, 9, 30。1, 2, 3, 4, 5, 6, 7, 8, 9, 40。1, 2, 3, 4, 5, 6, 7, 8, 9, 50。1, 2, 3, 4, 5, 6, 7, 8, 9, 60。1, 2, 3, 4, 64。

These little numbers divided by two since every two numbers is a byte is going to be 32. So this is 32 bytes. And when we call our calldata load, it actually puts this onto the stack, not the entire calldata. So these last couple of bytes are actually truncated. If we wanted to include these, when we actually call the call data, we would increase the offset, right? We would increase the offset so that we could get this.

这些小数字除以二，因为每两个数字是一个字节，所以是 32。所以这是 32 字节。当我们调用我们的 calldata load 时，它实际上将这个放入堆栈，而不是整个 calldata。所以最后几个字节实际上被截断了。如果我们想包含这些，当我们实际调用 call data 时，我们会增加偏移量，对吧？我们会增加偏移量，以便我们可以得到这个。

But so when we call calldata, we only do 32 bytes on the stack. And the reason we're going to do this right shift is because we only want this. We don't want any of this. So what we can do is we can say, hey, let's right shift this whole thing, push it all the way to the right so that this is all that's left. Let's do that. Now that we've learned how the right shift works. Anyways, back over here, we've just put our calldata onto the stack.

但是当我们调用 calldata 时，我们只在堆栈上执行 32 字节。我们要做这个右移的原因是因为我们只想要这个。我们不想要任何这些。所以我们可以说，嘿，让我们把整个东西右移，把它一直推到右边，这样就只剩下这个了。让我们这样做。现在我们已经了解了右移是如何工作的。无论如何，回到这里，我们刚刚把我们的 calldata 放入堆栈。

So now our calldata is on the stack. Our calldata looks like this. We want to shift this so that we only get the function selector so we can finally start doing our dispatch. So what we want to do is again, back in our right shift opcode, we want to get on the stack, the value we shift want to shift and the amount we want to actually shift it. So we have at the bottom of our stack, the value we want to shift, right? We want to shift our calldata all the way to the right.

所以现在我们的 calldata 在堆栈上。我们的 calldata 看起来像这样。我们想要移动这个，以便我们只得到函数选择器，这样我们才能最终开始做我们的分发。所以我们要做的是再次回到我们的右操作码，我们想要在堆栈上得到，我们想要移动的值和我们实际想要移动的量。所以我们在堆栈的底部有我们想要移动的值，对吧？我们想要把我们的 calldata 一直向右移动。

So how much do we want to shift it? This is going to be the first 32 bytes of calldata is going to be on the stack, right? So this is the calldata or at least the 32 bytes. And remember, since it's only the first 32 bytes, we don't need to worry about this over here. So we're going to need to cut this down to just this. We're going to need to shift all of this to the right. So let's do a little bit of counting again. 1, 2, 3, 4, 5, 6, 7, 8, 9, 10. 1, 2, 3, 4, 5, 6, 7, 8, 9, 20. 1, 2, 3, 4, 5, 6, 7, 8, 9, 30. 1, 2, 3, 4, 5, 6, 7, 8, 9, 40. 1, 2, 3, 4, 5, 6, 7, 8, 9, 50. 1, 2, 3, 4, 5, 6.

那么我们想要移动多少呢？这将是 calldata 的前 32 个字节将在堆栈上，对吧？所以这是 calldata，或者至少是 32 个字节。记住，因为只有前 32 个字节，我们不需要担心这边的东西。所以我们需要把这个缩减到只有这个。我们需要把所有这些都向右移动。所以让我们再做一点计数。1, 2, 3, 4, 5, 6, 7, 8, 9, 10。1, 2, 3, 4, 5, 6, 7, 8, 9, 20。1, 2, 3, 4, 5, 6, 7, 8, 9, 30。1, 2, 3, 4, 5, 6, 7, 8, 9, 40。1, 2, 3, 4, 5, 6, 7, 8, 9, 50。1, 2, 3, 4, 5, 6。

So 56. So we need to right shift, shift 56. So let's do a little calculating here. 56 divided by 2. So that's 28 bytes, 28 bytes, or 28 times 8, since 1 byte is 8 bits, or 224 bits. So now there's a lot there. But that's what we need to do next. We need to do a right shift of 224 bits. So let's pull this up. Let's do cast to base 224 hex. That's 0xE0.

所以是 56。所以我们需要右移，移动 56。所以让我们在这里做一点计算。56 除以 2。所以那是 28 字节，28 字节，或者 28 乘以 8，因为 1 字节是 8 位，也就是 224 位。所以现在有很多东西。但这是我们接下来需要做的。我们需要右移 224 位。所以让我们把它拉起来。让我们转换为 224 十六进制。那是 0xE0。

So we need to do a push, push 1, 0xZ0. But since Huff is smart enough to know that it's just 0xZ0, boom, we can just do this. And now on our stack, on top of the calldata, we have 0xE0. Now that these two are on our stack, holy moly, we're finally about to do it. We have the number we want to shift on the top, right? 0xE0, we want to shift by that many bits. We have the thing that we want to actually shift, we can actually now do the SHR opcode to actually do this shift.

所以我们需要做一个 push，push 1，0xZ0。但由于 Huff 足够聪明，知道它只是 0xZ0，砰，我们可以这样做。现在在我们的堆栈上，在 calldata 之上，我们有 0xE0。现在这两个都在我们的堆栈上，天哪，我们终于要做了。我们有我们想要移动的数字在顶部，对吧？0xE0，我们想要移动那么多位。我们有了想要移动的东西，我们现在可以使用 SHR opcode 来进行移位。

So if I grab this, if we want to even boom, 0xE0, this is what it looks like now. Now we can run the SHR, which what this opcode is going to do is going to take this off, take this off and go, okay, you want to shift this to the right by this much. Great. Let's go ahead and do that. And we'll return on to the stack, just what's ever left, which is going to be our function selector. So we're going to shift by this many bits and all that's going to be left on the stack is that.

所以如果我抓住这个，如果我们想要，0xE0，现在它看起来是这样的。现在我们可以运行 SHR，这个 opcode 将会移除这些，然后说，好的，你想把这个向右移动这么多。很好。让我们开始做吧。我们会返回到堆栈上，只留下剩下的东西，也就是我们的函数选择器。所以我们将移动这么多位，堆栈上剩下的就是那些。

So now we can even just say function selector. And I know this seems like a lot, but really, right, this is just a few opcodes. It's 0x00, calldata load, 0xE0, and then a right shift. And just by doing that, we now get the function selector. So now we have the function selector on the stack. And once you have a function selector on the stack, you can now start to finally do some function dispatching. So great job. I know we've gone over a ton already here.

所以现在我们甚至可以直接说是函数选择器。我知道这看起来很多，但实际上，这只是一些 opcodes。它是 0x00，calldata load，0xE0，然后是一个右移。仅仅通过这样做，我们现在就得到了函数选择器。所以现在我们在堆栈上有了函数选择器。一旦你在堆栈上有了函数选择器，你就可以开始进行函数分发。做得好。我知道我们已经讲了很多了。

So let's do a little bit of a recap of what we learned so far. So first off, we learned a little bit more about the EVM. We learned that there's a lot of different places to store and manipulate data. We have a stack, which is going to be the main data structure we're going to be working with. We've got memory, we've got storage, we've got gas all over the place. We even mentioned there was a program counter, gas available and some other stuff.

让我们来回顾一下我们目前所学的内容。首先，我们对 EVM 有了更多的了解。我们了解到有很多不同的地方可以存储和操作数据。我们有一个堆栈，这将是我们主要的数据结构。我们有内存，我们有存储，我们到处都有 gas。我们甚至提到有一个程序计数器，可用 gas 和其他一些东西。

We learned the stack is going to be the main data structure we're going to work with to manipulate data, where we can push data onto the stack, we can pop data off the stack, but we're always working with the top of the stack. The EVM is built into this list of opcodes, which essentially manipulates the stack, and also memory and storage, etc. We learned that when we're working with these opcodes, most of the time we're going to be doing stuff to manipulate data on the stack and store it into memory and store it into storage for one reason or another.

我们了解到堆栈将是我们用来操作数据的主要数据结构，我们可以将数据压入堆栈，也可以将数据从堆栈中弹出，但我们始终在处理堆栈的顶部。EVM 构建在这个操作码列表中，它主要操作堆栈，以及内存和存储等等。我们了解到，当我们使用这些操作码时，大部分时间我们都在做一些事情来操作堆栈上的数据，并将其存储到内存和存储中，原因各不相同。

In our Solidity smart contracts, whenever we send data to a smart contract, we actually send this thing called calldata. Solidity, intelligently enough, when it compiles, it compiles into opcodes that can understand calldata. When it gets calldata, one of the first things it has to do is look at this calldata and say, what would you like to do and get this function selector. Once you get the function selector, you can actually route the rest of the call to the function associated with the function selector.

在我们的 Solidity 智能合约中，每当我们向智能合约发送数据时，我们实际上发送的是一种叫做 calldata 的东西。Solidity 足够智能，当它编译时，它会编译成可以理解 calldata 的操作码。当它获取 calldata 时，它需要做的第一件事就是查看这个 calldata 并说，你想要做什么并获取这个函数选择器。一旦你获得了函数选择器，你就可以将剩余的调用路由到与函数选择器关联的函数。

We did this ourselves in raw opcodes in essentially Huff by first pushing zero onto the stack, the calldata 0xE0 and doing a right shift and then what that left us with was the function selector. Essentially, we took this calldata, lopped off the end here with our right shift and all we were left with was, boom, this function selector. Now that we have the function selector, we can use this to say, OK, it's time to route your call to the correct function.

我们自己在原始操作码中，本质上是在 Huff 中通过首先将零压入堆栈，calldata 0xE0 并进行右移，然后剩下的就是函数选择器。本质上，我们获取了这个 calldata，用我们的右移截断了末尾，剩下的就是，砰，这个函数选择器。现在我们有了函数选择器，我们可以用它来说，好的，是时候将你的调用路由到正确的函数了。

We don't have any of the functions defined yet, so obviously we're going to need to do that as well. Now, if we do a little Huff C, src for store or store.huff, oops, dash B, you should get this to compile and get an output like this. And for now, if you want to play with Huff, you can come to the evm.codes playground. Let's go to the playground here. Let me expand this. You can either do bytecode where you can literally stick the bytecode in here.

我们还没有定义任何函数，所以显然我们也需要这样做。现在，如果我们做一个小的 Huff C，src 代表 store 或 store.huff，哎呀，-B，你应该编译它并得到这样的输出。现在，如果你想玩 Huff，你可以来到 evm.codes playground。让我们去 playground。让我展开它。你可以使用 bytecode，你可以直接把 bytecode 放在这里。

You can do mnemonic where you can do opcodes, but this is a great place to play around with tinkering with opcodes. Foundry has a debug function as well that we're going to play with in a bit, but this is a great place to play with stuff. If you do copy paste the bytecode in here, just remember half of this is going to be the contract creation code. So if we look for this 39 opcode that we know that that's the code copy, this 3D I already know is actually return F3, excuse me, F3 is going to be returned.

你可以使用 mnemonic，你可以使用操作码，但是这里是一个玩转操作码的好地方。Foundry 也有一个 debug 函数，我们稍后会用到，但这是一个玩转的好地方。如果你把 bytecode 复制粘贴到这里，记住一半将是合约创建代码。所以如果我们寻找这个 39 操作码，我们知道那是代码复制，这个 3D 我已经知道实际上是返回 F3，对不起，F3 将被返回。

So I actually know that the runtime code starts here. And if I wanted to play with this, I could actually just put the runtime code that I created and we can actually see it does match what we coded. Push 0, calldata, push 1, E0, add. Oh, where'd the add come from? Oops. I forgot the C. Oh, okay. Whoops. I forgot the C. Yep. Okay. Right shift. Perfect. And we can see if we were to send this our call data, we're going to copy all this, stick it into here, get rid of those spaces.

所以我实际上知道运行时代码从这里开始。如果我想玩这个，我可以只放入我创建的运行时代码，我们可以看到它确实与我们编写的代码匹配。Push 0, calldata, push 1, E0, add。哦，add 从哪里来的？哎呀。我忘了 C。哦，好的。哎呀。我忘了 C。是的。好的。右移。完美。我们可以看到，如果我们发送这个调用数据，我们将复制所有这些，粘贴到这里，去掉那些空格。

Now we hit run. You can now walk through this line by line and we would see at the end on the stack would just be the function selector. So this is a great place to learn, to tinker and play around with working and learning about opcodes. All right. So let's keep going right now. We have the function selector on the stack. Huzzah! Now we want to route this call to the correct function.

现在我们点击运行。你现在可以逐行浏览，我们将会看到最后堆栈上只有函数选择器。所以这是一个学习、修改和玩转操作码的好地方。好的。让我们继续。我们在堆栈上有了函数选择器。万岁！现在我们想把这个调用路由到正确的函数。

In fact, when we call update horse numbers, it almost magically just knows what to do. When we're coding in byte codes, we actually need to tell it that is actually calling to update the numbers or read horse numbers. So we're going to take this function selector and we're going to do a couple of comparisons. We're going to say, okay, now that we have this function selector, we want to jump to the function data associated with the selector.

事实上，当我们调用 update horse numbers 时，它几乎神奇地知道该怎么做。当我们用字节码编码时，我们实际上需要告诉它实际上是在调用更新数字或读取马匹数量。所以我们将获取这个函数选择器，然后做一些比较。我们要说，好的，现在我们有了这个函数选择器，我们想要跳转到与该选择器关联的函数数据。

And in this contract, in this Huff, in this horse store, we've got two function selectors, update horse number and read number of horses. So we're basically going to say if the function selector equals update horse number, then jump to that code, which we haven't defined yet. And then if the F selector equals read the horse number, you know, jump to that code. So let's go ahead and do that. I'm going to get rid of the stack image for a bit, but I'll bring it back when I think it's necessary.

在这个合约中，在这个 Huff 中，在这个 horse store 中，我们有两个函数选择器，update horse number 和 read number of horses。所以我们基本上要说，如果函数选择器等于 update horse number，然后跳转到该代码，我们还没有定义它。然后如果 F 选择器等于 read the horse number，你知道，跳转到该代码。让我们开始做吧。我将暂时删除堆栈图像，但当我认为有必要时，我会把它带回来。

So let's do these comparisons. So we have these two function selectors, update horse number and read number of horses. So let's actually compute these with cast, right? So we can do cast sig, little parentheses, little quote, update horse number, uint256, like this. So this is going to be the function selector for update horse number. So this equals update. And then let's do the read as well. Cast sig, paste, oops, little quotes here, read number of horses. It's going to be this one. So this equals read.

让我们做这些比较。我们有两个函数选择器，update horse number 和 read number of horses。让我们用 cast 来计算这些。我们可以使用 cast sig，小括号，小引号，update horse number, uint256，像这样。这将是 update horse number 的函数选择器。所以这等于 update。让我们也做 read。Cast sig，粘贴，哎呀，这里有小引号，read number of horses。这将是这个。所以这等于 read。

So now that we have those, we're going to use these to basically check to see if the function selector matches one of these. We have an opcode that can actually check for matches in EVM .codes. In EVM.codes or in our opcodes. In our opcodes, there's one called EQ, which stands for basically equals. And what it's going to do, it's going to look at the top of the stack. It's going to say the left side integer and the right side integer.

现在我们有了这些，我们将使用它们来基本上检查函数选择器是否与其中一个匹配。我们有一个操作码可以在 EVM .codes 中检查匹配项。在 EVM.codes 中，或者在我们的操作码中。在我们的操作码中，有一个叫做 EQ 的，它基本上代表等于。它将要做的是，它将查看堆栈的顶部。它会比较左边的整数和右边的整数。

And it's going to return A equals B where it's going to return a one if the left side is equal to the right side and then zero otherwise. So if they match, it's going to be a one. If they don't match, it's going to be a zero. So what we can do now that we have this function selector on the stack already is we can push this, which is our update. So our update horse number selector onto the stack. And now on the stack is not just going to be the function selector, but it's going to be the update horse number function selector and then the function selector.

然后它会返回 A 等于 B 的结果，如果左边等于右边，则返回 1，否则返回 0。所以如果它们匹配，结果就是 1。如果它们不匹配，结果就是 0。现在我们已经有了这个函数选择器在堆栈上，我们可以做的是，我们可以推送这个，也就是我们的 update。将我们的 update horse number 选择器推送到堆栈上。现在堆栈上不仅有函数选择器，还有 update horse number 函数选择器，然后才是函数选择器。

And then we can do the equals. And this will be true if func selector matches. Boom, because it takes two inputs and returns one on the stack. So on the stack, there's these two inputs and returns true if they are the same. Now that we have whether or not it's true, we want to add a little jump opcode. We're going to say jump to update horse number code if true. And to do this, we actually have two opcodes that we can work with. We have a jump and we have a jump if.

然后我们可以进行相等比较。如果函数选择器匹配，这将为真。因为它接受两个输入，并在堆栈上返回一个结果。所以在堆栈上，有两个输入，如果它们相同，则返回 true。现在我们有了真假值，我们想要添加一个 jump 操作码。如果为真，我们将跳转到 update horse number 代码。为了做到这一点，我们实际上有两个操作码可以使用。一个是 jump，另一个是 jump if。

So the jump opcode just jumps to some other spot in the code. The jump I, which stands for jump if, will jump to some other spot in the code if some condition is met. So the stack input is going to be the counter or the byte offset in the deployed code where execution will continue from. And then B, which is going to be our true or false. So basically, if B is true or anything other than zero, jump to this new program counter.

jump 操作码只是跳转到代码中的其他位置。jump I，也就是 jump if，如果满足某个条件，将跳转到代码中的其他位置。所以堆栈输入将是计数器，或者已部署代码中的字节偏移量，执行将从该位置继续。然后是 B，这将是我们的真或假值。基本上，如果 B 为真或任何非零值，则跳转到此新的程序计数器。

So the program counter is not something we've we've spoken about, but the program counter is going to be the byte offset in the deployed code. Program counter can be a little bit confusing and a little bit tricky. So we're not going to go over too deep for now. And because Huff gives us some syntax to make it a little bit easier. But once we compile this, I'll show you what what I mean and it'll make a little bit more sense.

程序计数器不是我们讨论过的内容，但是程序计数器将是已部署代码中的字节偏移量。程序计数器可能有点令人困惑和棘手。所以我们现在不会深入探讨。因为 Huff 提供了一些语法，使它更容易一些。但是一旦我们编译了这个，我会向你展示我的意思，它会更有意义。

So we want to use this jump I, this jump if opcode to actually jump to the update code base, which, again, we haven't defined yet. So the way we're going to do that in Huff here is we're going to add the program counter to jump to. Right. Because the jump if opcode requires the program counter at the top of the stack and then the true false conditional. So we have the true false conditional. So we could either just do like manually add the program counter here.

所以我们想要使用这个 jump I，这个 jump if 操作码来实际跳转到 update 代码库，我们还没有定义它。所以我们要在 Huff 中这样做的方式是，我们将添加要跳转到的程序计数器。对。因为 jump if 操作码需要在堆栈顶部有程序计数器，然后是真假条件。所以我们有真假条件。所以我们可以手动在这里添加程序计数器。

But Huff has some nice syntax. We actually put some text here, which will define the program counter for a certain macro. So I'm going to do update jump. I'm going to just say update jump here. And what this is going to do now is on the stack, this update jump is going to have the update horse number program counter. And then, of course, the true false conditional. Before I finish doing this, I'm going to put down here this update jump and this colon and then this set number of horses.

但是 Huff 有一些很好的语法。我们实际上在这里放一些文本，它将定义某个宏的程序计数器。所以我将执行 update jump。我将在这里说 update jump。现在这将要做的是在堆栈上，这个 update jump 将具有 update horse number 程序计数器。当然，还有真假条件。在我完成此操作之前，我将在此处放置 update jump 和这个冒号，然后是 set number of horses。

I'm gonna explain all this in a second. And then down here, I'll do a little define macro set number of horses equals takes zero return zero just like this. Now, I just wrote a whole bunch of code, but let me explain it. So we put this update jump here. And what this update jump is, is since we have this conditional down here, we're basically saying, hey, this update jump keyword is going to refer to the program counter for set number of horses.

我稍后会解释所有这些。然后在下面，我将定义一个宏 set number of horses 等于 takes zero return zero，就像这样。现在，我写了一大堆代码，但让我解释一下。所以我们把这个 update jump 放在这里。这个 update jump 是，因为我们有这个条件在下面，我们基本上说，嘿，这个 update jump 关键字将引用 set number of horses 的程序计数器。

This syntax here is a little bit of Huff sugar. Update jump refers to the program counter for set number of horses wherever that ends up getting compiled to be. And right now, our set number of horses macro does nothing because we haven't done anything with it yet. But basically now we'll say jump if or jump I, which again is going to take our program number and true false. And so if this is true, if this is anything other than zero, we're going to jump here.

这里的语法有点像 Huff 的语法糖。Update jump 指的是 set number of horses 的程序计数器，无论它最终被编译成什么。现在，我们的 set number of horses 宏不执行任何操作，因为我们还没有对它做任何事情。但基本上现在我们会说 jump if 或 jump I，它再次将采用我们的程序编号和真假值。所以如果这是真的，如果这是任何非零的值，我们将跳转到这里。

Otherwise, we're not going to do anything. So once this jump if happens, we've got nothing left on the stack. And we can even run this again. We'll do we'll compile this. See what I do. Macro set number of horse horsey set number of horses. Let's do it now. And boom. And this is our output. Now, if we want to practice, if we want to run this over in the EVM codes playground, what we can actually do is we can make it even easier.

否则，我们将不做任何事情。所以一旦发生这个 jump if，我们的堆栈上就什么都不剩了。我们甚至可以再次运行它。我们将编译它。看看我做什么。宏 set number of horse horsey set number of horses。现在开始。砰。这是我们的输出。现在，如果我们想练习，如果我们想运行这个在 EVM 代码 playground 中，我们实际上可以做的是我们可以让它更容易。

We can do the Huff compiler and do dash dash bin runtime. And this will give us just the runtime code, which is great. So now if I paste this in here, we can see we can actually see pretty much exactly what we just coded in Huff in pure opcodes. We have push calldata, push right shift, right? This is getting the function selector. Then we have push, which is checking the update function selector. We have an equals.

我们可以使用 Huff 编译器并执行 dash dash bin runtime。这将只给我们运行时代码，这太棒了。所以现在如果我把它粘贴到这里，我们可以看到我们实际上可以看到我们刚刚在 Huff 中用纯操作码编写的代码。我们有 push calldata，push right shift，对吧？这是获取函数选择器。然后我们有 push，它正在检查 update 函数选择器。我们有一个 equals。

We push that that program counter and then we have a jump if and then importantly, we have a jump dest. So this is something we didn't talk about quite yet. So when you do these jump opcodes, they can only jump to a jump dest opcode in the code. So if it's not jump dest, you can't jump there. So the jump dest is an opcode, which literally just says, hey, this is a valid destination for jump or jump if.

我们推送程序计数器，然后我们有一个 jump if，然后重要的是，我们有一个 jump dest。这是我们还没有谈到的事情。所以当你执行这些 jump 操作码时，它们只能跳转到代码中的 jump dest 操作码。所以如果它不是 jump dest，你就不能跳转到那里。所以 jump dest 是一个操作码，它实际上只是说，嘿，这是一个 jump 或 jump if 的有效目标。

When we set this up, this update jump syntactical sugar, we're setting up, hey, set number of horses is now a valid jump destination. So we could have 100% we manually done this instead of using the Huff syntactic sugar, right? So what we could have done was we could have said, OK, 0x000F jump if and then had a jump dest down here where if this jump dest was at program counter 0xF, this would be a valid jump destination.

当我们设置这个 update jump 语法糖时，我们正在设置，嘿，set number of horses 现在是一个有效的跳转目标。所以我们可以 100% 手动完成此操作，而不是使用 Huff 语法糖，对吧？所以我们可以做的是我们可以说，好的，0x000F jump if，然后在下面有一个 jump dest，其中如果这个 jump dest 位于程序计数器 0xF，这将是一个有效的跳转目标。

So, but it's a little confusing to do that when writing in Huff. So this syntactic sugar just makes it a little bit easier just saying, hey, set this up as a jump destination. Update jump is going to be a valid jump destination. And we're going to and the code that's going to start there is going to be whatever code is in the macro set number of horses. So hopefully that makes sense. This is what it looks like when we actually compile it.

所以，但是在 Huff 中编写时这样做有点令人困惑。所以这个语法糖只是让它更容易一些，只是说，嘿，将此设置为跳转目标。Update jump 将是一个有效的跳转目标。我们将从那里开始的代码将是宏 set number of horses 中的任何代码。所以希望这有意义。这是我们实际编译它时的样子。

Obviously nothing is going to happen after the jump dest because we jump here. Boom. Nothing happens. So let's actually run this in our playground. Let's actually run this in our playground with some valid calldata in hex here. So if we want some valid calldata in hex, we would need to have this at the beginning of our calldata. Boom. And then we could put, you know, literally almost whatever else we wanted after it. We'll do run.

显然，在 jump dest 之后不会发生任何事情，因为我们跳转到这里。砰。什么都没发生。所以让我们在我们的 playground 中实际运行它。让我们在我们的 playground 中实际运行它，这里有一些有效的十六进制 calldata。所以如果我们想要一些有效的十六进制 calldata，我们需要在我们的 calldata 的开头有这个。砰。然后我们可以放，你知道，几乎任何我们想要的东西。我们将运行。

And if we walk through this, we should be able to jump because on the stack is F and true. And boom, we should hit the jump dest. Now, if we don't have the correct function selector, right, this equal will return false. So I just got rid of it in the calldata. I'm going to go ahead run now step, step, step, step, step. Once we get to this jump, if we have F and zero, so we have the jump destination, but we have false here instead of true.

如果我们逐步执行此操作，我们应该能够跳转，因为堆栈上是 F 和 true。砰，我们应该到达 jump dest。现在，如果我们没有正确的函数选择器，对吧，这个 equal 将返回 false。所以我刚刚在 calldata 中删除了它。我现在要运行 step, step, step, step, step。一旦我们到达这个 jump，如果我们有 F 和 zero，所以我们有跳转目标，但是我们这里有 false 而不是 true。

Now, if we enter the, we don't jump. However, we still go to the jump dest because that's next in line, right? So we basically just didn't jump and we went to next in line. I guess it's kind of confusing because, no matter what, if we jump or we don't jump, the next op code is the jump dest. So I guess that's, not a great example there, but in any case, good job. We have now successfully done a function dispatch for the update number of horses.

现在，如果我们输入，我们就不跳转。但是，我们仍然会跳转到 jump dest，因为那是下一个，对吧？所以我们基本上只是没有跳转，然后进入了下一个。我想这有点令人困惑，因为无论如何，如果我们跳转或不跳转，下一个操作码都是 jump dest。所以我想这不是一个很好的例子，但在任何情况下，干得好。我们现在已经成功地为更新马匹数量完成了函数分发。

Good job. But what if they aren't calling the update horse number? What if instead they're calling the read? What is it? The read number of horses read number of horses with this function selector. Okay. Well, that's easy. We just don't jump, right? No, no worries. Oh, but our, our stack has nothing on it right up here. If we don't jump, we now continue with our stack with nothing on it.

干得好。但是，如果他们没有调用更新马匹数量的函数呢？如果他们调用的是读取函数呢？那是什么？读取马匹数量，使用这个函数选择器。好的。嗯，这很简单。我们只是不跳转，对吧？不，不用担心。哦，但是我们的堆栈上面什么都没有。如果我们不跳转，我们现在继续使用一个什么都没有的堆栈。

Oh, well, that's kind of annoying. Well, no worries. We can just run this again and get the function selector again. So we can check to this one. We could 100% do that, but what's a lot easier and costs less gas is if once we get the function selector like this, before we do any checking, we actually duplicate it so that there's always a function selector on the stack. It costs less gas than doing all of these. It's one less opcode.

哦，好吧，这有点烦人。嗯，不用担心。我们可以再次运行它，再次获取函数选择器。所以我们可以检查这个。我们当然可以这样做，但是更简单且花费更少 gas 的方法是，一旦我们像这样获得函数选择器，在进行任何检查之前，我们实际上复制它，以便堆栈上始终存在一个函数选择器。这比做所有这些花费的 gas 更少。少一个操作码。

And this is where a lot of the optimizations from coding and Huff versus solidity sort of start to take shape. Solidity might not be as clever as you at doing some of these optimizations. Solidity, maybe it just goes, oh, OK, well, I'm just going to re get the function selector the way that I got it before. Whereas it might be a lot smarter if instead we just duplicated the function selector. So I'm going to add an opcode here. We're going to add the dupe one opcode. Oops.

这就是编码和 Huff 与 Solidity 之间的许多优化开始形成的地方。在进行某些优化时，Solidity 可能不如你聪明。Solidity，也许它只是说，哦，好吧，我只是要以我之前的方式重新获取函数选择器。相反，如果我们只是复制函数选择器，可能会更聪明。所以我要在这里添加一个操作码。我们将添加 dupe one 操作码。哎呀。

We go to EVM.codes. Let's see what dupe one does. It just duplicates the first item on the stack. The input, the top of the stack is going to be the value to duplicate. And then it sticks on top of that, the duplicated value. So now if I go back and I add this dupe one opcode, all of my comments now need to get updated. Right. So if we add dupe one here, thank you, chatGPT, we're now going to have function selector, function selector.

我们去 EVM.codes。让我们看看 dupe one 做什么。它只是复制堆栈上的第一个项目。输入，堆栈的顶部将是要复制的值。然后它将复制的值放在它的顶部。所以现在如果我回去并添加这个 dupe one 操作码，我现在所有的注释都需要更新。对。所以如果我们在添加 dupe one 在这里，谢谢 chatGPT，我们现在将拥有函数选择器，函数选择器。

And when we add this, the update function selector comparison, the stack is now going to look like boom, function selector, function selector. When we do equals, function selector is going to be underneath that. When we do the update jump, the function selector is going to be underneath that. And then when we do the jump, if the function selector is still going to be on the stack. So now if we don't jump, if we don't jump, we still have the function selector and we can just redo this process.

当我们添加这个，更新函数选择器比较时，堆栈现在看起来像 boom，函数选择器，函数选择器。当我们执行 equals 时，函数选择器将在其下方。当我们执行更新跳转时，函数选择器将在其下方。然后当我们执行跳转时，如果函数选择器仍然在堆栈上。所以现在如果我们不跳转，如果我们不跳转，我们仍然有函数选择器，我们可以重新执行此过程。

So typically you'll see this setup for checking for function selectors in Huff and actually in Solidity. They'll duplicate the function selector, check to see if it matches another function selector, jump and then do the same thing all over again. So we probably would if we had more function selectors to do one again. But since this is the last one, we can leave it off. So here we are.

因此，通常你会看到这种设置用于检查函数选择器，在 Huff 中，实际上在 Solidity 中也是如此。他们将复制函数选择器，检查它是否与另一个函数选择器匹配，跳转，然后再次执行相同的操作。因此，如果我们有更多的函数选择器，我们可能会再次执行一次。但由于这是最后一个，我们可以省略它。所以我们在这里。

So now we want to do the same thing, but for read number of horses, we can skip the dupe one because this is our last function selector. Right. So we have the function. We have the original calldata function selector on the stack. So what we want to do is we want to push the read calldata function selector on the stack. And now we have the read function selector and then the call data function selector. And we can do the same thing.

所以现在我们想做同样的事情，但是对于读取马匹数量，我们可以跳过 dupe one，因为这是我们的最后一个函数选择器。对。所以我们有这个函数。我们在堆栈上具有原始的 calldata 函数选择器。所以我们要做的是，我们要将读取 calldata 函数选择器推送到堆栈上。现在我们有了读取函数选择器，然后是调用数据函数选择器。我们可以做同样的事情。

Let's compare if they're the same. So we have now just true. If the function selector matches, we can now create a different jump destination. We'll call it read jump. And now on our stack, we're going to have the read jump and we're gonna have that true false conditional. I should probably do this to make it make more sense. And then after that read jump, we're going to do again a jump if and if this is true, we're going to jump to the read jump, which we want to go ahead and make a read jump destination.

让我们比较一下它们是否相同。所以我们现在只有 true。如果函数选择器匹配，我们现在可以创建一个不同的跳转目标。我们称之为 read jump。现在在我们的堆栈上，我们将拥有 read jump，我们将拥有 true false 条件。我应该这样做，使其更有意义。然后在 read jump 之后，我们将再次执行 jump if，如果这是 true，我们将跳转到 read jump，我们要继续创建一个 read jump 目标。

We'll call this one actually. Yeah. Thanks. Get number of horses down here. Define macro. Get number of horses equals takes zero turns zero like that. And the function selector isn't on here anymore. And that's fine because we only had two we wanted to compare to anyways. So already by learning Huff, you've learned how to make a more efficient function dispatcher than solidity.

我们实际上称这个为。是。谢谢。在这里获取马匹数量。定义宏。Get number of horses 等于 takes zero turns zero 像那样。函数选择器不再在这里了。这没关系，因为无论如何我们只有两个要比较。因此，通过学习 Huff，你已经学会了如何制作比 Solidity 更高效的函数分发器。

Because solidity will have an extra dupe opcode here, actually dupe one opcode, which is going to cost gas. So congratulations. You just leveled up just by doing this so far. So if we compile this, we should have two different jump destinations, one for updating the numbers and one for reading the numbers. So let's go ahead. Let's compile this again. I'm going to do the bin time or the bin runtime. So this is just the runtime. Let me copy this.

因为 Solidity 将在这里有一个额外的 dupe 操作码，实际上是 dupe one 操作码，这将花费 gas。所以恭喜你。到目前为止，你只是通过这样做就升级了。因此，如果我们编译它，我们应该有两个不同的跳转目标，一个用于更新数字，一个用于读取数字。所以我们开始吧。让我们再次编译它。我将执行 bin time 或 bin runtime。所以这只是运行时。让我复制这个。

I will paste this once again to the playground so we can really feel what's going on. And wow, look at that. So now we have one jump desk. We have two jump desks and two jump ifs. So it looks like the first one we're comparing for the update and then we're comparing for the read. So let's go ahead. Let's run through this. And again, we're going to be looking at the stack at the bottom.

我将再次将其粘贴到 playground，以便我们可以真正感受到发生了什么。哇，看看那个。所以现在我们有一个 jump desk。我们有两个 jump desk 和两个 jump if。所以看起来我们比较的第一个是更新，然后我们比较的是读取。所以我们开始吧。让我们运行一下。同样，我们将查看底部的堆栈。

And let's see if we once we hit here, it should jump down to here. Right. If we pass in the correct function selector. So I'm actually going to copy it so that it should be the correct function selector. And we're going to go ahead and run this. So we do push zero. Great. Jump to. Yep. Cool. And now we're at this jump if. And here's what the stack looks like. We have a 1A, which is going to be what is going to be the program counter or the jump destination.

让我们看看，一旦我们到达这里，它应该跳转到这里。对。如果我们传入正确的函数选择器。所以实际上我要复制它，以便它应该是正确的函数选择器。我们将继续运行它。所以我们执行 push zero。太棒了。跳转到。是的。酷。现在我们在这个 jump if。这就是堆栈的样子。我们有一个 1A，这将是程序计数器或跳转目标。

We have a 1, which stands for true. And then we have the original function selector on our stack. Once we get to this opcode. Since this is true, our jump if should jump down to 1A, this valid jump desk when I hit this step into button. And that's indeed what we see. Perfect. So our code is working the way we want it to work. We're getting valid jump destinations. Our code is compiling. Oh, this is so exciting.

我们有一个 1，代表 true。然后我们在堆栈上具有原始函数选择器。一旦我们到达这个操作码。由于这是 true，我们的 jump if 应该跳转到 1A，这个有效的 jump desk，当我点击此 step into 按钮时。这确实是我们所看到的。完美。所以我们的代码正在按照我们想要的方式工作。我们获得了有效的跳转目标。我们的代码正在编译。哦，这太令人兴奋了。

We're learning exactly how opcodes work and exactly how Solidity compiles our smart contracts into opcodes. And we're learning even more efficient ways to do it. So I know this is really low level. A lot of this can be confusing. So be sure to stop, pause, ask questions, et cetera, and tinker with some of these, right? Compile some different contracts, stick it into here, try to play with them, put in different calldata values, et cetera, and see what happens.

我们正在学习操作码如何工作，以及 Solidity 如何将我们的智能合约编译为操作码。而且我们还在学习更有效的方法来做到这一点。我知道这非常底层。很多东西可能会让人困惑。所以一定要停下来，暂停，提问等等，并尝试使用其中的一些，对吧？编译一些不同的合约，把它放到这里，尝试使用它们，放入不同的 calldata 值等等，看看会发生什么。

What will happen if we don't jump? What will happen if we don't jump anywhere? Well, the code will just keep going, right? The code will just keep going and maybe it'll call. It'll call whatever the next opcode is in our set. In our case, the next opcode is these two jump tests, which cost gas, right? If we don't get a valid jump destination, we want our function dispatcher to end. We want it to revert.

如果我们不跳转会发生什么？如果我们不跳转到任何地方会发生什么？那么，代码会一直执行下去，对吧？代码会一直执行下去，也许它会调用。它会调用我们集合中的下一个操作码。在我们的例子中，下一个操作码是这两个跳转测试，这会消耗 gas，对吧？如果我们没有得到有效的跳转目标，我们希望我们的函数分发器结束。我们希望它回滚。

So what's good practice is to add some type of a revert statement at the end here so that the code just doesn't continue to execute. And maybe even worse, it executes something you don't want it to execute. So if we do not get a valid function selector in the calldata, we want this call to revert. And to do that, we're going to use the revert opcode. So if we go to evm.codes, we look up revert. Here's the revert opcode.

所以好的做法是在末尾添加某种回滚语句，这样代码就不会继续执行。甚至更糟的是，它执行了你不希望它执行的东西。所以，如果我们在 calldata 中没有得到有效的函数选择器，我们希望这个调用回滚。为此，我们将使用 revert 操作码。所以如果我们去 evm.codes，我们查找 revert。这是 revert 操作码。

It takes two things on the stack, which are going to be the offset and the size. So the offset is going to be the bytes offset in memory in bytes and the return data of the calling context. And the size is going to be the size of memory to copy. If you wanted to revert with an error code, putting something into memory is how you would actually return with an error code. And this is how you would pick where in memory to actually return the data associated with the error code.

它在堆栈上需要两个东西，即偏移量和大小。所以偏移量将是内存中的字节偏移量，以及调用上下文的返回数据。大小将是要复制的内存大小。如果你想使用错误代码回滚，将某些东西放入内存是实际返回错误代码的方式。这就是你如何选择内存中的哪个位置来实际返回与错误代码相关联的数据。

For us, we're not going to do an error code. So we're going to say, great, just stick zero and zero on the stack and then revert. So on the stack, we would have put, you know, zero comma zero. And then once we revert, there's nothing else on the stack. And same thing if we compile this. And now we grab this. We go to our playground, paste it in here. If we run this without a valid function selector.

对我们来说，我们不打算使用错误代码。所以我们要说，很好，只需将零和零放在堆栈上，然后回滚。所以在堆栈上，我们会放入，你知道，零逗号零。然后一旦我们回滚，堆栈上就没有其他东西了。如果我们编译这个，也是一样。现在我们获取这个。我们去我们的 playground，把它粘贴到这里。如果我们运行这个，而没有有效的函数选择器。

So let's just do like one, one, one, one, one, one, one or something like that. What should happen is we shouldn't hit these jump desks, right? Because we should hit this revert before we jump here, before we jump to these. If this equals return true, we would jump to this jump desk. We would jump over the revert. But if we don't have a valid jump destination, we're going to run to this revert, which is what we want.

所以我们这样做，比如一，一，一，一，一，一，一，或者类似的东西。应该发生的是我们不应该碰到这些跳转目标，对吧？因为我们应该在跳转到这里之前，在跳转到这些之前，碰到这个回滚。如果这等于返回 true，我们会跳转到这个跳转目标。我们会跳过回滚。但是如果我们没有有效的跳转目标，我们将运行到这个回滚，这正是我们想要的。

So let's practice. We're going to put some dummy data in here. I hit run steps, steps, steps, steps, steps, steps, steps, steps, steps, steps, steps, steps, steps. And then, oh, yep. Sure enough, we landed on the revert. If I hit step again, boom, it's done, right? It doesn't go to these jump desks because the call reverts. And even in the little log here, we see revert. And we reverted with no data.

所以让我们练习一下。我们要在里面放一些虚拟数据。我点击运行步骤，步骤，步骤，步骤，步骤，步骤，步骤，步骤，步骤，步骤，步骤，步骤，步骤。然后，哦，是的。果然，我们落在了回滚上。如果我再次点击步骤，砰，它就完成了，对吧？它不会去这些跳转目标，因为调用回滚了。即使在小日志中，我们也看到了回滚。我们回滚了，没有数据。

So these jump desks don't get executed. And that's what we want. Great job. So we now have a function dispatcher. This is exactly what Solidity does and Vyper does and all of our smart contracts do whenever they get a transaction, whenever they get calldata. This is the first thing that they do. And later on in this section, when we break down the Solidity bytecode, you'll see that Solidity does this exact same thing, but with a few more opcodes.

所以这些跳转目标没有被执行。这就是我们想要的。做得好。所以我们现在有了一个函数分发器。这正是 Solidity 和 Vyper 所做的，以及所有我们的智能合约在获得交易时，每当他们获得 calldata 时所做的。这是他们做的第一件事。在本节的后面，当我们分解 Solidity 字节码时，你会看到 Solidity 做了完全相同的事情，但使用了一些更多的操作码。

And you'll see why. Now we're going to do two things to make this a little bit nicer. I've kind of got a lot of comments in here that are making this a little bit difficult to read right now. And this function really is that many lines of code, but it looks like it's a ton of lines of code because of how many comments are in here. So I'm going to go ahead and delete most of my comments. But you put the amount of comments in your code base that you want.

你会明白为什么。现在我们要做的两件事是让它更好看一点。我在这里放了很多注释，使得现在有点难以阅读。这个函数确实有很多行代码，但是由于这里有多少注释，看起来好像有很多行代码。所以我打算删除我的大部分注释。但是你在你的代码库中放入你想要的注释量。

I'm also going to line up a lot of these jumps as well. A lot of these lines as well, because same reason I want to make them a little bit easier to read. But yeah, you can do whatever you like to do. This, that, this. Beautiful. Cool. So this is actually what our main function dispatcher looks like, and that's a lot smaller than what it was before. So this one's going to be update number of horses.

我还将对齐很多这些跳转。还有很多这些行，因为同样的原因，我想让它们更容易阅读。但是，是的，你可以做任何你想做的事情。这个，那个，这个。漂亮。酷。所以这实际上是我们的主函数分发器的样子，并且这比以前小了很多。所以这个将是 update number of horses。

Bit of syntactic sugar that comes with Huff is actually making these Huff function signatures, these function selectors a little bit easier to read. What Huff has is this keyword called double _all caps funk _sig. And this will actually calculate the function signature for use. So you don't have to mainly do it with cast or every single function selector that you're using. What you can do is at the top of your code, you can actually define a little interface.

Huff 带来的一些语法糖实际上是使这些 Huff 函数签名，这些函数选择器更容易阅读。Huff 有一个关键字叫做 double _all caps funk _sig。这实际上会计算函数签名以供使用。所以你不必主要使用 cast 或每个你正在使用的单个函数选择器来手动完成。你可以做的是在你的代码顶部，你实际上可以定义一个小接口。

And in this interface, you can write the different functions as how they would be defined in solidity. And Huff will take those and convert those into function selectors. So we'll do define function update horse number with a uint256, which is going to be non-payable. So we have to do this non-payable bit in Huff. And then we'll also do define function read number of horses. And since this is a view function, we don't need non-payable.

在这个接口中，你可以编写不同的函数，就像它们在 solidity 中定义的方式一样。Huff 将获取这些并将它们转换为函数选择器。所以我们将定义函数 update horse number，使用 uint256，这将是 non-payable。所以我们必须在 Huff 中做这个 non-payable 的部分。然后我们还将定义函数 read number of horses。由于这是一个 view 函数，我们不需要 non-payable。

But this will return a uint256. And now that we have this solidity-esque interface here, we can actually use these with this funk sig keyword. So now instead of adding the function selector directly here, what we just do is we do double _funk sig. And then in here we put update number of horses. So this will take the update number of horses function from our interface and convert it right for us in here.

但是这将返回一个 uint256。现在我们有了这个类似 solidity 的接口，我们可以实际将这些与这个 funk sig 关键字一起使用。所以现在，我们不直接在这里添加函数选择器，而是我们只需做 double _funk sig。然后在这里我们放入 update number of horses。所以这将从我们的接口中获取 update number of horses 函数，并在这里为我们正确地转换它。

And we can do the same thing for read number of horses. Copy that, paste it in here. And you'll see when we compile this, we can even copy this, paste it into Huff here. Oops, I forgot the B at the end. You'll see it's the exact same code as what we got before. Same function selectors, same everything. It's just a bit of syntactic sugar to make it easier for us to auto calculate those function signatures.

我们可以对 read number of horses 做同样的事情。复制它，粘贴到这里。你会看到，当我们编译这个时，我们甚至可以复制这个，把它粘贴到这里的 Huff 中。哎呀，我忘了结尾的 B。你会看到它和我们之前得到的代码完全相同。相同的函数选择器，相同的一切。这只是一些语法糖，使我们更容易自动计算这些函数签名。

All right, this is great. So now we have our function dispatching. We've got a little interface to make function dispatching a little bit easier working with our function selectors. Now we have our two main functions that we get to work with. We have our set number of horses and we have our get number of horses. These are going to be the jump destinations for our op code to go ahead and work with. So let's actually do the set number of horses or update number of horses first.

好的，这太棒了。所以现在我们有了我们的函数分发。我们有一个小接口，使函数分发更容易使用我们的函数选择器。现在我们有了两个可以使用的主要函数。我们有 set number of horses，我们有 get number of horses。这些将是我们的操作码的跳转目标，以便继续使用。所以让我们先做 set number of horses 或 update number of horses。

And the reason that we're going to do this one first is because one of the first things that we need to do is we actually need to store this value in a storage slot. So a quick refresher on storage. When we work with storage, we can think of storage as a giant array, a giant array that when the execution of our transaction finishes, it stays. Right. And we have variables in our contracts in Solidity that get mapped to some storage slot that stays and persists.

我们首先做这个的原因是，因为我们需要做的第一件事是我们实际上需要将这个值存储在存储槽中。所以快速回顾一下存储。当我们使用存储时，我们可以将存储视为一个巨大的数组，一个巨大的数组，当我们的交易执行完成时，它会保留。对。在Solidity中，我们合约中的变量会被映射到一些持久存在的存储槽中。

Booleans get mapped, favorite numbers get mapped, and they all get mapped in some type of bytes 32 structure. And mappings are a little bit tricky where the way they work is they have little hashing algorithms that assign their values to a storage slot depending on what slot that array is assigned to. So like let's say in this example here, my array is at slot two in storage. The first value, the value at slot0 in my array is going to be at cacac 256 of two of whatever the value is.

布尔值会被映射，喜欢的数字会被映射，它们都会被映射到某种 bytes 32 结构中。而映射有点棘手，它们的工作方式是它们有一些小的哈希算法，可以将它们的值分配给一个存储槽，具体取决于该数组分配给哪个槽。比如，在这个例子中，我的数组在存储中的槽 2。第一个值，我的数组中槽 0 的值将位于 cacac 256 的 2，无论该值是什么。

So there's they use a hashing algorithm to put the data of arrays and mappings at slots in storage that are hopefully nobody else is going to use. Constants do not go in storage, nor do memory variables, of course. So when we're working with storage and we want to update storage, we got to do a couple things here. So to set our number of horses, we got to do a few things. We're going to number one, have to give it a storage pointer or a storage slot.

因此，他们使用哈希算法来放置数组和映射的数据在存储中的槽，希望没有人会使用。常量不会进入存储，当然，内存变量也不会。因此，当我们使用存储并且想要更新存储时，我们需要做几件事。因此，要设置我们的马匹数量，我们需要做几件事。首先，我们必须给它一个存储指针或一个存储槽。

And then number two, call the S store opcode to store the value. And that's pretty much it. So our set number of horses needs to do these two things. And then once it's in storage, we'll essentially give it a little slot here, which will represent the num of horses. Right. And this will permanently be in storage forever at whatever storage slot we give it. And once we do this and once we write both of these, then we can write some tests that will compare our Huff implementation against our saluting implementation.

其次，调用 S store 操作码来存储该值。差不多就是这样。因此，我们的设置马匹数量需要做这两件事。然后，一旦它进入存储，我们基本上会在这里给它一个小槽，它将代表马匹的数量。对。这将永久地存在于存储中，无论我们给它什么存储槽。一旦我们完成了这些，并且我们编写了这两个，那么我们可以编写一些测试，将我们的 Huff 实现与我们的 Solidity 实现进行比较。

And we'll see that they both do exactly the same thing, which will be really exciting. So we're almost there. We're getting actually really close. We're actually almost done with this Huff code base already. Let's set number of horses. Let's update the number of horses here. So let's do that. So in order for us to store this data is we're going to have to use the S store opcode.

我们会看到它们都做了完全相同的事情，这将会非常令人兴奋。所以我们快完成了。我们实际上非常接近了。我们实际上几乎已经完成了这个 Huff 代码库。让我们设置马匹数量。让我们在这里更新马匹数量。那么让我们开始吧。为了存储这些数据，我们将必须使用 S store 操作码。

So if we look for the S store opcode, this is the opcode that's responsible for storing data to storage. And once again, it has a stack input here and it actually has no stack output. So it's just going to pop the first two items off the stack and stick those values into storage. So the first the top of the stack is going to be a 32 byte key in storage and then the value to store. So so the top of the stack is going to tell us where to put this.

所以如果我们查找 S store 操作码，这就是负责将数据存储到存储中的操作码。同样，它在这里有一个堆栈输入，但实际上没有堆栈输出。所以它只会从堆栈中弹出前两个项目，并将这些值放入存储中。因此，堆栈的顶部将是存储中的 32 字节密钥，然后是要存储的值。因此，堆栈的顶部将告诉我们将它放在哪里。

Basically, are we going to put this at index one in storage? Are we going to put this at index two in storage at index three in storage? And then of course, instead of one, two, three, these are going to be bytes binary here. But where is this number of horses variables going to belong? Slot one, slot two, slot three, et cetera. And then the value to store obviously is going to be the number of horses that we want to put in here.

基本上，我们是否要将其放在存储中的索引 1 处？我们是否要将其放在存储中的索引 2 处，还是索引 3 处？然后当然，不是 1、2、3，这些在这里将是字节二进制。但是，这个马匹数量的变量将属于哪里？槽 1、槽 2、槽 3 等等。然后显然，要存储的值将是我们想要放在这里的马匹数量。

Actually, we have to do one more thing. We have to get the value to store from calldata and then we have to store it. Sorry. So we have to get a storage slot, get the value of the user called the store and then S store the opcode. So on horse store update number of horses, maybe they put in like two. Right. We have to say, OK, well, the number of horses storage slot is X. You want to store number two.

实际上，我们必须再做一件事。我们必须从 calldata 获取要存储的值，然后存储它。抱歉。因此，我们必须获取一个存储槽，获取用户调用的值，然后 S store 操作码。因此，在 horse store 更新马匹数量时，也许他们输入了 2。对。我们必须说，好的，马匹数量的存储槽是 X。你想要存储数字 2。

OK, let's store number two at storage slot X. Great. So let's go ahead and let's do that. So how do we get the storage slot for number of horses? Well, we could do this a number of ways. Right. We could hard code it. We could just say, OK, at zero X, you know, 80 or something. That's going to be where we store this storage slot. And we 100 percent could do this. But Huff actually makes working with storage a little bit easier.

好的，让我们将数字 2 存储在存储槽 X。很好。那么让我们开始吧。那么我们如何获得马匹数量的存储槽呢？我们可以通过多种方式做到这一点。对。我们可以硬编码它。我们可以直接说，好的，在 0x80 或其他地址。这将是我们存储此存储槽的位置。我们 100% 可以做到这一点。但是 Huff 实际上使存储的工作变得更容易。

This is another one of Huff's few abstractions that they have. They have this keyword called free storage pointer where it essentially is just a counter for what storage slots are open. So if we in our code base here, we scroll the top. If we define a constant variable, call it number of horses storage slot equals free storage pointer like this. This will just assign number of horses storage slot to slot0 to whatever slot is open.

这是 Huff 拥有的少数抽象之一。它们有一个名为 free storage pointer 的关键字，它本质上是只是一个用于记录哪些存储槽是开放的计数器。因此，如果我们在我们的代码库中，我们滚动到顶部。如果我们定义一个常量变量，称其为 number of horses storage slot 等于 free storage pointer，就像这样。这会将 number of horses storage slot 分配给槽 0 到任何打开的槽。

If we do a new one, number of horses storage slot two, this would assign it to one. So it's free storage pointer is just a counter essentially, which says, OK, here's the slot that's currently open in storage right now. Because remember, every storage slot is going to be 32 bytes. So so a number of horses slot, free storage pointer. We could also just say it's OK, it's zero X zero zero. We could hard code it like that.

如果我们创建一个新的，number of horses storage slot 2，这会将其分配给 1。因此，free storage pointer 本质上只是一个计数器，它说，好的，这是当前在存储中打开的槽。因为请记住，每个存储槽都是 32 字节。因此，一个马匹数量的槽，free storage pointer。我们也可以直接说，好的，它是 0x00。我们可以像这样硬编码它。

But when working with storage, it's usually best to use the syntax in Huff. So so cool. So now we're saying, OK, in storage, sorry, it actually increments from zero, not from one in storage at slot0. That's where we're going to put the number of horses, not slot one, not slot two, not slot 576 at slot0. So any time somebody looks at this smart contract, looks at storage slot0, that's where the horse number is going to be stored.

但是，在使用存储时，最好使用 Huff 中的语法。太酷了。所以现在我们说，好的，在存储中，抱歉，它实际上是从零开始递增，而不是从 1 开始，在存储中的槽 0。这就是我们要放置马匹数量的地方，而不是槽 1，不是槽 2，不是槽 576，而是在槽 0。因此，任何时候有人查看此智能合约，查看存储槽 0，这就是存储马匹数量的地方。

And that's exactly how solidity works. When solidity sees the first variable in a solidity contract, it is automatically signs this to slot number zero. So great. So now we have a storage slot. So we're probably going to want to use this storage slot now to reference this storage slot0 in our code. Down in here, we do this syntax like this. We just put it in between these brackets. These brackets here will basically say, OK, I'm going to give you I'm going to put onto the stack.

这正是 Solidity 的工作方式。当 Solidity 看到 Solidity 合约中的第一个变量时，它会自动将其分配给槽号零。太好了。所以现在我们有了一个存储槽。因此，我们现在可能想要使用这个存储槽来引用我们代码中的存储槽 0。在下面，我们像这样使用这种语法。我们只是将其放在这些括号之间。这里的这些括号基本上会说，好的，我会给你我会放到堆栈上。

It basically is doing a push of this value onto the stack. So I'm going to push that zero, that storage slot pointer for your notes. You put number of horses storage slot. You can do 0x00. You can do PTR for a pointer to the storage slot, whatever you want to do. This is essentially saying at the zero with index, what this number is returning is it's returning the number zero. We're saying, hey, number of horses is an index zero. Great.

它基本上是将这个值推送到堆栈上。因此，我将推送那个零，那个存储槽指针，供你参考。你放置 number of horses storage slot。你可以执行 0x00。你可以为指向存储槽的指针执行 PTR，无论你想做什么。这本质上是在说，在索引为零的位置，这个数字返回的是数字零。我们说，嘿，马匹数量的索引为零。很好。

Number of horses storage slot is zero. So this is just the index and storage where it is or the pointer of where that value is. And this is where we're going to want to store our data. And if we go back to the S store opcode, we're going to need the 32 byte key in storage. Check. We just got that. Now we also need the value and we need actually we need the key on top of the value.

马匹数量存储槽为零。因此，这只是它所在的索引和存储，或者该值所在的指针。这就是我们要存储数据的地方。如果我们回到 S store 操作码，我们将需要存储中的 32 字节密钥。检查。我们刚刚得到了它。现在我们还需要该值，实际上我们需要密钥在值的顶部。

So we should do the value first because that's how stack works. So these are actually kind of out of order. Boop, boop. So we actually need to get the value from the calldata first so that the key is on top of it. So the question is now, OK, how do we get the value we want to update from the calldata? Well, remember, in remix we grabbed this chunk right here, which was kind of a little demo of what's going to be sent.

所以我们应该先做值，因为这就是堆栈的工作方式。所以这些实际上有点乱序。噗，噗。因此，我们实际上需要先从 calldata 获取该值，以便密钥位于其顶部。所以现在的问题是，好的，我们如何从 calldata 获取我们要更新的值？请记住，在 Remix 中，我们抓取了这一块，这是将要发送内容的一个小演示。

So again, the first four bytes is going to be the function selector. And then the next is going to be the calldata associated with the parameters of that function. For us, the uint256. When we did this in remix, this was the wrong function selector. But if we did this remix, if I change this to seven update horses, let me look at the transactions, scroll the bottom, input here. Let me copy that, show you what that one is. Boom.

所以，再次强调，前四个字节将是函数选择器。接下来将是与该函数参数相关的 calldata。对我们来说，是 uint256。当我们在 Remix 中这样做时，这是错误的功能选择器。但是，如果我们在 Remix 中这样做，如果我将其更改为 7 更新马匹数量，让我看看交易，滚动到底部，这里是输入。让我复制一下，告诉你那是什么。砰。

This is the calldata that's going to be returned. Once again, we have the function selector at the beginning. And then all of this is the encoded seven. So this is the hex of the number seven. So everything after the first four bytes, these 32 bytes here is going to be the number that we want to update this to. So how do we do that? Well, we already know how to get calldata because we learned about calldata load, calldata load, right?

这是将要返回的 calldata。再次，我们在开头有函数选择器。然后所有这些都是编码后的 7。所以这是数字 7 的十六进制表示。因此，前四个字节之后的所有内容，这里的这 32 个字节是我们要更新的数字。那么我们该怎么做呢？嗯，我们已经知道如何获取 calldata，因为我们学过关于 calldata load，calldata load，对吧？

So calldata load, what does it do again? OK, the byte offset in the calldata is the input and the output is going to be the 32 byte value starting from the given offset of the data. OK, great. So if this is our calldata, right, because the calldata is going to be the same no matter what, it's not going to change. We want to get rid of the first four bytes. We would set the byte offset, our stack input to be the first four bytes, because remember, the function selector is going to be one, two, three, four bytes and the rest of this is going to be the 32 bytes associated with the call.

那么 calldata load，它再次做什么？好的，calldata 中的字节偏移量是输入，输出将是从给定数据偏移量开始的 32 字节值。好的，太棒了。所以如果这是我们的 calldata，对吧，因为 calldata 无论如何都是一样的，它不会改变。我们想要去掉前四个字节。我们会将字节偏移量，我们的堆栈输入设置为前四个字节，因为请记住，函数选择器将是一、二、三、四个字节，其余部分将是与调用相关的 32 个字节。

So we just saw that in Remix. Let me actually copy the Remix one because that's using the correct function selector. So what we would do is we'd push 0x04 onto the stack. So essentially four. And then we would do calldata load. And this calldata load is going to just add on the, if we called with seven, it's just going to be that seven. So this is going to be essentially the calldata minus function selector.

所以我们刚刚在 Remix 中看到了。实际上让我复制 Remix 的那个，因为它使用的是正确的功能选择器。所以我们要做的就是将 0x04 推送到堆栈上。所以本质上是 4。然后我们将执行 calldata load。这个 calldata load 将只添加，如果我们用 7 调用，它将只是那个 7。所以这本质上是 calldata 减去函数选择器。

Or you can just say this is going to be the input, input value, whatever you want to call it. So now we have the input that we want to actually store or the value, whatever you want. Then we put the number of horses storage slot on here. So we would have storage slot input. I'm just storage slot. I like that a little bit better. Storage slot or value. Let's do value. I like value a little bit better. Storage slot and value.

或者你可以直接说这将是输入，输入值，无论你想怎么称呼它。所以现在我们有了我们想要实际存储的输入或值，随便你。然后我们将马匹数量的存储槽放在这里。所以我们会有存储槽输入。我只是存储槽。我更喜欢那个。存储槽或值。我们用值。我更喜欢值。存储槽和值。

Then we can call the S store opcode. Because what's this going to do? Again, S store going to say, okay, at the top of the stack is the 32 byte key in storage. That's our storage slot. And right underneath it is going to be the value to store. That's going to be our input seven. So we're just going to call S store. And then importantly, we're then going to call stop. If you don't call a stop here, the code will continue to execute.

然后我们可以调用 S store 操作码。因为这将做什么？再次，S store 会说，好的，在顶部堆栈是在存储中的 32 字节密钥。那是我们的存储槽。在它下面是要存储的值。那将是我们的输入 7。所以我们只需要调用 S store。然后重要的是，我们将调用 stop。如果你不在这里调用 stop，代码将继续执行。

If the opcodes for get number of horses are right after, it'll also do get number of horses, which kind of would be a waste of gas and we don't want to waste gas. So we're going to stop here. So the stop opcode costs zero gas and it just stops the transaction. That's it. It doesn't revert. It's a successful transaction. But the transaction is just it's just done. It's just the end of the transaction. Cool.

如果 get number of horses 的操作码紧随其后，它也会执行 get number of horses，这有点浪费 gas，我们不想浪费 gas。所以我们在这里停止。所以 stop 操作码消耗零 gas，它只是停止交易。就这样。它不会回滚。这是一个成功的交易。但交易只是完成了。这只是交易的结束。酷。

So this should be a working macro to actually update the number of horses in storage. Well, let's compile this to make sure it actually compiles. It sure does. This is the runtime code. So let me copy the runtime code. Let's bring it over to the playground to test this out. And don't worry, I'm going to show you a better way to test these pretty soon. And now if we look in our opcodes list to the right here, we now have this S store opcode at the bottom.

所以这应该是一个有效宏，可以实际更新存储中的马匹数量。好吧，让我们编译一下，以确保它确实可以编译。它确实可以。这是运行时代码。所以让我复制运行时代码。让我们把它带到 playground 来测试一下。别担心，我很快会告诉你一个更好的测试方法。现在，如果我们查看右侧的操作码列表，我们现在在底部有这个 S store 操作码。

Okay, exciting. All right. So let's come up with some valid input data. So this should be valid input calldata to update the storage to seven. Right. Because we have the function selector for update number of horses and then the parameter data here is the number seven encoded. So if I grab that and I stick it into the hex calldata of our playground here and then hit run, we now can rip through and see our memory and stack as we do this.

好的，令人兴奋。好的。所以让我们提出一些有效的输入数据。所以这应该是有效的输入 calldata，可以将存储更新为 7。对。因为我们有 update number of horses 的函数选择器，然后这里的参数数据是编码后的数字 7。所以如果我抓住它并将其放入我们 playground 的十六进制 calldata 中，然后点击运行，我们现在可以浏览并在我们执行此操作时查看我们的内存和堆栈。

And we're going to show you a way to do this in Foundry as well. So let's go ahead and step into this. We kind of already know what some of these are doing. It looks like we're pushing the function selector. We're comparing it. We're pushing the other function selector. We're jumping if and it looks like we went ahead and jumped. Right. That's why we shot down here as I was pressing the buttons, because we've identified a correct function selector.

我们还将向你展示在 Foundry 中执行此操作的方法。所以让我们继续并逐步执行此操作。我们已经知道其中一些在做什么。看起来我们正在推送函数选择器。我们正在比较它。我们正在推送另一个函数选择器。我们正在跳转 if，看起来我们已经跳转了。对。这就是为什么当我按下按钮时，我们在这里停下来的原因，因为我们已经确定了正确的功能选择器。

Now we're doing push for, which is what this push for is going to be this push for right here. Then we're doing our calldata load, which is going to be this part right here. Push zero because our number of horses storage slot is actually storage slot0. Right. Push zero. And then we do an S store exactly as we just thought. So if we scroll down right now on the stack is zero seven and the function selector.

现在我们正在执行 push for，这就是这个 push for 将要执行的 push for。然后我们正在执行我们的 calldata load，这将是这里的这一部分。Push zero，因为我们的马匹数量存储槽实际上是 storage slot 0。对。Push zero。然后我们按照我们刚才的想法执行 S store。所以如果我们向下滚动，现在堆栈上是 0 7 和函数选择器。

Oh, I guess the function selector is technically on the stack when we do this as well. But that's OK. I didn't put it in the notes here. So zero seven function selector. So storage slot value and then also the function selector. And when we hit next here, it should store that seven into this little storage bit here. So I'm gonna hit next. Now we're at the stop and we see the value seven is in storage slot0.

哦，我想当我们这样做时，函数选择器在技术上也在堆栈上。但这没关系。我没有把它放在这里的笔记中。所以 0 7 函数选择器。所以存储槽值，然后还有函数选择器。当我们在这里点击下一步时，它应该将 7 存储到这个小的存储位中。所以我要点击下一步。现在我们到了 stop，我们看到值 7 在 storage slot 0 中。

And if we hit next now that we're at the stop, we've actually ended because stop ends execution. You can see there's actually another jump test after the stop that we didn't go to. And this other jump test is going to be the read number of horses code. We don't want it to read the number of horses. We want it to just stop. We want to finish executing. So that's why this is here.

如果我们现在点击下一步，因为我们已经到了 stop，我们实际上已经结束了，因为 stop 结束了执行。你可以看到在 stop 之后实际上还有另一个跳转测试，我们没有去。这个其他的跳转测试将是读取马匹数量的代码。我们不希望它读取马匹数量。我们希望它只是停止。我们想要完成执行。所以这就是为什么这里有这个。

This stop is actually really, really important because if this next function in your code base was like update number of horses by two, whenever you update number of horses, it would double it or it would do whatever this next function is. And we don't want it to do that. So awesome. So we learned after the function has been dispatched, run the function and then stop.

这个 stop 实际上非常非常重要，因为如果你的代码库中的下一个函数就像 update number of horses by two，无论何时你更新马匹数量，它都会加倍或者会执行下一个函数。我们不希望它这样做。太棒了。所以我们了解到，在函数被分派之后，运行该函数，然后停止。

And when we decompile the solidity smart contract, this code right here is nearly identical to what this function is doing in solidity. These two are doing almost exactly the same thing. Solidity has a couple of more guardrails, couple more opcodes that I'll walk you through in a minute. But essentially you've just learned how to build a function in Huff and essentially in raw byte codes. This is so exciting.

当我们反编译 solidity 智能合约时，这里的这段代码几乎与此函数在 solidity 中所做的相同。这两个几乎做着完全相同的事情。Solidity 有几个更多的保护措施，几个更多的操作码，我将在稍后向你介绍。但本质上，你已经学会了如何在 Huff 中构建一个函数，以及本质上在原始字节码中构建函数。这太令人兴奋了。

All right, nice. Let's keep it going. So now we only have one thing left to do. Let's just figure out how to read the number and then we can write some tests and I'll show you how to debug Huff a lot better, a lot easier than copying and pasting the output into this into this playground over here. So final thing, get number of horses. We want to read the number of horses from this storage slot that we came up with up here.

好的，很好。让我们继续。所以现在我们只剩下一件事要做。让我们弄清楚如何读取数字，然后我们可以编写一些测试，我将向你展示如何更好地调试 Huff，比复制和粘贴输出到这边的 playground 要容易得多。所以最后一件事，获取马匹数量。我们想从这个存储槽中读取马匹的数量，这是我们上面想出来的。

So how are we going to do that? Well, number one, get the storage slot. Number two, load the value of that slot into memory. And then three, return. So there's two keywords that two opcodes that we're going to work with here and they're going to be SLOAD. You've probably definitely heard of this before. This is where we load from storage. This is the read from storage. This is a very gas expensive opcode.

那么我们该怎么做呢？首先，获取存储槽。第二，将该槽的值加载到内存中。第三，返回。所以有两个关键字，两个操作码，我们将在这里使用，它们是 SLOAD。你可能以前肯定听说过这个。这是我们从存储中加载的地方。这是从存储中读取。这是一个非常消耗 gas 的操作码。

At the top of the stack is going to be the 32 byte key in storage. This is the index in storage we want to read from. And the output we get from this on the stack is going to be the value stored in that slot. So essentially at the top of our stack, we're going to have the number zero or the index in storage or the key in storage, if you will. We're going to run the SLOAD. It's going to pop this off. EVM is going to go, OK, let's look at storage.

堆栈的顶部将是存储中的 32 字节密钥。这是我们想要从中读取的存储索引。我们从堆栈中得到的输出将是存储在该槽中的值。所以本质上在我们的堆栈顶部，我们将有数字零或存储中的索引，或者存储中的密钥，如果你愿意这么称呼它。我们将运行 SLOAD。它会弹出这个。EVM 会说，好的，让我们看看存储。

What's at slot0? It's the number of forces. Great. Let's stick that onto the stack. And that's it. That's how that's going to work. The other opcode that we're going to look at here is actually the return opcode. So this halts execution, returning output data. This is essentially the same thing as stop, except it returns some data. So in a returns data from memory, not from the stack.

槽 0 有什么？是马匹的数量。很好。让我们把它放到堆栈上。就这样。这就是它的工作方式。我们将在这里看到的另一个操作码实际上是 return 操作码。所以这会停止执行，返回输出数据。这本质上与 stop 相同，只是它返回一些数据。所以它从内存中返回数据，而不是从堆栈中返回。

So if we want to return a value to the user, we have to first load it into memory and then return it out of memory with the return keyword. So to add stuff to memory, we're going to use the MSTORE, which is essentially the same as SSTORE. So it's like memory storage. Because again, you can think of memory as basically the same thing as storage, just a giant array. But the difference is it deletes at the end of the transaction.

所以如果我们想向用户返回一个值，我们必须首先将其加载到内存中，然后使用 return 关键字从内存中返回它。所以要将内容添加到内存中，我们将使用 MSTORE，它本质上与 SSTORE 相同。所以它就像内存存储。因为同样，你可以将内存视为与存储基本相同的东西，只是一个巨大的数组。但不同之处在于它在事务结束时删除。

All right, cool. So first thing, let's get that storage slot. Well, we already know how to do that with this notation here. So this is going to be the the key or the index or whatever you want to call it. Then all we have to do with this key is call SLOAD because the SLOAD, that's all it needs is the key. So we're saying, hey, at index zero, give us the number of horses. So we go SLOAD.

好的，酷。首先，让我们获取该存储槽。我们已经知道如何使用这里的符号来做到这一点。所以这将是密钥或索引，或者任何你想称呼它的东西。然后我们所要做的就是使用这个密钥调用 SLOAD，因为 SLOAD 只需要密钥。所以我们说，嘿，在索引零处，给我们马匹的数量。所以我们执行 SLOAD。

And now on our stack, we have the value. We have the number of horses on our stack now. So now in order for us to return it, we got to stick it into memory first. So this is where we're going to call MSTORE, which is right here. So MSTORE takes an offset and a value. So the offset is going to be the offset in memory in bytes. And you can think of this again as kind of like the index in memory.

现在在我们的堆栈上，我们有了这个值。我们现在在堆栈上有了马匹的数量。所以现在为了让我们返回它，我们必须首先把它放到内存中。所以这就是我们要调用 MSTORE 的地方，它就在这里。所以 MSTORE 接受一个偏移量和一个值。所以偏移量将是内存中的字节偏移量。你可以再次将此视为类似于内存中的索引。

So are we looking at index zero, index one, index two, index three, et cetera. But instead of index, it's like the offset in bytes. So but just you can kind of just think of it as like the index of memory. So we don't have anything in memory. So we can just say, OK, 0x00. So we're going to stick it at the zeroth index in memory or the zeroth offset.

所以我们是在看索引零、索引一、索引二、索引三等等吗。但不是索引，而是像字节偏移量。所以你可以把它想象成内存的索引。所以我们内存中没有任何东西。所以我们可以说，好的，0x00。所以我们将把它放在内存中的第零个索引或第零个偏移量处。

So now we have zero comma value. Now that the top of the stack is the offset and right underneath is the value, we can just call MSTORE. MSTORE. And now we pop both of those off. And now we have nothing in the stack, but our memory looks like this now. So this is kind of a hard part of working with opcodes and working with Huff. There's a lot of data structures you will have a hard time keeping track of when you're writing assembly.

所以现在我们有零，值。现在堆栈的顶部是偏移量，正下方是值，我们可以直接调用 MSTORE。MSTORE。现在我们把它们都弹出。现在我们的堆栈中没有任何东西，但我们的内存现在看起来像这样。所以这是使用操作码和使用 Huff 的一个难点。有很多数据结构，你在编写汇编时很难跟踪。

What's on the stack? What's in memory? What's in storage? What's in this? What's in that? This is why everyone codes in a higher level programming language like Solidity. When you have a ton of stuff in memory, a ton of stuff on the stack, it can get very difficult conceptually for you to keep track of all this stuff. But once we have our value, our number of horses stored in memory, what we can do then is actually return it.

堆栈上有什么？内存里有什么？存储里有什么？这里面有什么？那里有什么？这就是为什么每个人都使用更高级的编程语言（如 Solidity）进行编码。当你在内存中有大量东西，在堆栈上有大量东西时，从概念上讲，你很难跟踪所有这些东西。但是一旦我们有了我们的值，我们的马匹数量存储在内存中，那么我们可以做的就是实际返回它。

And the return keyword takes an offset and a size. So this is going to be the offset in memory. For us, it's going to be zero because we put it in the zeroth slot in memory. And then the size in bytes is actually going to be 20. And that needs to be where that needs to be below the offset. So we're going to do that one first because that's how stacks work. So the size is going to be how much of the memory data we're going to copy.

return 关键字接受一个偏移量和一个大小。所以这将是内存中的偏移量。对我们来说，它将是零，因为我们把它放在内存中的第零个槽中。然后以字节为单位的大小实际上将是 20。它需要低于偏移量。所以我们将首先执行该操作，因为这就是堆栈的工作方式。所以大小将是我们复制多少内存数据。

0x20 is going to be equal to 32 bytes. 0x20 equals 32 bytes. Right. If we do cast to base 0x20 deck, we get 32. So we're going to say, OK, we're going to have something in memory slot0, which we just mstored right before this. It's going to be 32 bytes long because it's just a number that's always stored. And then we're going to run return. And this again is going to pop everything off the stack and it's going to return what's in memory.

0x20 将等于 32 字节。0x20 等于 32 字节。对。如果我们转换为 0x20 进制，我们会得到 32。所以我们要说，好的，我们将在内存槽 0 中放一些东西，我们就在此之前 mstore 了它。它将是 32 字节长，因为它只是一个始终存储的数字。然后我们将运行 return。这将再次从堆栈中弹出所有内容，并且它将返回内存中的内容。

And what's cool is it's going to exit the current context successfully, which again, as you know, it's basically exactly like this in any function, like this keyword right here. And that's it. So let's try compiling this. Great. Compiling successfully. So now it's finally six into the playground and see end to end how this would work for reading some data.

很酷的是，它将成功退出当前上下文，同样，如你所知，它与任何函数中的这个关键字完全一样。就这样。所以让我们尝试编译它。太好了。编译成功。所以现在终于进入 playground，看看端到端如何读取一些数据。

So now we actually don't need the set number of horses function selector. We need the read number of horses function selector. And we actually don't need any other calldata other than the read because in our read code base, we never access any other calldata outside of the function selector in our dispatcher. So I know I'm saying a lot of words, but let's paste it in here and let's run it. Let's step through this.

所以现在我们实际上不需要设置马匹数量的函数选择器。我们需要读取马匹数量的函数选择器。实际上，除了读取之外，我们不需要任何其他 calldata，因为在我们的读取代码库中，我们从不访问调度程序中函数选择器之外的任何其他 calldata。我知道我说了很多，但让我们粘贴到这里，让我们运行它。让我们逐步执行。

And if you want to scroll down and see what the slots look like as we do this, you can do so. So we scroll up and move our beginner stuff. The SHR that tells me that we're in the function dispatching section. OK, there's the equals. There's the jump if we didn't jump. So we're going to compare to the next one. Here's a second jump if and if this is wrong, if this function selector is wrong, we are just going to hit the revert.

如果你想向下滚动并查看槽的外观，当我们这样做时，你可以这样做。所以我们向上滚动并移动我们的初学者内容。SHR 告诉我我们位于函数调度部分。好的，这里是 equals。如果我们没有跳转，这里是跳转。所以我们将与下一个进行比较。这是第二个 jump if，如果这是错误的，如果这个函数选择器是错误的，我们将直接回滚。

If it's right, we're going to jump down to the section down here. And we sure do. We jump down to the section down here and we can even see kind of the rest of the opcodes where we're going to push zero. We're going to S load. We're going to load from storage. So after that opcode, if I scroll down, we now see on the stack is seven because actually, well, this is still actually left over from the last time I ran this.

如果它是正确的，我们将跳转到下面的部分。我们当然会这样做。我们跳到下面的部分，甚至可以看到其余的 opcode，我们要 push zero。我们要 S load。我们要从存储中加载。所以在执行该 opcode 之后，如果我向下滚动，我们现在看到堆栈中的值是 7，因为实际上，嗯，这实际上是上次运行遗留下来的。

So the playground is really cool where the storage and the contract will actually stay. So I have seven in there. If you're running this for the first time, you'll probably have zero in there. But now we've loaded that seven into our stack. We now need to store it in memory. So after we run this M store, I'm going to step into. So we just ran this M store. So if I scroll down, we now see in memory, we have the seven stored here in memory.

所以这个 playground 非常酷，存储和合约会实际保留。所以我里面有 7。如果你是第一次运行，你可能会在里面看到 0。但现在我们已经将 7 加载到我们的堆栈中。我们现在需要将其存储在内存中。所以在我们运行这个 M store 之后，我将单步进入。所以我们刚刚运行了这个 M store。所以如果我向下滚动，我们现在看到在内存中，我们有 7 存储在这里的内存中。

And now we're going to push 20, push zero and return, which is going to say, okay, start from zero in memory and return all 20 bytes off. Well, it's gonna be all 32 bytes or OX 20 in hex of memory. And boom, that's exactly what happens. So this is incredibly exciting because you just wrote your first Huff smart contract. And in doing so, you learned about a ton of different opcodes and a ton about how the EVM works.

现在我们要 push 20，push zero 并 return，这将说，好的，从内存中的 0 开始，并返回所有 20 个字节。嗯，这将是所有的 32 个字节，或者内存中十六进制的 OX 20。砰，这正是发生的事情。这非常令人兴奋，因为你刚刚编写了你的第一个 Huff 智能合约。在这样做的过程中，你了解了大量的不同 opcodes 以及大量关于 EVM 如何工作的信息。

Let's do a quick refresher of all the stuff we learned, and then we'll go on and we'll write some differential tests here. We learned every single smart contract doesn't matter if it's written in Vyper, in Solidity, in Huff, pretty much needs to start with a function dispatcher. And this is when you check the calldata sent to the smart contract for the function selectors.

让我们快速回顾一下我们学到的所有东西，然后我们将继续在这里编写一些差异测试。我们了解到，每个智能合约，无论它是用 Vyper、Solidity 还是 Huff 编写的，几乎都需要从一个函数分发器开始。这是当你检查发送到智能合约的 calldata 中的函数选择器时。

Once you find a matching function selector, you basically route the call to whatever lump of code is associated with that function selector. We learned about the jump if opcode, where we can jump if some value on the stack is true. We learned how to work with storage slots. We learned how to S store. We learned how to S load. We learned what memory was, and we basically just learned how to write a smart contract in raw opcodes.

一旦你找到匹配的函数选择器，你基本上将调用路由到与该函数选择器关联的任何代码块。我们了解了 jump if 操作码，如果堆栈上的某个值为真，我们可以跳转。我们学习了如何使用存储槽。我们学习了如何 S store。我们学习了如何 S load。我们了解了什么是内存，并且我们基本上只是学习了如何用原始操作码编写智能合约。

This is fantastic. If you're kind of feeling overwhelmed right now, now's a great time to go take a break, go for a walk, grab a coffee and come back to this. This is heavy stuff. And the Huff docs do a great job as supplemental information on understanding the EVM, showing pictures, etc. If any of this doesn't make sense to you, tinker with it. Try something else.

这太棒了。如果你现在感到有点不知所措，现在是休息一下的好时机，散散步，喝杯咖啡，然后再回来。这内容很硬核。并且 Huff 文档在作为补充信息方面做得很好，用于理解 EVM，展示图片等等。如果这些对你来说没有任何意义，那就尝试修改它。尝试其他的东西。

We are not going to show you the Huff debugger, so you do not need to install HEVM. However, if you like to, feel free to go ahead, try HEVM with the Huff debugger. Although I'm going to tell you right now, you will run into some hurdles installing HEVM, installing potentially Nix and working with the Huff debugger. Use at your own risk, essentially. And I'm not going to be showing you how to work with it.

我们不会向你展示 Huff 调试器，所以你不需要安装 HEVM。但是，如果你愿意，可以随意尝试使用 HEVM 和 Huff 调试器。虽然我现在要告诉你，你会遇到安装 HEVM 的一些障碍，安装 Nix 并使用 Huff 调试器。本质上，使用风险自负。我不会向你展示如何使用它。

Instead, we're going to be showing you how to write Foundry tests that work with Huff so that you can basically debug everything through Foundry. Cool? Cool. OK, well, we are at a phenomenal place. We've learned a ton already. We've built a smart contract in Huff. We have the equivalent solidity over here. And now you can probably see why nobody would ever want to write their smart contracts in Assembly or in Huff.

相反，我们将向你展示如何编写与 Huff 一起使用的 Foundry 测试，这样你就可以通过 Foundry 调试所有内容。酷吗？酷。好的，我们现在处于一个非常好的位置。我们已经学了很多东西。我们用 Huff 构建了一个智能合约。我们在这里有等效的 Solidity 代码。现在你可能明白为什么没有人愿意用汇编或 Huff 编写他们的智能合约。

Writing opcode by opcode is a whole lot more tedious than writing a higher level programming language like Solidity. Sure, you might be more gas efficient, but it's kind of five times as long to do something that you can do in Solidity in like two seconds. But to make sure these two code bases are doing the same thing, we can write some differential tests or some differential fuzzing, etc.

逐个操作码编写比编写像 Solidity 这样的高级编程语言要繁琐得多。当然，你可能会更节省 gas，但这大约是你在 Solidity 中两秒钟内可以完成的事情的五倍时间。但是为了确保这两个代码库做的是同一件事，我们可以编写一些差异测试或一些差异模糊测试等。

And once we write these tests to prove they're doing the same thing, then we're going to break down exactly what's going on in the solidity code, opcode by opcode. And you're going to see a whole lot of comparisons, a whole lot of parallels to what we just did in Huff. So what we're going to do to get started is we're going to create a new folder in here and we're just going to call it v1 of our tests.

一旦我们编写了这些测试来证明它们做的是同一件事，那么我们将详细分析 Solidity 代码中发生的事情，逐个操作码。你将会看到大量的比较，大量的与我们刚刚在 Huff 中所做的事情的相似之处。所以我们开始要做的是在这里创建一个新文件夹，我们将其命名为我们的测试的 v1。

And this is where we're going to write our v1 tests. Now I'm going to make a file called base test v1.t .sol And this is actually going to have all of the tests that we want for both Huff and for Solidity. We're going to have a Solidity version of the test inherit this one and a Huff version of the test inherit this one so that we are 100 percent sure both smart contracts are running on the exact same tests.

这是我们将编写我们的 v1 测试的地方。现在我将创建一个名为 base test v1.t .sol 的文件，这实际上将包含我们想要用于 Huff 和 Solidity 的所有测试。我们将有一个 Solidity 版本的测试继承这个，以及一个 Huff 版本的测试继承这个，这样我们 100% 确定两个智能合约都在运行完全相同的测试。

You'll see what that looks like in just a minute. So let's go ahead. Let's write some tests here. I'm going to go kind of quick because because at this point you should be pretty good at writing this stuff. It's going to be an abstract contract so that when we run the tests, you have to inherit this contract in order for a test to actually run. Base test v1 is test. So feel free to follow along with me or if you want just copy paste you can do that too.

你很快就会看到它是什么样子。所以我们开始吧。让我们在这里编写一些测试。我将快速进行，因为在这一点上你应该很擅长编写这些东西了。这将是一个抽象合约，这样当我们运行测试时，你必须继承这个合约才能实际运行测试。Base test v1 is test。所以你可以随意跟着我一起做，或者如果你想只是复制粘贴，你也可以这样做。

But I highly recommend you writing the test because getting good at writing these differential tests will be really really helpful for you. So we're going to import HorseStore. This is going to be the Solidity. src HorseStore v1 HorseStore. sol import test console 2 from Forge STD test.sol abstract contract base v1 test is test. OK great.

但我强烈建议你编写测试，因为擅长编写这些差异测试对你来说真的很有帮助。所以我们要导入 HorseStore。这将是 Solidity。src HorseStore v1 HorseStore。sol 从 Forge STD test.sol 导入 test console 2 抽象合约 base v1 test is test。好的，太好了。

We're going to have a HorseStore public HorseStore function set up public. And we're going to make this virtual because we're actually going to override this in a bit and you'll see why. We're say HorseStore equals new HorseStore. So this is pretty typical of Solidity. But what about for Huff? Well let's let's finish writing this. Let's actually just write one test here.

我们将有一个 HorseStore public HorseStore function set up public。我们将使这个函数成为 virtual，因为我们实际上要稍后 override 它，你就会明白为什么。我们说 HorseStore 等于 new HorseStore。所以这是 Solidity 的典型做法。但是 Huff 呢？好吧，让我们完成编写。让我们在这里实际编写一个测试。

We'll say function test read value public uint256 initial equals HorseStore.read number of horses. Assert equal should be zero equal. So now if we run Forge test this actually won't run. This will do a whole lot of nothing. Why? Well because we are in an abstract contract. So what we're going to do is we're going to make another one called HorseStore solc.t.sol.

我们将说 function test read value public uint256 initial equals HorseStore.read number of horses。Assert equal should be zero equal。所以现在如果我们运行 Forge test，这实际上不会运行。这将什么都不做。为什么？因为我们是在一个抽象合约中。所以我们要做的就是再创建一个名为 HorseStore solc.t.sol 的文件。

And this is where we'll do pretty much nothing different. GPL three only zero point eight point twenty contract HorseStore solc is base test v1. Import base test v1 from there. And boom. And now that we actually have a contract that's not an abstract contract. Now if we run Forge test the test will actually run. And it passed. And it's because it's inheriting all the tests from in here the one test and the setup and everything.

在这里我们几乎不会做任何不同的事情。GPL three only zero point eight point twenty contract HorseStore solc is base test v1。从那里导入 base test v1。砰。现在我们实际上有一个不是抽象合约的合约。现在如果我们运行 Forge test，测试将实际运行。并且通过了。这是因为它继承了这里面的所有测试，一个测试和设置以及所有内容。

Now what we want to do is we want to actually create a new file called HorseStore huff.t.sol. And we want to put this into v1. Excuse me. And I'm actually going to copy paste this one. I'm going to copy paste our HorseStore solc. We're going to call this HorseStore huff. And the only difference that we're going to do is we're going to do a function setup public override.

现在我们要做的是实际创建一个名为 HorseStore huff.t.sol 的新文件。我们想把这个放到 v1 里面。打扰一下。我实际上要复制粘贴这个。我将复制粘贴我们的 HorseStore solc。我们将其命名为 HorseStore huff。我们唯一要做的区别是我们将做一个 function setup public override。

And instead of deploying HorseStore equals new HorseStore solidity. This is where we're going to have HorseStore equals the huff edition. And this way both our solidity smart contract and our huff smart contract will run on the exact same test. Pretty badass right. So in order for us to deploy a huff smart contract in Foundry we need to use this Foundry huff Foundry extension.

我们将不使用部署 HorseStore equals new HorseStore solidity。我们将在这里使用 HorseStore equals the huff edition。这样，我们的 solidity 智能合约和我们的 huff 智能合约都将在完全相同的测试中运行。非常厉害，对吧。因此，为了在 Foundry 中部署一个 huff 智能合约，我们需要使用这个 Foundry huff Foundry 扩展。

And you can find a link to this in the GitHub repo associated with this course. So if we scroll down you obviously need huff installed but to install this in Foundry you just run this Forge install huff language Foundry huff. So let's come back over here. Let's install this. Oops. Dash dash no dash commit. And what this is going to do on the back end behind the scenes is whenever we deploy a huff smart contract it's actually going to basically run huff C you know blah blah the smart contract paste it into some file and then Foundry is going to read the free the binary and use that to deploy a smart contract.

你可以在与本课程相关的 GitHub 仓库中找到它的链接。所以如果我们向下滚动，你显然需要安装 huff，但是要在 Foundry 中安装它，你只需运行这个 Forge install huff language Foundry huff。让我们回到这里。让我们安装它。哎呀。Dash dash no dash commit。这将在后台做什么是，每当我们部署一个 huff 智能合约时，它实际上会基本上运行 huff C，你知道，智能合约，将其粘贴到某个文件中，然后 Foundry 将会读取二进制文件并使用它来部署智能合约。

So since Foundry is going to run the huff C command we have to do FFI equals true. Now remember anytime you do FFI equals true you're basically giving Foundry permission to do a whole lot of crazy stuff. So just always keep that in mind whenever you set FFI to true. And then additionally we're going to need to add some remappings. We're going to say Foundry huff equals lib slash Foundry huff slash SRC.

因此，由于 Foundry 将运行 huff C 命令，我们需要设置 FFI 等于 true。请记住，任何时候你设置 FFI 等于 true，你基本上是在给 Foundry 执行大量疯狂操作的权限。因此，无论何时将 FFI 设置为 true，请始终牢记这一点。此外，我们还需要添加一些重映射。我们将设置 Foundry huff 等于 lib slash Foundry huff slash SRC。

And now that we have Foundry huff installed we're going to import the huff deployer. So import huff deployer from Foundry huff huff deployer.sole like this. And what we can do is we can actually deploy our huff smart contract. So you can actually go ahead and read the huff solidity code base if you want to really know how it's working. But I'm just going to pretty much give you the shortcut here.

现在我们已经安装了 Foundry huff，我们将导入 huff deployer。像这样导入来自 Foundry huff huff deployer.sol 的 huff deployer。我们可以做的是，我们可以实际部署我们的 huff 智能合约。因此，如果你真的想知道它是如何工作的，你可以继续阅读 huff solidity 代码库。但我只是想在这里给你一个捷径。

We're going to say horse store equals huff deployer.config. It's one of the first things you pretty much always have to do. Dot deploy. And this is where you actually give it the file path of the horse store. So for us we're going to say string public constant horse store huff location equals. And the syntax is a little bit weird. It assumes everything's in SRC.

我们将设置 horse store 等于 huff deployer.config。这是你几乎总是需要做的第一件事。点 deploy。在这里，你实际上给它 horse store 的文件路径。因此，对于我们来说，我们将设置 string public constant horse store huff location 等于。语法有点奇怪。它假设一切都在 SRC 中。

So you don't put SRC but you have to put the file path but without huff. Without the.huff. So it's a little bit confusing. But so no SRC horse store v1 slash horse store. So we're not doing SRC slash. It just assumes it's there. And we're also not doing.huff. It assumes it's looking for a.huff file. So we'll do horse store equals huff deployer. config to deploy horse store huff location.

所以你不要放 SRC，但你必须放文件路径，但没有 huff。没有 .huff。所以这有点令人困惑。但是，所以没有 SRC，horse store v1 slash horse store。所以我们没有做 SRC slash。它只是假设它在那里。我们也没有做 .huff。它假设它正在寻找一个 .huff 文件。所以我们将设置 horse store 等于 huff deployer。config 来部署 horse store huff location。

And then we have to wrap this all up into horse store like this. Oops. Like this. And then we also need to import horse store from base test v1.t.sol. And that's it. And once we have this set up like this what's going to happen is we're going to run two suites of test horse store huff and horse store solk. And they're both going to run on every single test that we put in the base test.

然后我们必须像这样将所有这些包装到 horse store 中。哎呀。像这样。然后我们还需要从 base test v1.t.sol 导入 horse store。就这样。一旦我们像这样设置好，将会发生什么是我们将会运行两套测试，horse store huff 和 horse store solk。它们都将在我们放入 base test 中的每个测试中运行。

So now if we run forge test we should see that test run twice because it's happening in two different folders or two different files. We ran into a bug here. Right. The error was only on the huff ones. We actually forge test dash dash match path star huff star dash dash. Actually we can just do that. So this will only run forge tests on the files with huff and this one test that didn't pass.

因此，现在如果我们运行 forge test，我们应该看到该测试运行两次，因为它发生在两个不同的文件夹或两个不同的文件中。我们在这里遇到了一个错误。对。错误仅出现在 huff 文件上。我们实际上 forge test dash dash match path star huff star dash dash。实际上，我们可以这样做。因此，这将仅在带有 huff 的文件上运行 forge 测试，以及这个未通过的测试。

So let's actually do that again with dash one two three four. And we'll see why I failed here. And we're getting this error error not activated. That usually means it's defaulting to the wrong EVM version. So let's do EVM version equals Shanghai in the foundry.toml. And let's run this again and a pass. So a lot of the foundry tests actually default to Paris.

所以让我们再次使用 dash one two three four 来执行此操作。我们将看到我为什么在这里失败。我们收到此错误：错误未激活。这通常意味着它默认使用错误的 EVM 版本。因此，让我们在 foundry.toml 中设置 EVM version 等于 Shanghai。让我们再次运行它并传递。因此，许多 foundry 测试实际上默认使用 Paris。

So we just need to put in hey we want to use the latest and greatest Shanghai which has push zero. And we pass. All right. So what do we just prove. OK well we just proved something pretty simple actually in our base test. We just proved that at storage slot0 both of these start with a value of zero which is pretty trivial. Makes a lot of sense.

所以我们只需要输入，嘿，我们想使用最新最好的 Shanghai，它具有 push zero。我们通过了。好的。那么我们刚刚证明了什么。好的，实际上我们在我们的 base test 中证明了一些非常简单的事情。我们只是证明了在 storage slot0 处，这两个都以值为零开始，这非常简单。很有道理。

But we can go even deeper than that. So we can run this same test again. So I'm going to hit up a couple of times. And I can also do dash dash MT or excuse me dash dash debug paste the test name and now run it. And now we'll get popped into the debugger where we will be able to go up code by up code. We would see exactly what we would see if we were calling the smart contract and we wanted to look directly at the bytes data.

但是我们可以比这更深入。因此，我们可以再次运行相同的测试。因此，我将点击几次向上键。我也可以做 dash dash MT 或者，对不起，dash dash debug 粘贴测试名称，然后运行它。现在我们将进入调试器，在那里我们将能够逐个操作码地执行代码。如果我们正在调用智能合约，并且我们想直接查看字节数据，我们将看到我们所看到的。

So pretty cool stuff. You can see at the bottom all the different little commands you can use. So I'm just going to hit J a bunch which stands for next up code and we'll be able to go up code by up code in here. Now kind of got to zoom out a lot for this to for you to get a good eye of what's going on here. It might be a little bit small here as you're watching.

所以非常酷的东西。你可以在底部看到你可以使用的所有不同的小命令。因此，我将点击很多次 J，它代表下一个操作码，我们将能够在这里逐个操作码地执行代码。现在需要放大很多才能让你很好地了解这里发生了什么。当你观看时，这里可能有点小。

But yeah that's kind of just the way it is. But if we kind of scroll down in the code base here it'll there's a whole lot of setup that the test needs to do that we can kind of ignore. And this kind of is what one of the hard parts of working with the debugger and foundry is you want to get to that call stack of the actual contract. And we can see at the top the address that we're working with.

但是，是的，这就是它的方式。但是，如果我们在代码库中向下滚动，测试需要进行大量的设置，我们可以忽略。这有点像是使用调试器和 Foundry 的难点之一，是你想要进入实际合约的调用堆栈。我们可以在顶部看到我们正在使用的地址。

And when I hit J once more it looks like this is where we finally start working with our smart contract our actual test. And that can be kind of tricky to tell when you're actually in the in the smart contract. But looking at the function selectors here. Right. So we see some familiar stuff. We see a push for and I know it's kind of really small. We see a push for equals push to push for with some function selectors that we recognize.

当我再次点击 J 时，看起来这是我们最终开始使用我们的智能合约，我们的实际测试的地方。当你在智能合约中时，这可能有点难以分辨。但是看看这里的函数选择器。对。因此，我们看到一些熟悉的东西。我们看到一个 push for，我知道它有点小。我们看到一个 push for 等于 push to push for，带有一些我们认识的函数选择器。

Now we can pretty much pretty pretty easily say OK it looks like we're in the right code. It looks like we're making a call to our smart contract. So now if you wanted you can literally go up code by up code. You can see what's in the stack. You see what's in memory. And if you run into an issue with debugging a half smart contract you could use the foundry debugger to actually walk up code by up code through.

现在我们可以很容易地说，好的，看起来我们正在正确的代码中。看起来我们正在调用我们的智能合约。因此，现在如果你愿意，你可以逐个操作码地执行代码。你可以看到堆栈中的内容。你看到内存中的内容。如果你在调试一个 huff 智能合约时遇到问题，你可以使用 Foundry 调试器来实际逐个操作码地执行代码。

So we can actually even see what this one's doing. All right. So we have a calldata load after the calldata load. It looks like this is what's in the stack. And I know it's super super super small but it looks like it's just E0 26 C0 17. So it's going to be the function selector and then zero for the rest of the data. We have the right shift dupe one. We're checking if the function selectors match jump if OK they didn't match.

因此，我们甚至可以看到这个在做什么。好的。因此，我们在 calldata load 之后有一个 calldata load。看起来这是堆栈中的内容。我知道它非常非常非常小，但看起来它只是 E0 26 C0 17。所以它将是函数选择器，然后是零，用于剩余的数据。我们有 right shift dupe one。我们正在检查函数选择器是否匹配，如果OK则跳转，如果不匹配。

OK we're gonna go try the second function selector. Looks like they did match. Great. We're in the part of the code where we're reading the number of horses. We're S loading it. Right. And so right when we do S load it's kind of uninteresting because we S loaded zero in. But then we load that into memory and then we return. Right. And then it's running the rest of the test which is going to be some like assert equals and stuff.

好的，我们要去尝试第二个函数选择器。看起来它们匹配了。很好。我们正在读取马匹数量的代码部分。我们正在 S load 它。对。所以当我们进行 S load 时，这有点无趣，因为我们 S load 了零。但随后我们将其加载到内存中，然后返回。对。然后它运行测试的其余部分，这将是一些类似 assert equals 的东西。

So I know that was really small to see. So instead of doing the read when we test the update in our tests here we can put a number that's easier for us to see like you know maybe like 7 7 7 or something. But OK cool. So this works great. Test read value works great. Cool. Let's now do function test right value. Right. And this is just where we're going to update the number of horses.

我知道这很难看清。因此，当我们在测试中更新时，不进行读取，在我们的测试中，我们可以放一个对我们来说更容易看到的数字，比如 777 之类的。但是好的，酷。所以这很有效。测试读取值非常有效。酷。现在让我们做函数测试 write value。对。这只是我们要更新马匹数量的地方。

So we'll say you 6 number of horses equals 7 7 7 horse store update horse number because the function selector for the solidity and the half is going to be exactly the same number of horses. And then we can say assert equal or store that read number of horses should be equal to the number of horses. Now if we pull up this again let's run our test again for forged test dash dash match path huff dash dash debug test right value.

所以我们会说 uint256 number of horses 等于 777 horse store update horse number，因为 solidity 和 Huff 的函数选择器将完全相同。然后我们可以说 assert equal or store that read number of horses 应该等于 number of horses。现在，如果我们再次调出这个，让我们再次运行我们的测试 forge test --match-path huff --debug testRightValue。

We'll be able to walk through the opcodes and hopefully we'll be able to spot this. What is it. This 7 7 7. So if I pull up a new terminal here real quick and do cast to base 7 7 7 hex we're looking for a 0 x 3 0 9. That's going to be the 7 7 7. So I'm going to zoom out a little bit. Sorry I know it's super tiny and hold down J. I'm going to look for functions selectors that match or that 7 7 7.

我们将能够逐步执行操作码，并希望我们能够发现这一点。它是什么。这个 777。所以如果我在这里快速打开一个新的终端，执行 cast to base 777 hex，我们正在寻找 0x309。这将是 777。所以我将缩小一点。抱歉，我知道它非常小，按住 J。我将寻找匹配或包含 777 的函数选择器。

Remember all of these opcodes are like foundry set up right. The test has to get set up. The tests have to get called. We're deploying our half. We're doing a whole bunch of stuff here. And OK. Cool. Looks like we jumped to the contract. There's some function selectors here that I recognize. OK. Cool. So we have a push for equals push to jump if jump test. It looks like we did indeed jump.

记住，所有这些操作码都像是 Foundry 设置，对吧。测试必须进行设置。测试必须被调用。我们正在部署我们的 Huff。我们在这里做了一大堆事情。好的。酷。看起来我们跳转到了合约。这里有一些我认识的函数选择器。好的。酷。所以我们有一个 push for equals push to jump if jump test。看起来我们确实跳转了。

And by here in the opcodes at this jump destination we should be at the set number of horses jump destination right here. So this jump destination here should be the beginning of our set number of horses. OK. We have a push calldata load push for calldata load. That looks pretty promising right. Push for calldata load. That looks good. Then we do push 0 S store.

并且在这里的操作码中，在这个跳转目标处，我们应该位于 set number of horses 的跳转目标处。所以这里的跳转目标应该是我们的 set number of horses 的开始。好的。我们有一个 push calldata load push for calldata load。这看起来很有希望，对吧。Push for calldata load。这看起来不错。然后我们执行 push 0 S store。

So let's look on our stack right now. So at the top of the stack is 0. The second piece on the stack is going to be 3 0 9. Oh OK. So at the bottom of the stack we have it looks like a function selector. And then once we did calldata load it looks like we see 3 0 9 which is going to be that 7 7 7. So when we called S store with 0 and 7 7 7 we're basically saying we want to store at the 0 with slot the 7 7 7 and then we're going to stop.

所以让我们现在看看我们的堆栈。所以在堆栈的顶部是 0。堆栈上的第二项将是 309。哦，好的。所以在堆栈的底部，我们有一个看起来像函数选择器的东西。然后一旦我们执行了 calldata load，看起来我们看到了 309，这将是 777。所以当我们用 0 和 777 调用 S store 时，我们基本上是说我们想在插槽 0 处存储 777，然后我们将停止。

And that's the end of the call. Right. And then we're going to do some asserts. That's gonna be what the rest of these opcodes are. So I know that was kind of quick and there was a lot to that. But I want you to play with the debugger a lot just like we did there and try to figure out where you are in the execution. Just remember whenever you run one of these tests it needs to do all the opcodes associated with the setup with the setup with the getting the values here with the asserts etc.

这就是调用的结束。对。然后我们将进行一些断言。这将是其余操作码的作用。我知道这有点快，而且有很多内容。但我希望你多玩玩调试器，就像我们刚才做的那样，并尝试找出你在执行中的位置。请记住，每当你运行这些测试之一时，它都需要执行与设置相关的所有操作码，获取此处的值以及断言等。

Definitely practice using the debugger to actually see OK when are we testing 7 7 7 because this will give you the power to actually you know read opcodes. So just try to recognize where the 7 7 7 is look for that 3 0 9 in those opcodes and then you can be like boom. I found it. I'm an opcode wizard Jesus. But OK cool. So we've written two real minimal tests.

一定要练习使用调试器来实际查看，好的，我们什么时候测试 777，因为这将使你能够实际读取操作码。所以只需尝试识别 777 的位置，在这些操作码中寻找 309，然后你就可以说，砰。我找到了。我是操作码巫师。但是好的，酷。所以我们编写了两个真正的最小测试。

I'm just gonna leave them like this for now because reading and writing is really all that we're doing. However if you look at the Git repo associated with this course we do take a slightly different approach and you can do whatever approach that you want here in the GitHub repo here. We actually do a little bit more formal differential tests where we actually deploy the huff the Yul and the sulk version and then at the bottom we basically compare them to each other which is another way to really just make sure that they're the same.

我现在就让它们保持这样，因为读取和写入实际上就是我们所做的一切。但是，如果你查看与本课程相关的 Git 仓库，我们确实采取了一种稍微不同的方法，你可以在这里的 GitHub 仓库中做任何你想要的方法。我们实际上做了一些更正式的差异测试，我们实际上部署了 Huff、Yul 和 Solidity 版本，然后在底部，我们基本上将它们相互比较，这是另一种真正确保它们相同的方法。

And then we use some fuzzing instead of direct values. So we probably would want to do the same thing here. So we would do youint256 number of horses as a fuzzing parameter do the exact same thing. Right. And now we can just run forged test and now we'll fuzz both of these contracts so that they are looking good and they look equal. So so it looks good. Pass everything looks good. Passes everything.

然后我们使用一些模糊测试而不是直接值。所以我们可能想在这里做同样的事情。所以我们会将 uint256 number of horses 作为一个模糊测试参数，做完全相同的事情。对。现在我们可以运行 forge test，现在我们将模糊测试这两个合约，以便它们看起来良好并且看起来相等。所以看起来不错。通过，一切看起来都不错。通过所有测试。

So one more thing in this huff we could do some malicious stuff. Right. Set number of horses. What if instead of 0x4 we put 0x2 in here. Right. Now we run the tests. They're probably going to fail. Right. And sure enough they do fail. Right. Because it's not the correct offset of the calldata. We can put the wrong storage slot in the read. Right. Same thing.

所以在这个 Huff 中还有一件事，我们可以做一些恶意的事情。对。Set number of horses。如果我们将 0x2 放在这里而不是 0x4 会怎么样。对。现在我们运行测试。它们可能会失败。对。果然，它们确实失败了。对。因为它不是 calldata 的正确偏移量。我们可以将错误的存储槽放在读取中。对。同样的事情。

If we run the tests this is going to fail again. There's lots of ways to very subtly mess this up and fail your tests and especially lots of ways for your huff to go wrong or do something unexpected. This is why if you are going to write low level assembly low level huff etc. It's highly highly recommended you use stateful fuzzing state less fuzzing and maybe even formal verification to prove that your huff your low level code matches your solidity code.

如果我们运行测试，这将再次失败。有很多方法可以非常巧妙地搞砸这一点并使你的测试失败，特别是你的 Huff 有很多方法可以出错或做一些意想不到的事情。这就是为什么如果你要编写底层汇编、底层 Huff 等。强烈建议你使用有状态模糊测试、无状态模糊测试，甚至形式化验证来证明你的 Huff，你的底层代码与你的 Solidity 代码匹配。

And later on the course of course we're going to teach you formal verification so that you can actually do what we're working with here.

当然，在本课程的后面，我们将教你形式化验证，以便你实际做我们在这里所做的事情。