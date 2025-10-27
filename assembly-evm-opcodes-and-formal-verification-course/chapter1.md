
    Alright, so here we are in our VS code, our opcodes FV. For this course, I do have GitHub pilot installed and set to on for this. And I do highly recommend you coding along with an AI extension or an AI buddy. I promise you it's going to make you so much faster.If there is a VS code extension that is AI friendly, that's not GitHub copilot. I recommend that as well because Microsoft is kind of dominating right now. 
    好的，我们现在在 VS Code 中，这是我们的 opcodes FV。在本课程中，我确实安装了 GitHub Copilot 并将其设置为开启。我强烈建议你使用 AI 扩展或 AI 助手一起编写代码。我保证这会让你快很多。如果有一个对 AI 友好的 VS Code 扩展，但不是 GitHub Copilot。我也推荐它，因为微软现在有点占主导地位。


---      
      And that's a little spooky to me, but beside the point.

      这让我有点害怕，但这不是重点。

---

      So let's go ahead.

      那么让我们开始吧。

---

      Let's open up our terminal.

      让我们打开终端。

---

      Let's create a new folder.

      让我们创建一个新文件夹。

---

      So MKDIR one horse store or whatever you want to call it.

      所以 MKDIR one horse store 或者任何你想叫的名字。

---

      Let's open that up like this.

      让我们像这样打开它。

---

      And I have an issue in VS code for why that keeps coming up.

      我在 VS Code 中遇到了一个问题，不知道为什么它一直出现。

---

      Looks like Max are having an issue as a recording and now we're in a new folder here.

      看起来 Max 在录制时遇到了问题，现在我们在这里创建了一个新文件夹。

---

      We're going to forge and it's of course you know the drill.

      我们将使用 Forge，当然，你知道该怎么做。

---

      Set up our new Foundry project and great.

      设置我们的新 Foundry 项目，太棒了。

---

      We have Foundry set up here, so let's pop over to the readme, delete everything and let's set out for our first task, which is going to be really easy.

      我们在这里设置了 Foundry，所以让我们转到 readme 文件，删除所有内容，然后开始我们的第一个任务，这将非常容易。

---

      Write a basic simple storage slash horse store contract.

      编写一个基本的 simple storage / horse store 合约。

---

      And if you want, you can even go right to the GitHub associated with this and you can just go to SRC, horse store V1, horsestore.sol and copy this.

      如果你愿意，你甚至可以直接去 GitHub 与此相关的，你可以直接去 SRC，horse store V1，horsestore.sol 并复制它。

---

      And you know what? I'm even just going to do that because it's really simple.

      你知道吗？我甚至就打算这么做，因为它真的很简单。

---

      Let's delete all these. Delete. Goodbye.

      让我们删除所有这些。删除。再见。

---

      In SRC we're going to make a new folder. Horse store V1 and in here new file horsestore.sol.

      在 SRC 中，我们将创建一个新文件夹。Horse store V1，在这里新建文件 horsestore.sol。

---

      I'm going to paste this in here.

      我将在这里粘贴它。

---

      Now additionally, if you're going through this code base, we also in the V1 section we have this horse store symbolic.t.sol.

      此外，如果你正在浏览此代码库，我们也在 V1 部分有这个 horse store symbolic.t.sol。

---

      For this section, we're actually not going to be doing this, but actually in the next section we're going to come back to horse store to actually set up a real minimalistic symbolic execution or formal verification test.

      在本节中，我们实际上不会这样做，但实际上在下一节中，我们将回到 horse store 来实际设置一个真正的极简符号执行或形式验证测试。

---

      So if you see this in the code base and you're like, what the heck is that? Don't worry about this until the next section, the math masters section, where we're going to introduce you to formal verification.

      所以如果你在代码库中看到这个，你会想，这到底是什么？在下一节，即数学大师节之前，不要担心这个，在那里我们将向你介绍形式验证。

---

      So if this is looking like gibberish to you, you need to go back and you need to finish the advanced foundry section or even the basic solidity section.

      所以如果这对你来说看起来像乱码，你需要回去，你需要完成高级 Foundry 部分或甚至是基本的 Solidity 部分。

---

      This should be very familiar to you.

      这对你来说应该非常熟悉。

---

      Like I said, we have a storage variable up here, number of horses.

      就像我说的，我们这里有一个存储变量，马的数量。

---

      We have an update function, a way to update it, and we have a rate way to read it.

      我们有一个更新函数，一种更新它的方法，我们有一种读取它的方法。

---

      So from a solidity perspective, this is incredibly minimal code.

      所以从 Solidity 的角度来看，这是非常少的代码。

---

      However, if we pull up our terminal and we do forge build, this should work.

      但是，如果我们打开终端并执行 forge build，这应该可以工作。

---

      We get successful.

      我们得到了成功。

---

      We can now come to the out folder, go into the horse store.json.

      我们现在可以来到 out 文件夹，进入 horse store.json。

---

      And I'm actually going to do, pull up the command palette here with command shift P, or you can also do view command palette or whatever it is, or just Google how to pull up the command palette on VS code.

      我实际上要做的是，调出命令面板，使用 command shift P，或者你也可以执行 view 命令面板或任何东西，或者只是谷歌如何调出 VS Code 上的命令面板。

---

      And I'm going to do format document, just so that the JSON kind of forms nicely.

      我将执行格式化文档，以便 JSON 格式良好。

---

      And then I'm also going to pull up the command palette and do toggle word wrap, which makes it look horrible, but it'll help us a lot.

      然后我还将调出命令面板并执行切换自动换行，这使它看起来很糟糕，但它会帮助我们很多。

---

      So this is our horse store.json. So this is really the output of our compiler.

      所以这是我们的 horse store.json。所以这实际上是我们的编译器的输出。

---

      This is all this stuff.

      这就是所有这些东西。

---

      Obviously, we have the ABI, we're going to minimize that.

      显然，我们有 ABI，我们将最小化它。

---

      And then we have the bytecode, which is really what we're gonna be looking at, the deployed bytecode, method identifiers, and then some other stuff.

      然后我们有 bytecode，这实际上是我们将要查看的内容，已部署的 bytecode，方法标识符，然后是一些其他的东西。

---

      There's a whole bunch of stuff in here, but whatever.

      这里有很多东西，但随便吧。

---

      This bytecode and this bytecode is what we're going to be looking at both of these bytecodes.

      这个 bytecode 和这个 bytecode 是我们要查看的这两个 bytecode。

---

      And they do something different.

      它们做的事情不同。

---

      If you followed along in Cypher and updraft, we've kind of told you what the differences in these are, but we'll make it a little bit more clear in a minute.

      如果你一直在关注 Cypher 和 updraft，我们已经告诉你了这些差异是什么，但我们会在一分钟内更清楚一点。

---

      Now, in any smart contract, when it's created, or when you send a transaction to it, you're always sending this calldata or working with this calldata.

      现在，在任何智能合约中，当它被创建时，或者当你发送一个交易给它时，你总是发送这个 calldata 或使用这个 calldata。

---

      You're always sending raw bytes, raw data to the blockchain.

      你总是将原始字节，原始数据发送到区块链。

---

      And if you scroll down into the transaction, you can see we just view the original of this transaction.

      如果你向下滚动到交易中，你可以看到我们只是查看此交易的原始数据。

---

      This is exactly what was sent to the blockchain.

      这正是发送到区块链的内容。

---

      So when I send a transaction, we're going to have all this calldata, right?

      所以当我发送一个交易时，我们将拥有所有这些 calldata，对吗？

---

      And this could, this data could be literally anything.

      这可以，这些数据可以实际上是任何东西。

---

      We're assuming the smart contract that we send this calldata to has a way to process or understand what this calldata is supposed to do.

      我们假设我们发送此 calldata 的智能合约有一种方法来处理或理解此 calldata 应该做什么。

---

      And if we look at a contract and we scroll all the way to the bottom, we see all this hex, all this random data down here.

      如果我们看一个合约，我们一直滚动到最底部，我们看到所有这些十六进制，所有这些随机数据都在这里。

---

      It's this random data.

      就是这些随机数据。

---

      It's all this hex that's responsible for processing that calldata and governing what the smart contract actually does.

      正是所有这些十六进制负责处理该 calldata 并控制智能合约实际执行的操作。

---

      It's all of this hex that makes up the different opcodes or the machine readable instructions.

      正是所有这些十六进制构成了不同的操作码或机器可读指令。

---

      Every one byte or every two characters in this hex essentially makes up an opcode.

      此十六进制中的每个字节或每两个字符本质上构成一个操作码。

---

      There's some exceptions when you like push raw values in the stack, but we'll talk about that later.

      当你喜欢将原始值压入堆栈时，有一些例外，但我们稍后再谈。

---

      We as human beings are terrible at understanding machine level code.

      我们人类不擅长理解机器级代码。

---

      We don't really know how zero and ones work.

      我们不太了解零和一是如何工作的。

---

      We don't know how to work with thousands of transistors at a time.

      我们不知道如何一次处理数千个晶体管。

---

      We don't really know how to send instructions to transistors very easily.

      我们不太清楚如何轻松地向晶体管发送指令。

---

      So when we write code, we write it in what's called higher level languages like solidity that are more easy for human beings to understand machines.

      因此，当我们编写代码时，我们用所谓的更高级的语言编写，例如 Solidity，这更容易让人类理解机器。

---

      However, don't understand solidity.

      但是，机器不理解 Solidity。

---

      They understand machine code at the lowest level.

      它们在最低级别理解机器代码。

---

      The Ethereum virtual machine is exactly that it's a machine.

      以太坊虚拟机正是如此，它是一台机器。

---

      And so in order for it to do anything, it needs very specific instructions that tell it, Hey, put this data in storage.

      因此，为了让它做任何事情，它需要非常具体的指令告诉它，嘿，把这个数据放到存储中。

---

      Hey, put this data in memory.

      嘿，把这个数据放到内存中。

---

      Hey, put this data in the stack.

      嘿，把这个数据放到堆栈中。

---

      We'll learn about the stack later, et cetera.

      我们稍后会学习堆栈，等等。

---

      And it's all of these and all of these machine readable instructions are also known as op codes.

      所有这些以及所有这些机器可读指令也称为操作码。

---

      So this Ethereum virtual machine that you've heard a lot about before this magical thing that doesn't really exist.

      所以你之前听说过的以太坊虚拟机这个实际上并不存在的魔法事物。

---

      However, it's implemented.

      但是，它已经实现了。

---

      So the Ethereum virtual machine is, is this fake machine that says, okay, when you send data to the blockchain to Ethereum, convert that to, you know, send money, send tokens or whatever.

      所以以太坊虚拟机是，是这个虚假的机器，它说，好的，当你将数据发送到以太坊区块链时，转换该数据为，你知道，发送金钱，发送代币或任何东西。

---

      And all of those instructions of the Ethereum virtual machine are in these op codes, these op codes for the EVM.

      以太坊虚拟机的所有这些指令都在这些操作码中，这些 EVM 的操作码。

---

      So whenever you say, for example, Hey, store the number seven at storage slot0, there's a set of op codes that are going to do that.

      所以无论何时你说，例如，嘿，将数字 7 存储在存储槽 0 中，都有一组操作码将执行该操作。

---

      They're a set of machine readable codes.

      它们是一组机器可读代码。

---

      It's all these op codes combined that make up the EVM op codes are machine readable codes.

      正是所有这些操作码的组合构成了 EVM 操作码，操作码是机器可读代码。

---

      And it's the combination of all these op codes that make up the EVM.

      正是所有这些操作码的组合构成了 EVM。

---

      So the EVM is really just this agreed upon set of op codes that we say does stuff.

      所以 EVM 实际上只是这组约定的操作码，我们说它会做一些事情。

---

      It's a virtual machine because there's technically no like Ethereum machine.

      它是一个虚拟机，因为从技术上讲，没有像以太坊机器这样的东西。

---

      Whenever you run a node, your computer actually pretends to be this stack machine, this Ethereum virtual machine.

      每当你运行一个节点时，你的计算机实际上会假装成这个堆栈机，这个以太坊虚拟机。

---

      Don't worry about that too much for now.

      现在不要太担心这个。

---

      Op codes are these very specific machine level instructions.

      操作码是这些非常具体的机器级指令。

---

      And you can see a list of them.

      你可以看到它们的列表。

---

      If you go to the ethereum.org website, op codes are pretty common in computer science is also known as instruction, machine code, instruction code, instruction, syllable.

      如果你去 ethereum.org 网站，操作码在计算机科学中非常常见，也称为指令、机器代码、指令代码、指令、音节。

---

      There's a ton of different words for it.

      有很多不同的词来形容它。

---

      Op codes in general are very common in computer science as a whole.

      总的来说，操作码在整个计算机科学中非常常见。

---

      However, in the smart contracts themselves, these need to be a set of these op codes, these need to be a set of these machine readable instructions.

      但是，在智能合约本身中，这些需要是一组这些操作码，这些需要是一组这些机器可读指令。

---

      So that when we do send calldata, when we do send data to the smart contracts, they have a way to actually interpret the calldata and work with the calldata.

      所以当我们发送 calldata，当我们发送数据到智能合约时，它们有一种方法可以实际解释 calldata 并使用 calldata。

---

      And if we scroll all the way down to the bottom, we can see the actual contract creation code, we can see deployed bytecode, etc.

      如果我们一直滚动到底部，我们可以看到实际的合约创建代码，可以看到部署的 bytecode 等。

---

      And all of these in the contract creation code and deployed bytecode is going to be op codes.

      所有这些在合约创建代码和部署的 bytecode 中都将是 op codes。

---

      Typically, each two of these digits is going to be a so this six zero at the start of this contract, we can actually copy this.

      通常，每两个数字将是一个，所以这个合约开头的 60，我们实际上可以复制它。

---

      And I'm going to go to one of my favorite sites for learning about op codes, evm codes, I can paste that 60 in and I can see what the 60 stands for.

      我将前往我最喜欢的网站之一学习 op codes，EVM codes，我可以粘贴 60 进去，然后我可以看看 60 代表什么。

---

      So the 60 op code, which, which again is going to be the hex, so we can do cast to base OX six deck, which is the 96 op code, or we can see the binary, this is what the binary of that op code looks like.

      所以 60 op code，它，再次强调，将是十六进制，所以我们可以转换为 OX six deck，也就是 96 op code，或者我们可以看到二进制，这就是该 op code 的二进制形式。

---

      So this 60 op code stands for the push one op code, which is going to place one byte item onto the stack, we'll learn what the stack is in a little bit, but there's going to be some familiar op codes in here, like m store and s store and s load and m load, right, we've learned about those in the Foundry full course when learning about some gas optimizations.

      所以这个 60 op code 代表 push one op code，它会将一个字节的项目放到堆栈上，我们稍后会学习什么是堆栈，但是这里会有一些熟悉的 op codes，比如 m store 和 s store 和 s load 和 m load，对吧，我们在 Foundry full course 中学习 gas 优化时了解过这些。

---

      So this contract is just this massive set of these op codes, which essentially tell our machines exactly how to process this calldata that gets sent to them.

      所以这个合约只是这些 op codes 的一个巨大的集合，它本质上告诉我们的机器如何精确地处理发送给它们的 calldata。

---

      In the Ethereum world, we can actually change or add op codes through the Ethereum improvement proposals.

      在以太坊世界中，我们实际上可以通过以太坊改进提案来更改或添加 op codes。

---

      As of recording a few months ago, they added the push zero op code, which was awesome.

      在几个月前录制时，他们添加了 push zero op code，这太棒了。

---

      So just to recap, in a smart contract, a smart contract is going to be a set of op codes combined, where in the contract code, every two of these hexes stands for one byte.

      所以简单回顾一下，在智能合约中，智能合约是一组 op codes 的组合，其中在合约代码中，每两个十六进制数代表一个字节。

---

      And each op code is one byte long.

      每个 op code 都是一个字节长。

---

      And we can see what each one of these op codes does.

      我们可以看到每个 op code 的作用。

---

      Again, there are going to be some scenarios where it's not every two, because for example, we could do like push four where we place four bytes onto the stack.

      同样，在某些情况下，不是每两个，因为例如，我们可以执行 push four，我们将四个字节放到堆栈上。

---

      So we would see like a 63 and then four bytes instead of two op codes back to back, right.

      所以我们会看到像 63 这样的东西，然后是四个字节，而不是两个 op codes 背靠背，对吧。

---

      So but don't worry about that too much for now.

      所以，但现在不用太担心。

---

      Main thing is, boom, this is an op code 60 stands for push 160 stands for push one, boom, 60.

      最重要的是，砰，这是一个 op code，60 代表 push 1，60 代表 push one，砰，60。

---

      This is not an op code, this is going to be how much is going to be pushed to the stack.

      这不是一个 op code，这将是多少将被推送到堆栈。

---

      This is an op code 52 is another op code, which stands for m store.

      这是一个 op code，52 是另一个 op code，代表 m store。

---

      So lots of op codes.

      所以有很多 op codes。

---

      If this isn't making sense to you right now, it's okay, it will.

      如果这现在对你来说没有意义，没关系，它会的。

---

      Okay, now that we've learned about op codes, we're actually going to go ahead and rewrite our horse store.sol into huff.

      好的，现在我们已经了解了 op codes，我们实际上要继续将我们的 horse store.sol 重写为 huff。

---

      Why are we learning huff?

      我们为什么要学习 huff？

---

      Well, again, if you learn huff, surprisingly, all of this EVM op code stuff just becomes easier because it really becomes easy to see how these smart contracts work at the lowest level.

      嗯，再说一次，如果你学习 huff，令人惊讶的是，所有这些 EVM op code 的东西变得更容易了，因为它真的很容易看到这些智能合约如何在最低级别上工作。

---

      So let's go ahead and get started working with and installing huff.

      所以让我们开始使用和安装 huff。

---

      In order for us to install huff, we need to install the huff documentation.

      为了安装 huff，我们需要安装 huff 文档。

---

      If you're following along with the course GitHub, we scroll down into our curriculum, we have a link to the huff documentation right in the GitHub there.

      如果你正在关注课程 GitHub，我们向下滚动到我们的课程中，我们在 GitHub 中有一个指向 huff 文档的链接。

---

      And this is the huff documentation, you can go ahead and go to the getting started and follow along with the docs here in order to install huff.

      这是 huff 文档，你可以继续前往入门指南，并按照此处的文档进行操作以安装 huff。

---

      I find that the easiest way to install huff is to first install this huff up command.

      我发现安装 huff 最简单的方法是首先安装这个 huff up 命令。

---

      And all we need to do to install it is to run this, run this command, which will download this sh bit, and then run bash on it.

      我们安装它所需要做的就是运行这个，运行这个命令，它将下载这个 sh bit，然后在其上运行 bash。

---

      So I'm going to go ahead and install huff up by pasting this into your terminal.

      所以我要通过将此粘贴到你的终端中来安装 huff up。

---

      Great.

      太棒了。

---

      And after this run successfully, again, you'll probably need a Linux like environment in order to do this, you'll get an output that looks something like detected your preferred shell is bash and added huff to your path, and it'll add this to your bash RC.

      在此成功运行后，同样，你可能需要像 Linux 这样的环境才能做到这一点，你将获得一个看起来像检测到你首选的 shell 是 bash 并将 huff 添加到你的路径的输出，它会将其添加到你的 bash RC。

---

      So you need to run this command first, and then run huff up to install the huff compiler.

      所以你需要先运行这个命令，然后运行 huff up 来安装 huff 编译器。

---

      Once huff up is done, you should be able to do huff, huff C dash dash version, and get an output that looks like this.

      一旦 huff up 完成，你应该能够执行 huff，huff C dash dash version，并获得一个看起来像这样的输出。

---

      Now depending on the shell that you're working with, you want to make sure that it actually was correctly added to your your bash RC, your bash profile or your ZCH or whatever config file that your shell works with.

      现在，根据你正在使用的 shell，你想要确保它实际上已正确添加到你的 bash RC，你的 bash profile 或你的 ZCH 或你的 shell 使用的任何配置文件。

---

      So I want you to go ahead and actually delete your shell by hitting a little trash can or closing out of the terminal or whatever, pulling it back up and then doing huff C dash dash version again.

      所以我想让你继续删除你的 shell，通过点击一个小垃圾桶或关闭终端等，将其拉回并再次执行 huff C dash dash version。

---

      If you don't get an output here, but you got an output last time, that means that huff wasn't correctly added to your bash RC or your bash profile or your ZCH or whatever terminal you're working with config file.

      如果你在这里没有得到输出，但上次得到了输出，这意味着 huff 没有正确添加到你的 bash RC 或你的 bash profile 或你的 ZCH 或你正在使用的任何终端配置文件。

---

      If you're running into issues here, this is a great time to chat with ChatGPT, Google around, figure out exactly what's going on here.

      如果你在这里遇到问题，这是一个很好的时机与 ChatGPT 聊天，在 Google 上搜索，弄清楚这里到底发生了什么。

---

      If you're not using WSL, you can of course use the Windows installation or whatever installation process you want here.

      如果你不使用 WSL，你当然可以使用 Windows 安装或你想要的任何安装过程。

---

      But remember, installing stuff is often the most frustrating part of development work.

      但请记住，安装东西通常是开发工作中最令人沮丧的部分。

---

      So don't get too frustrated if it doesn't work right away and be sure to Google around and ask your AI buddies for help.

      所以如果它没有立即工作，不要太沮丧，并且一定要在 Google 上搜索并向你的 AI 伙伴寻求帮助。

---

      Or of course, come to the GitHub discussions associated with this course.

      或者，当然，可以参加与本课程相关的 GitHub 讨论。

---

      As we're coding along here, be sure to use the docs as a reference guide as well, because the docs are going to be the most up to date.

      当我们在这里进行编码时，请务必使用文档作为参考指南，因为文档将是最新的。

---

      The docs are incredibly helpful, and there's a whole ecosystem around the huff code bases.

      这些文档非常有用，并且围绕 huff 代码库有一个完整的生态系统。

---

      But great.

      但是太棒了。

---

      Now that we have huff C installed, we can actually start writing some huff smart contracts.

      现在我们已经安装了 huff C，我们可以开始编写一些 huff 智能合约。

---

      Let's actually rewrite our horse store in huff and rewriting it in huff will actually teach us how smart contracts work at the lowest level and will teach us a ton about these opcodes.

      让我们实际上用 huff 重写我们的 horse store，用 huff 重写它实际上会教我们智能合约如何在最低级别上工作，并且会教我们很多关于这些 opcodes 的知识。

---

      To get started rewriting our smart contract in huff, let's go ahead and create a new file.

      要开始用 huff 重写我们的智能合约，让我们继续并创建一个新文件。

---

      We'll call it horse store.huff.

      我们将其命名为 horse store.huff。

---

      And what's cool is now that we're, and what's cool about this is because we have these two smart contracts should be exactly the same.

      很酷的是，现在我们，这件事很酷的是因为我们有两个智能合约应该完全相同。

---

      This one just written in a different language.

      这个只是用不同的语言编写的。

---

      When we actually go to write tests, we can write one suite of tests and just apply it to both contracts.

      当我们实际去编写测试时，我们可以编写一套测试，然后将其应用于两个合约。

---

      This is also known as differential testing.

      这也称为差异测试。

---

      And if done with fuzzing, it's sometimes called differential fuzzing.

      如果使用模糊测试完成，有时称为差异模糊测试。

---

      And it's incredibly powerful for people looking to build code bases in solidity, and then optimize them in a much faster, much more powerful lower level language like huff.

      对于希望在 Solidity 中构建代码库，然后在更快、更强大的像 huff 这样的低级语言中优化它们的人来说，它非常强大。

---

      You write your main smart contracts in solidity, so they're easier to read easier to understand.

      你用 Solidity 编写你的主要智能合约，所以它们更容易阅读，更容易理解。

---

      And then you either formally verify or you fuzz them against your gas optimized edition that you actually deployed to the blockchain.

      然后你要么形式化验证，要么针对你实际部署到区块链的 gas 优化版本进行模糊测试。

---

      But anyways, let's get started working with huff here.

      但无论如何，让我们开始在这里使用 huff。

---

      Now when we work with a solidity smart contract, let's say we deployed this contract on chain.

      现在，当我们使用 Solidity 智能合约时，假设我们在链上部署了这个合约。

---

      If I call the function read number of horses, we almost kind of magically get it to return this number of horses.

      如果我调用函数 read number of horses，我们几乎有点神奇地让它返回这个马的数量。

---

      You know, for example, if I had deployed this smart contract, this our horse store in remix, right, I deployed it down here, I do read number, we almost kind of magically get the response zero back when I call one to update the number of horses and rerun.

      你知道，例如，如果我部署了这个智能合约，这个我们的 horse store 在 remix 中，对吧，我在这里部署了它，我执行 read number，我们几乎有点神奇地得到了响应零，当我调用 one 来更新马的数量并重新运行时。

---

      Sorry, I was kind of zoomed out.

      抱歉，我有点缩小了。

---

      But you get the picture.

      但你明白了。

---

      When I call read number of horses, I very almost magically get this one to get returned to us.

      当我调用 read number of horses 时，我几乎神奇地得到了这个 one 返回给我们。

---

      But when we actually make this call, when we actually make any call, if I actually call update number of horses again, in remix, and we can see this in founder two, you know that we actually send the input that we sent is actually a whole bunch of binary itself a whole bunch of just data itself.

      但是当我们实际进行此调用时，当我们实际进行任何调用时，如果我实际上再次调用 update number of horses，在 remix 中，我们可以在 founder two 中看到这一点，你知道我们实际发送的输入实际上是一大堆二进制本身就是一大堆数据本身。

---

      So if I copy this binary of the input of update horse, put a little comment here, paste it, it's actually this kind of ridiculous jumble of numbers.

      所以如果我复制更新马匹的输入的这个二进制文件，在这里加一点注释，粘贴一下，实际上是这种荒谬的数字组合。

---

      When we call update horse number, and we add a value here, this data that gets input to the smart contract is called the calldata.

      当我们调用 update horse number，并且在这里添加一个值时，输入到智能合约的这个数据被称为 calldata。

---

      So this whole thing is the calldata.

      所以整个东西就是 calldata。

---

      And it's this calldata that tells our smart contract, hey, this is what I want you to do.

      正是这个 calldata 告诉我们的智能合约，嘿，这个是我希望你做的事情。

---

      So how does Solidity know that this jumble of numbers tells the EVM tells our smart contract, hey, update that number of horses, this jumble of letters.

      那么 Solidity 怎么知道这堆数字告诉 EVM 告诉我们的智能合约，嘿，更新马匹的数量，这堆字母。

---

      So we have two questions here.

      所以我们这里有两个问题。

---

      How do Remix know that when we press this update number of horses to send this exact data string to our smart contract?

      Remix 怎么知道当我们按下这个更新马匹数量的按钮时，会发送这个精确的数据字符串到我们的智能合约？

---

      And then number two, how does Remix even know to update this storage variable with this jumble of binary bytes data?

      然后第二个问题，Remix 怎么知道用这堆二进制字节数据来更新这个存储变量？

---

      Like how did this happen?

      这是怎么发生的？

---

      So these are the two questions that we're going to answer now.

      所以这是我们现在要回答的两个问题。

---

      And we're going to answer them by learning Huff.

      我们将通过学习 Huff 来回答这些问题。

---

      Let's start by answering this first question.

      让我们从回答第一个问题开始。

---

      Where did this data come from?

      这些数据从哪里来的？

---

      Now, if you've taken the Foundry advanced course, you know what a function selector is, you know, we have this update horse number and a uint256.

      现在，如果你参加过 Foundry 高级课程，你就知道什么是函数选择器（function selector）了，你知道，我们有这个 update horse number 和一个 uint256。

---

      The two of these are the function signature, and we can hash them to make the function selector.

      这两个是函数签名（function signature），我们可以哈希它们来生成函数选择器。

---

      So if I do cast sig, update number, update horse number, uint256, I get this OXCDFEA2E or whatever it is, right?

      所以如果我执行 cast sig, update number, update horse number, uint256, 我会得到这个 OXCDFEA2E 或者其他什么，对吧？

---

      Let me actually copy copy paste this from Remix.

      让我实际上从 Remix 复制粘贴这个。

---

      So this as we can see, actually matches the first part of this huge chunk of data that was sent in.

      所以我们可以看到，这实际上匹配了发送进来的这大块数据的第一部分。

---

      So this is what's known as the function selector, right?

      所以这就是所谓的函数选择器，对吧？

---

      So when we send this data to our smart contract, we're saying, Hey, use the function that has the selector.

      所以当我们发送这个数据到我们的智能合约时，我们是在说，嘿，使用具有该选择器的函数。

---

      So this CDFEA2E matches right here.

      所以这个 CDFEA2E 正好匹配这里。

---

      So somehow solidity knows our smart country knows to take the first four bytes of the calldata and use that to actually pick which function we're referring to.

      所以 solidity 知道，我们的智能合约知道获取 calldata 的前四个字节，并用它来实际选择我们指的是哪个函数。

---

      This is actually called function dispatching.

      这实际上被称为函数分发（function dispatching）。

---

      And it's something that solidity does natively for us.

      这是 solidity 为我们原生做的事情。

---

      So there's no code in here that basically says, you know, if the calldata has four bytes that match the update horse number function selector, you should call it doesn't have that.

      所以这里没有代码基本上说，你知道，如果 calldata 有四个字节匹配 update horse number 函数选择器，你应该调用它，它没有那个。

---

      It does that natively for us when it compiles.

      它在编译时为我们原生完成。

---

      Now, instead of update horse number, we do cast sig read number of horses.

      现在，如果我们不用 update horse number，而是执行 cast sig read number of horses。

---

      This would be the function selector, right?

      这将是函数选择器，对吧？

---

      And so when we send this calldata to our smart contract, our smart contract goes, Ah, okay, I'm going to dispatch your function call to read number of horses, because that's what your function selector tells me to do.

      所以当我们发送这个 calldata 到我们的智能合约时，我们的智能合约会说，啊，好的，我将分发你的函数调用到 read number of horses，因为那是你的函数选择器告诉我要做的。

---

      So again, this happens on the back end for solidity, solidity sets up this function dispatching for us.

      所以再次说明，这发生在 solidity 的后端，solidity 设置这个函数分发为我们。

---

      But if we're going to write our smart contract in pure opcodes, which essentially is what Huff does, we actually have to write that function dispatcher ourself.

      但是如果我们要在纯操作码（opcode）中编写我们的智能合约，这本质上就是 Huff 所做的，我们实际上必须自己编写那个函数分发器。

---

      So this is already one of the most powerful things that we can learn right from working with Huff is function dispatching.

      所以这已经是我们可以从使用 Huff 中学到的最强大的东西之一，就是函数分发。

---

      So again, the flow will look like we send the calldata, our smart contract reads our calldata and goes, Okay, what function selector are you looking for?

      所以再次说明，流程看起来像我们发送 calldata，我们的智能合约读取我们的 calldata 并说，好的，你要找哪个函数选择器？

---

      Ah, you're looking for this function, I'm going to route your call to that function.

      啊，你要找这个函数，我将把你的调用路由到那个函数。

---

      In a way, us sending calldata to a smart contract is going to be the same as us calling like a Python script, or a JavaScript script.

      在某种程度上，我们发送 calldata 到智能合约与我们调用像 Python 脚本或 JavaScript 脚本是一样的。

---

      And we need an entry point for our calldata to be processed.

      我们需要一个入口点来处理我们的 calldata。

---

      In Huff, we call that entry point main.

      在 Huff 中，我们称这个入口点为 main。

---

      In the binary, it'll just take your calldata and execute it through whatever binary is there.

      在二进制文件中，它只会获取你的 calldata 并通过任何存在的二进制文件来执行它。

---

      But we'll talk about that in a bit.

      但我们稍后会讨论这个问题。

---

      And again, I know I'm throwing a lot of terminology at you here, but I promise it'll make sense.

      再次说明，我知道我在这里向你抛出了很多术语，但我保证它会变得有意义。

---

      Just follow along with me for now, we're going to really dial this in for you.

      现在先跟着我，我们将真正为你深入了解这一点。

---

      So we need to actually code this function dispatching.

      所以我们需要实际编写这个函数分发。

---

      So in order for us to have an entry point for our calldata, we need to define a function that we're going to call main in Huff.

      所以为了让我们有一个 calldata 的入口点，我们需要定义一个我们将在 Huff 中称为 main 的函数。

---

      Now the Huff language does have functions, but for the most part, we're going to ignore functions exist in Huff.

      现在 Huff 语言确实有函数，但在大多数情况下，我们将忽略 Huff 中存在函数。

---

      And we're just going to work with macros.

      我们将只使用宏（macro）。

---

      For all intents and purposes, macros essentially are functions, they're a little bit different, don't worry about the difference for now.

      就所有意图和目的而言，宏本质上是函数，它们有点不同，现在不用担心差异。

---

      So we're going to write a main function, which will do this function dispatching.

      所以我们将编写一个 main 函数，它将执行这个函数分发。

---

      And remember, we don't have to do this in Solidity.

      记住，我们不必在 Solidity 中这样做。

---

      But we do have to do this in Huff.

      但我们必须在 Huff 中这样做。

---

      And importantly, we do have to do this in our bytecode as well.

      重要的是，我们还必须在我们的字节码（bytecode）中这样做。

---

      So learning how to do it in Huff will teach us how it's done in the bytecode.

      所以学习如何在 Huff 中做到这一点将教会我们如何在字节码中完成。

---

      So let's get started.

      让我们开始吧。

---

      So we're going to define macro main like this.

      所以我们将像这样定义宏 main。

---

      Now I am going to put the rest of the syntax for this, but don't worry about what it means quite yet.

      现在我将为它添加其余的语法，但暂时不用担心它的含义。

---

      I'm going to say takes zero, returns zero.

      我将说 takes zero, returns zero。

---

      So this is how you define a macro, which is basically a function in Huff.

      所以这是你如何定义一个宏，它基本上是 Huff 中的一个函数。

---

      Define macro, name of the macro, and then takes and returns.

      定义宏，宏的名称，然后是 takes 和 returns。

---

      So the takes and returns refer to what it's going to take off the stack and return onto the stack.

      所以 takes 和 returns 指的是它将从堆栈中取出什么，以及返回到堆栈上什么。

---

      But don't worry about that yet.

      但暂时不用担心。

---

      Boom, we have our main function.

      砰，我们有了我们的 main 函数。

---

      Oops, I'm sorry, the main macro needs to be uppercase, not lowercase.

      哎呀，对不起，main 宏需要大写，而不是小写。

---

      Now we can even test that this compiles by running Huff C on it.

      现在我们甚至可以通过在其上运行 Huff C 来测试它是否编译。

---

      So we'll do Huff C, src, Horstor v1, Horstor.huff, and we'll get compiling and then no output, which means it compiles successfully.

      所以我们将执行 Huff C, src, Horstor v1, Horstor.huff，我们将得到编译，然后没有输出，这意味着它编译成功了。

---

      We can actually rerun the command and do dash B, and we'll actually get the bytecode associated with just this smart contract.

      我们实际上可以重新运行该命令并执行 dash B，我们将实际获得与此智能合约关联的字节码。

---

      So just this smart contract, just this bit of Huff returns all of this bytecode here, all of these little opcodes.

      所以仅仅这个智能合约，仅仅这一小段 Huff 返回了所有这里的字节码，所有这些小操作码。

---

      And we're going to come back to what those opcodes mean.

      我们将回到这些操作码的含义。

---

      But when we do the dash B, we get the output of the binary here.

      但是当我们执行 dash B 时，我们在这里得到了二进制文件的输出。

---

      Boom, we have a minimal Huff smart contract, which looks like this.

      砰，我们有了一个最小的 Huff 智能合约，它看起来像这样。

---

      And this is the smallest, most basic smart contract you can have.

      这是你可以拥有的最小、最基本的智能合约。

---

      And we haven't done anything really.

      我们还没有真正做任何事情。

---

      Now, additionally, I have some syntax highlighting in here.

      现在，此外，我在这里有一些语法高亮显示。

---

      I'm using a Huff extension.

      我正在使用一个 Huff 扩展。

---

      So if you're using VS Code, and you want to have some syntax highlighting for Huff, install this extension, it'll give you these nice little highlightings here.

      所以如果你正在使用 VS Code，并且你想要一些 Huff 的语法高亮显示，安装这个扩展，它会给你这些漂亮的小高亮显示。

---

      So we're still in the process of trying to make the function dispatcher, right?

      所以我们仍然在尝试制作函数分发器，对吧？

---

      We're still in the process of us trying to code this bit that says, okay, if this is your function selector, call this function.

      我们仍然在尝试编写这一部分代码，它说，好的，如果这是你的函数选择器，调用这个函数。

---

      But we saw actually when we when we compile this, we got this output here.

      但是我们看到，实际上当我们编译这个时，我们得到了这个输出。

---

      But clearly, we still haven't coded our function dispatcher, we just coded this main function.

      但显然，我们仍然没有编写我们的函数分发器，我们只是编写了这个 main 函数。

---

      So what the what is this?

      那么这是什么？

---

      What is this code doing?

      这段代码在做什么？

---

      Well, when you compile any smart contract, most smart contracts are compiled into three or four different sections, the contract creation code, the runtime code, and then the metadata and sometimes constructors and whatever else the compiler feels like doing the solidity compiler does this nice little bit of op code syntax where it adds a little invalid op code between the different sections.

      好吧，当你编译任何智能合约时，大多数智能合约都被编译成三个或四个不同的部分，合约创建代码，运行时代码，然后是元数据，有时是构造函数以及编译器想做的任何其他事情，solidity 编译器会添加一个小的操作码语法，它在不同的部分之间添加一个小的无效操作码。

---

      So it's even easier to tell which section is which.

      所以更容易分辨哪个部分是哪个。

---

      So after contract creation, they pop a little invalid.

      所以在合约创建之后，他们会弹出一个小的无效操作码。

---

      After the runtime, they pop a little invalid.

      在运行时之后，他们会弹出一个小的无效操作码。

---

      After the metadata, they don't pop anything because the contract's done.

      在元数据之后，他们不会弹出任何东西，因为合约已经完成。

---

      But these three sections are typically how a smart contract is created.

      但这三个部分通常是创建智能合约的方式。

---

      The first section or the contract creation part of the code is what code that tells the blockchain to actually store the smart contract.

      第一部分或代码的合约创建部分是告诉区块链实际存储智能合约的代码。

---

      This first chunk here, even if we have no what's called runtime code, this is still our contract creation bytecode.

      这里的第一个块，即使我们没有所谓的运行时代码，这仍然是我们的合约创建字节码。

---

      So when we finish this in Huff, we're actually gonna have two sections, we're gonna have the contract creation bytecode, we're gonna have this runtime code, and we're not going to have any metadata, but we could add metadata if we want.

      所以当我们用 Huff 完成这个时，实际上会有两个部分，我们将有 contract creation bytecode，我们将有这个 runtime code，并且不会有任何 metadata，但是如果需要，我们可以添加 metadata。

---

      Solidity and Vyper natively add metadata to their smart contracts.

      Solidity 和 Vyper 原生地将 metadata 添加到它们的智能合约中。

---

      We'll go through what this contract creation bytecode typically does.

      我们将介绍 contract creation bytecode 通常做什么。

---

      But this is a minimalist example of what the contract creation bytecode looks like.

      但这是一个 contract creation bytecode 样子的极简示例。

---

      All this contract creation bytecode is responsible for doing is taking your smart contract and saving it on chain.

      所有这些 contract creation bytecode 负责做的是获取你的智能合约并将其保存在链上。

---

      Because in order for us to deploy any smart contract, here's an example of a transaction that created a smart contract.

      因为为了部署任何智能合约，这里有一个创建智能合约的交易示例。

---

      In order for us to deploy a smart contract, we once again, we send Ethereum some calldata, we send it just a huge lump of binary.

      为了部署智能合约，我们再次向以太坊发送一些 calldata，我们发送给它一大块二进制数据。

---

      So in this giant lump of calldata in this giant lump of binary, the first section of this is going to be yes, this contract creation bytecode.

      因此，在这巨大的 calldata 块中，在这巨大的二进制文件中，第一部分将是，是的，这个 contract creation bytecode。

---

      All this usually says is essentially, hey, take the binary after me and stick it on chain.

      通常所有这些都表示，嘿，获取我之后的二进制文件并将其放在链上。

---

      That's essentially all the contract creation bytecode does.

      这基本上就是 contract creation bytecode 所做的全部。

---

      And we'll go through the opcodes and how this actually works.

      我们将介绍操作码以及这实际上是如何工作的。

---

      But essentially, it says hey, copy this, copy the next chunk of code, save it on chain, please and thank you.

      但本质上，它说，嘿，复制这个，复制下一个代码块，将其保存在链上，请谢谢。

---

      And that's essentially how the contract creation bytecode works.

      这基本上就是 contract creation bytecode 的工作方式。

---

      So even though we have no runtime code, we haven't coded anything, Huff is smart enough to know that we at least need a contract creation bytecode.

      因此，即使我们没有 runtime code，我们也没有编写任何代码，Huff 足够聪明，知道我们至少需要一个 contract creation bytecode。

---

      And even if we compile this Huff smart contract that doesn't do anything, we have this contract creation bytecode here.

      即使我们编译这个什么都不做的 Huff 智能合约，我们这里有这个 contract creation bytecode。

---

      You can actually typically tell that something is a contract creation bytecode by looking for the code copy opcode.

      实际上，通常可以通过查找 code copy opcode 来判断某个东西是否是 contract creation bytecode。

---

      So we talked about opcodes in the Foundry Flow course.

      因此，我们在 Foundry Flow 课程中讨论了操作码。

---

      But as we know, all these little 60 all these little numbers are referring to some type of opcode.

      但正如我们所知，所有这些小的 60，所有这些小的数字都指向某种类型的操作码。

---

      And there's a phenomenal website that teaches us all these opcodes and actually gives us a little playground to try them out and teaches us what they do.

      并且有一个非常棒的网站，可以教我们所有这些操作码，实际上，它为我们提供了一个小型的试验场来尝试它们，并教我们它们的作用。

---

      But the opcode that actually says, hey, stick this smart contract on chain is going to be this opcode called code copy.

      但是实际上说，嘿，把这个智能合约放在链上的操作码将是这个名为 code copy 的操作码。

---

      So typically, if you see this code copy opcode, or the 39 opcode, that's an indication that you're looking at the contract creation part of the code base.

      因此，通常，如果你看到此 code copy opcode 或 39 opcode，这表明你正在查看代码库的 contract creation 部分。

---

      Typically, you can still have this in the runtime.

      通常，你仍然可以在 runtime 中使用它。

---

      But if you're looking for a quick litmus test of what section of the code you're in, you can look for this 39.

      但是，如果你正在寻找一个快速的石蕊测试来确定你所在的代码部分，你可以查找此 39。

---

      And if we look in here, we do indeed see, okay, so we see F3, 3D, 39, we do indeed see there's a code copy opcode in this contract creation bytecode.

      如果我们在其中查找，我们确实看到，好的，所以我们看到 F3、3D、39，我们确实看到此 contract creation bytecode 中有一个 code copy opcode。

---

      So again, we're going to go over what this does in a little bit.

      所以，我们稍后将再次介绍它的作用。

---

      Make sense?

      明白了吗？

---

      Okay, let's continue.

      好的，让我们继续。

---

      Now in Solidity, when we're working with variables, Solidity almost kind of magically just knows where to put them.

      现在在 Solidity 中，当我们使用变量时，Solidity 几乎有点神奇地知道将它们放在哪里。

---

      They know magically if it's a memory variable, or if it's a storage variable, and what variables to kill after a program has ended.

      他们神奇地知道它是 memory 变量还是 storage 变量，以及程序结束后要销毁哪些变量。

---

      So number of horses here is clearly a storage variable.

      所以这里的马匹数量显然是一个 storage 变量。

---

      So after a program finishes, it'll keep that value to persist.

      因此，程序完成后，它将保留该值以保持持久性。

---

      However, some memory variable like if I added youint256, hello equals seven.

      但是，一些 memory 变量，例如如果我添加了 uint256，hello 等于 7。

---

      Once the transaction to update horse number finishes, this hello variable will be inaccessible.

      一旦更新马匹数量的交易完成，此 hello 变量将无法访问。

---

      It won't matter anymore.

      它不再重要。

---

      So how does Solidity know what to keep and what to get rid of?

      那么 Solidity 如何知道要保留什么以及要摆脱什么？

---

      And how does it compute all this different stuff?

      以及它如何计算所有这些不同的东西？

---

      And we have to ask this question in order to answer this question.

      我们必须提出这个问题才能回答这个问题。

---

      So I kind of reformatted our questions here, because we're getting more and more.

      所以我在这里重新格式化了我们的问题，因为我们得到越来越多的东西。

---

      And also, more importantly, how does the EVM know what to do with this?

      而且，更重要的是，EVM 如何知道如何处理这个问题？

---

      Does it just stick everything in storage for a little bit and then move it around?

      它是否只是将所有内容暂时存储在 storage 中，然后再移动它？

---

      Unlike in Solidity, Solidity will kind of magically say, okay, this call data, I know where to put it, I know what to do with it.

      与 Solidity 不同，Solidity 会神奇地说，好的，这个 call data，我知道把它放在哪里，我知道该怎么处理它。

---

      But guess what?

      但是猜猜怎么着？

---

      We are writing HuffCode.

      我们正在编写 HuffCode。

---

      We are essentially going to be doing the opcodes ourselves here.

      我们本质上将在这里自己完成操作码。

---

      Now in order for us to understand what places we can put stuff, we want to take a look at this tweet from a very prevalent smart contract developer in the space, Pascal.

      现在，为了让我们了解我们可以将东西放在哪些地方，我们想看看来自该领域一位非常流行的智能合约开发人员 Pascal 的这条推文。

---

      And I'll have this image in the GitHub associated with this course.

      我将在与本课程相关的 GitHub 中提供此图像。

---

      He gave us this image of some of the most important places we can actually store data once transient storage comes into play.

      他给了我们这张图片，其中包含了一些最重要的地方，一旦瞬态存储发挥作用，我们实际上可以存储数据。

---

      Transient storage isn't quite a thing quite yet.

      瞬态存储还不是一件完全确定的事情。

---

      Don't worry about that for now.

      暂时不用担心。

---

      But these are some of the different things that the EVM actually can work with and keep track of.

      但这些是 EVM 实际上可以使用和跟踪的不同事物。

---

      The most important ones that we're going to be looking at are going to be the stack, memory, and storage.

      我们将要研究的最重要的内容是 stack、memory 和 storage。

---

      There's also obviously the EVM code itself.

      显然还有 EVM 代码本身。

---

      We have a program counter and available gas.

      我们有一个程序计数器和可用的 gas。

---

      Transient storage doesn't quite exist yet.

      瞬态存储还不存在。

---

      And it's not super important for what we're going to be covering here.

      对于我们在这里要介绍的内容来说，它并不是非常重要。

---

      But we are going to focus on the stack, memory and account storage.

      但我们将重点关注 stack、memory 和 account storage。

---

      So when we're looking to grab this data and work with this data, if we want to do any type of computations, we first need to figure out where do we want to do computations?

      因此，当我们希望获取此数据并使用此数据时，如果我们想进行任何类型的计算，我们首先需要弄清楚我们要在哪里进行计算？

---

      Where do we want to put this data?

      我们想把这些数据放在哪里？

---

      So the EVM is what's known as a stack machine.

      因此，EVM 被称为堆栈机。

---

      And of all these places, the cheapest places gas wise to do stuff is going to be on the stack.

      在所有这些地方中，gas 方面最便宜的地方是在堆栈上。

---

      And we actually know this because we go back to this EVM .codes website, we have this minimum gas, which gives us a clue as to how much gas each one of these operations are going to do.

      我们实际上知道这一点，因为我们回到这个 EVM .codes 网站，我们有这个最小 gas，它为我们提供了一个线索，关于每个操作将执行多少 gas。

---

      This add operation, what it does is it takes the first two items on the stack and returns onto this stack data structure, the addition of the two of them, and it costs around three gas.

      这个 add 操作，它所做的是获取前两个堆栈上的项目，并返回到此堆栈数据结构上，即这两个项目的加法，它花费大约三个 gas。

---

      And if you look for another add opcode, you'll see that the only way to add two things in the EVM world is on the stack.

      如果你查找另一个 add 操作码，你会发现，在 EVM 世界中添加两个东西的唯一方法是在堆栈上。

---

      So at some point or another, if you want to add anything, it needs to be on the stack.

      因此，在某个时候，如果你想添加任何东西，它需要放在堆栈上。

---

      EVM is known as a stack machine or stack state machine, where most of the operations we're going to be working with are going to be putting stuff on and pulling stuff off of what's called a stack.

      EVM 被称为堆栈机或堆栈状态机，其中我们将要使用的大多数操作都将把东西放在一个叫做堆栈的东西上，然后把东西从上面拉下来。

---

      Now the stack is going to be the main data structure that we work with when it comes to working with Ethereum.

      现在，堆栈将是主要的我们在使用以太坊时使用的数据结构。

---

      And you can think of it literally as a stack, like a stack of pancakes or a stack of books.

      你可以将其字面上理解为一个堆栈，例如一堆煎饼或一堆书。

---

      Whenever we have an object on the stack, if we push something to the stack, that's when we basically drop it from the top and stick it to the top of the stack.

      每当我们在堆栈上有一个对象时，如果我们将某些东西推入堆栈，那时我们基本上从顶部放下它并将其放在堆栈的顶部。

---

      If we want to add a new item to the stack, well, guess what? Same thing.

      如果我们想向堆栈添加一个新项目，那么，猜猜怎么着？同样的事情。

---

      We got to bring it to the top and drop it onto the top of the stack.

      我们必须将其带到顶部并将其放到堆栈的顶部。

---

      Now we have an item on the bottom of the stack and an item on top of this object on the stack.

      现在我们在堆栈的底部有一个项目，堆栈上此对象的顶部有一个项目。

---

      If we wanted to get the value in here, let's say this was some seven, let's say this was a hundred.

      如果我们想获得此处的价值，假设这是某个 7，假设这是 100。

---

      If we wanted to get to this seven, we would need to first pull off the 100 and then pull off the seven.

      如果我们想得到这个 7，我们需要首先拉下 100，然后拉下 7。

---

      This is how the EVM works.

      这就是 EVM 的工作方式。

---

      And this is how we're going to do most operations.

      这就是我们将进行大多数操作的方式。

---

      So whenever we see any of these opcodes that we're going to be learning about, we can kind of visually represent what they're doing with an object that looks like this.

      因此，每当我们看到我们将要学习的任何这些操作码时，我们可以用视觉方式表示它们正在做什么，使用看起来像这样的对象。

---

      So most of what we're going to be doing is on the stack.

      因此，我们将要做的绝大多数事情都在堆栈上。

---

      Now, the other two important places that we can put and do stuff is going to be memory and storage.

      现在，我们可以放置和执行操作的另外两个重要位置是 memory 和 storage。

---

      Now, unlike the stack where you have to pull things on and off one at a time, memory, you can really stick any variable, any place that you want.

      现在，与堆栈不同，在堆栈中，你必须一次拉入和拉出一个东西，memory，你可以真正地粘贴任何变量，任何你想要的地方。

---

      And at the end of your transaction, everything in there goes away.

      在你的交易结束时，其中的所有内容都会消失。

---

      Storage kind of works the same.

      Storage 的工作方式类似。

---

      You can think of it as a giant array where we can stick data wherever we want, whenever we want.

      你可以把它想象成一个巨大的数组，我们可以把数据放在任何我们想放的地方，无论何时我们想放。

---

      And when the transaction completes, storage persists.

      当交易完成时，storage 会持久存在。

---

      However, as we know, as we've learned before, anytime we interact with storage, it's going to be incredibly expensive.

      然而，正如我们所知，正如我们之前学到的，任何时候我们与 storage 交互，它都会非常昂贵。

---

      We go to our opcodes, the S-store opcode, which saves a word to storage, costs substantially more than our M-store opcode, which saves a word to memory.

      我们来看一下我们的操作码，S-store 操作码，它可以保存一个 word 到 storage 中，它的成本比 M-store 操作码高得多，M-store 操作码将一个 word 保存到 memory 中。

---

      M-store, minimum of 3.

      M-store，最低 3 个 gas。

---

      S-store, minimum of 100.

      S-store，最低 100 个 gas。

---

      So storage is always going to be a lot more expensive.

      所以 storage 总是会贵很多。

---

      But these are going to be the main places we can work with data.

      但这些将是我们处理数据的主要场所。

---

      You can think of memory like a giant array.

      你可以把 memory 想象成一个巨大的数组。

---

      You think of storage like a giant array that persists after the transaction completes.

      你可以把 storage 想象成一个巨大的数组，它在交易完成后仍然存在。

---

      And the stack is literally a stack of pancakes.

      而 stack 实际上就是一叠煎饼。

---

      And the stack is where we're going to do most of our stack computation and most of our operations.

      stack 是我们将进行大部分计算和大部分操作的地方。

---

      So anytime you want to add stuff, you want to subtract stuff, you want to do anything, you have to do it in the stack.

      所以任何时候你想添加东西，你想减少东西，你想做任何事情，你都必须在 stack 中进行。

---

      There's sometimes we have to do some stuff in memory and we'll point those out when we get to them.

      有时我们必须在 memory 中做一些事情，当我们遇到它们时，我们会指出来。

---

      Now, like we said, there are a couple other places you can actually store data and work with stuff.

      现在，就像我们说的，还有其他几个地方你可以实际存储数据和处理东西。

---

      But for the most part, just think stack, memory or storage.

      但在大多数情况下，只需考虑 stack、memory 或 storage。

---

      That's where stuff is.

      东西就在那里。

---

      That's where data is going to go.

      数据将放在那里。

---

      And all of these opcodes, all they essentially do is do stuff to the stack, memory and storage.

      所有这些操作码，它们本质上所做的就是对 stack、memory 和 storage 进行操作。

---

      That's basically it with the stack being the most important piece.

      基本上就是这样，其中 stack 是最重要的部分。

---

      In fact, right at the top of all these opcodes, you can see this little stack input and stack output.

      事实上，在所有这些操作码的顶部，你可以看到这个小的 stack 输入和 stack 输出。

---

      Most opcodes say okay, A is going to be the top of the stack, B is right underneath the stack.

      大多数操作码都说，好的，A 将是 stack 的顶部，B 就在 stack 的下面。

---

      And what the add opcode is going to do, it's going to add take the A opcode plus the B opcode and then return on top of the stack A plus B.

      操作码将要做的是，它将获取 A 操作码加上 B 操作码，然后在 stack 的顶部返回 A 加 B。

---

      So if we have a stack here, and we want to use the add opcode, we would need to have two stuff on the stack.

      所以如果这里有一个 stack，并且我们想使用 add 操作码，我们需要在 stack 上放两个东西。

---

      Well, in order to get stuff on the stack, we actually need to use a push opcode.

      为了把东西放到 stack 上，我们实际上需要使用 push 操作码。

---

      And there's a whole bunch of push opcodes here.

      这里有很多 push 操作码。

---

      The push opcode has a push and then the number of bytes you want to place in the stack, except for push zero, which always pushes zero onto the stack.

      push 操作码有一个 push，然后是你想要放在 stack 中的字节数，除了 push zero，它总是将零推到 stack 上。

---

      So let's say we called push one with a value of 0x01.

      假设我们用 0x01 的值调用 push one。

---

      What we would do is we would push one onto the stack.

      我们要做的就是将 1 推到 stack 上。

---

      And now this is on our stack with a value of one.

      现在它就在我们的 stack 上，值为 1。

---

      Remember, we're always going to be working with hex data.

      记住，我们总是要处理十六进制数据。

---

      So 0x01 is going to equal one.

      所以 0x01 等于 1。

---

      Now let's say we called push again with push one.

      现在假设我们再次调用 push，使用 push one。

---

      So we're going to push one byte code on and then instead we do 0x03, which is going to equal three.

      所以我们将推送一个字节码，然后改为我们做 0x03，它将等于 3。

---

      So now we have three on top of the stack and one right underneath it.

      所以现在我们在 stack 的顶部有 3，在它下面有 1。

---

      If we came along and said okay, we want to now do the add opcode, what's going to happen is our add opcode is going to look at the top of the stack and right underneath the stack and say, okay, we're going to add three plus one.

      如果我们过来并说，好的，我们现在想做 add 操作码，将会发生的是我们的 add 操作码将查看 stack 的顶部和紧挨着的下面 stack，然后说，好的，我们将加 3 加 1。

---

      And the resulting value on the stack is going to be what the addition of them is.

      stack 上的结果值将是它们的加法结果。

---

      So you can almost think of them being pulled off, our little add code going, okay, three plus one is four.

      所以你几乎可以认为它们被拉下来了，我们的小 add 代码说，好的，3 加 1 是 4。

---

      So we're going to do four here, four, boop, and now stick that on the stack.

      所以我们在这里做 4，4，噗，现在把它放在 stack 上。

---

      If this is what our stack looked like, we had four, maybe three at the bottom, maybe one here, and we called the add opcode.

      如果这是我们的 stack 的样子，我们有 4，也许底部有 3，这里可能有 1，我们调用了 add 操作码。

---

      Remember, it only applies to the two top on the stack.

      记住，它只适用于 stack 上最上面的两个。

---

      So essentially it would say, okay, let's take these.

      所以本质上它会说，好的，让我们拿走这些。

---

      One plus four is five.

      1 加 4 是 5。

---

      So now the data here is going to be five.

      所以现在这里的数据将是 5。

---

      Let's stick that back on the stack.

      让我们把它放回 stack 上。

---

      And after an add opcode works, this is what it will look like.

      在 add 操作码工作之后，它会是这个样子。

---

      So that's an example of working with two really important opcodes, the push opcode and the add opcode.

      所以这是一个使用两个非常重要的操作码的例子，push 操作码和 add 操作码。

---

      Push is going to stick stuff into the stack.

      Push 将把东西放入 stack 中。

---

      Add is going to take stuff off the stack and combine them.

      Add 将从 stack 中取出东西并将它们组合起来。

---

      And you can read all the different inputs and stack outputs in EVM.Codes.

      你可以在 EVM.Codes 中阅读所有不同的输入和 stack 输出。

---

      They do a great job of that as well.

      他们在这方面也做得很好。

---

      And we'll see in a little bit how opcodes like mstore and sstore take stuff off the stack, but then stick stuff into memory as a result of what's on the stack.

      我们稍后会看到像 mstore 和 sstore 这样的操作码如何从 stack 中取出东西，然后将东西放入 memory 中，作为 stack 上内容的结果。

---

      So we'll see that in a bit.

      所以我们稍后会看到。

---

      How do we make this contract dispatch our calldata so that when we send a calldata telling it to update our horse numbers, it actually updates our horse numbers.

      我们如何使这个合约分发我们的 calldata，以便当我们发送一个 calldata 告诉它更新我们的马匹数量时，它实际上更新了我们的马匹数量。

---

      Okay, let's continue doing that now.

      好的，让我们现在继续这样做。

---

      So we now know when somebody is going to call our horse store smart contract, they're going to call with something that might look like this, right?

      所以我们现在知道当有人要调用我们的 horse store 智能合约时，他们会调用一些可能看起来像这样的东西，对吧？

---

      They're going to send it this giant lump of data.

      他们会发送给它这个巨大的数据块。

---

      Let's find the function selector so we can route it to the code that actually updates the number of horses, which we haven't written yet, but we will.

      让我们找到函数选择器，以便我们可以将其路由到实际更新马匹数量的代码，我们还没有编写，但我们会编写。

---

      Now that we know that the EVM is a stack machine, and in order for us to do this function selector routing, we need to do some computation on the stack.

      现在我们知道 EVM 是一台 stack 机器，并且为了让我们进行这个函数选择器路由，我们需要在 stack 上进行一些计算。

---

      Let's try to actually get this to work now.

      让我们现在尝试实际让它工作。

---

      Now, just for this beginning part, I'm going to do two things.

      现在，仅对于这开始的部分，我将做两件事。

---

      I'm going to have our little stack over here, and I'm going to push stuff onto the stack to make it a little bit more obvious what's actually going on.

      我将在这里有一个小 stack，并且我将把东西推到 stack 上，使它更加明显实际发生了什么。

---

      But the second bit here is we are going to do a little bit of magic just in the beginning of this main function to do this function dispatching, because there are a couple of opcodes that are going to be a little confusing the first time you look at them.

      但这里的第二点是我们将做一个小小的技巧，就在这个 main 函数的开头来进行这个函数分发，因为有一些操作码在你第一次看到它们时会有点令人困惑。

---

      Once again, stick with me.

      再一次，跟着我。

---

      I promise this will make sense as we go back over it.

      我保证当我们回顾它时，这会有意义的。

---

      So the first thing that we want to do is we actually want to push zero onto the stack to do some stuff later.

      所以我们想做的第一件事是我们实际上想要将零推到 stack 上，以便稍后做一些事情。

---

      So typically, to do that, you would have the push zero opcode, which would literally just push zero onto the stack, boop, like this.

      所以通常，要做到这一点，你会有 push zero 操作码，它会直接将零推到 stack 上，噗，像这样。

---

      In Huff, Huff is actually smart enough to know that if you just do 0x00 like this, it's smart enough to say, oh, okay, this is the push zero opcode, and they want to push zero on the stack.

      在 Huff 中，Huff 实际上足够聪明，知道如果你只是像这样写 0x00，它足够聪明，会说，哦，好的，这是 push zero 操作码，他们想要将零推到 stack 上。

---

      And similarly, if I wanted to do like push 1 0x01, if I want to push one byte onto the stack with the value 0x01, I wouldn't even need to have the push one opcode in Huff.

      类似地，如果我想做像 push 1 0x01 这样的操作，如果我想用值 0x01 将一个字节推到 stack 上，我甚至不需要在 Huff 中使用 push one 操作码。

---

      Huff is smart enough to know that if I put 0x01, they know that I mean push one 0x01.

      Huff 足够聪明，知道如果我放 0x01，他们知道我的意思是 push one 0x01。

---

      Because obviously, this is one byte long.

      因为很明显，这是一个字节长。

---

      If I did this, it would be smart enough to make that push two because this is of course two bytes long.

      如果我这样做，它会足够聪明，把它变成 push two，因为这当然是两个字节长。

---

      So when doing push opcodes in Huff, you just need to put the actual value that you want to push onto the stack.

      所以在 Huff 中进行 push 操作码时，你只需要放入你想要推到 stack 上的实际值。

---

      So in our Huff now, when somebody calls this smart contract, and when somebody sends any calldata to this smart contract, the only thing this smart contract will do right now is push zero onto the stack.

      所以在我们的 Huff 中，现在当有人调用这个智能合约，并且当有人向这个智能合约发送任何 calldata 时，唯一这个智能合约现在将做的事情是将零推到 stack 上。

---

      That's it.

      就是这样。

---

      And in fact, we can even compile this with Huff C, SRC, Horstor V1, Horstor.Huff.

      事实上，我们甚至可以用 Huff C, SRC, Horstor V1, Horstor.Huff 编译它。

---

      And let's add the binary.

      让我们添加二进制文件。

---

      And we can see our code is a little longer than just the contract creation bytecode now.

      我们可以看到我们的代码比合约创建字节码长一点。

---

      Now, after the F3, after that contract creation code, we now have this 5F, which if we go back to EVM.Codes, 5F is indeed it's the push zero opcode.

      现在，在 F3 之后，在合约创建代码之后，我们现在有这个 5F，如果我们回到 EVM.Codes，5F 确实是 push zero 操作码。

---

      So we can see just by adding this push zero opcode in our Huff, we've added the 5F opcode.

      所以我们可以看到，仅仅通过在我们的 Huff 中添加这个 push zero 操作码，我们就添加了 5F 操作码。

---

      And now there's a 5F added into our smart contract.

      现在我们的智能合约中添加了一个 5F。

---

      This means that once again, since this is our main function, and since it's the first, anytime anybody says any data to the smart contract, we just push zero onto the stack.

      这意味着，再一次，因为这是我们的主函数，并且因为它是第一个被调用的函数，任何时候有人向智能合约发送任何数据，我们只是将零压入堆栈。

---

      That's it.

      就是这样。

---

      So this doesn't do anything yet, except for push zero on the stack.

      所以这段代码目前什么都不做，除了将零压入堆栈。

---

      But cool.

      但是很酷。

---

      So we're already starting to code with pure opcodes.

      所以我们已经开始用纯操作码进行编码了。

---

      Very exciting.

      非常令人兴奋。

---

      Okay, what next?

      好的，下一步是什么？

---

      Okay, well, somebody is going to send us some calldata, right?

      好的，那么，有人会向我们发送一些 calldata，对吧？

---

      And they're going to have the function selector embedded in the call data.

      他们会将函数选择器嵌入到 calldata 中。

---

      So we want to actually get their calldata.

      所以我们实际上想要获取他们的 calldata。

---

      And to do to get this first chunk, we're going to need to do some operations, right?

      为了获取第一块数据，我们需要做一些操作，对吧？

---

      We're gonna need to say, hey, give me the calldata, but like only the first four bytes.

      我们需要说，嘿，给我 calldata，但是只需要前四个字节。

---

      So to do any type of operations, what do we do?

      所以要进行任何类型的操作，我们该怎么做？

---

      You guessed it, we got to stick it on the stack.

      你猜对了，我们必须把它放到堆栈上。

---

      And I want you to keep that in mind.

      我希望你记住这一点。

---

      Anytime you want to do any operations, you got to stick it on the stack.

      任何时候你想做任何操作，你都必须把它放到堆栈上。

---

      So if we go back to our evm.codes, we can look for calldata load.

      所以如果我们回到 evm.codes，我们可以查找 calldata load。

---

      And this is the opcode that actually loads our calldata onto the stack.

      这正是将 calldata 加载到堆栈上的操作码。

---

      So you can even read it in evm.codes.

      所以你甚至可以在 evm.codes 中阅读它。

---

      So what it's going to do is it's going to take a stack input and give a stack output.

      所以它会做的是它会接受一个堆栈输入并给出一个堆栈输出。

---

      And the stack input of calldata load is why we actually pushed the zero onto the stack in the first place.

      calldata load 的堆栈输入就是为什么我们实际上首先将零压入堆栈的原因。

---

      So what calldata load is going to do is it's going to look at the calldata, and it's going to grab whatever value is at the top of the stack and use this as the bytes offset.

      所以 calldata load 将要做的是它会查看 calldata，并且它会获取任何位于堆栈顶部的值，并将其用作字节偏移量。

---

      So if this was one, if we pushed one onto here, what our calldata load would do is it would look at our calldata and go, okay, I'm going to load this calldata, but I'm going to ignore the first byte and start from here.

      所以如果这是 1，如果我们在这里压入 1，那么我们的 calldata load 会做的是它会查看我们的 calldata 并说，好的，我要加载这个 calldata，但我会忽略第一个字节并从这里开始。

---

      We don't want it to ignore the first byte because that first byte includes part of the function selector.

      我们不希望它忽略第一个字节，因为第一个字节包含函数选择器的一部分。

---

      So as of now, here's what our stack looks like.

      所以到目前为止，这就是我们的堆栈的样子。

---

      And usually when I'm coding, I like to visualize the stack in comments as well.

      通常，在编码时，我也喜欢在注释中可视化堆栈。

---

      So if I have 0x0, 0x0, which pushes zero to the stack, I also like to do these comments where I have like a little brackets and like a zero in here, which says, okay, at the bottom of our stack is zero.

      所以如果我有 0x0, 0x0，它会将零压入堆栈，我也喜欢做这些注释，我在注释中有一个小括号，里面有一个零，表示，好的，在我们堆栈的底部是零。

---

      So this little comment here and this image are supposed to represent the same thing.

      所以这里的小注释和这个图像应该表示相同的事情。

---

      If I were to add like 0x02, I would then do something like this, where I would say two comma zero, where the left side is going to be the top of the stack and the right side is going to be the bottom of the stack.

      如果我要添加像 0x02 这样的东西，那么我会做一些事情像这样，我会说 2 逗号 0，其中左边是堆栈的顶部，右边是堆栈的底部。

---

      As a stack image over here, that would look like this.

      作为这里的堆栈图像，它看起来会像这样。

---

      So I'm going to keep this commented out for now, but as I'm coding along, this is how in the comments in your code, you can also keep track of what the stack looks like.

      所以我现在将保持注释状态，但是当我沿着编码时，这就是在代码的注释中，你也可以跟踪堆栈的样子。

---

      So I'm going to delete that for now.

      所以我现在要删除它。

---

      So since we have zero on the stack right now, when we do the calldata load opcode, and this is how you do it in Huff, you literally just write the name of it.

      所以既然我们现在在堆栈上有零，当我们执行 calldata load 操作码时，这就是你在 Huff 中执行它的方式，你只需写下它的名字。

---

      It's just going to put the calldata right onto the stack starting from the zero with byte.

      它只是将 calldata 直接放到堆栈上从第零个字节开始。

---

      So it's going to add the entire calldata right onto the stack.

      所以它会将整个 calldata 添加到堆栈上。

---

      And you might be confused, you might be saying, hey, we replaced the zero with the calldata.

      你可能会感到困惑，你可能会说，嘿，我们替换了 calldata 中的零。

---

      Like why, why do we do that?

      像为什么，我们为什么要这样做？

---

      Well, what happened was we had this calldata, we have this calldata that's being sent to our smart contract.

      好吧，发生的事情是我们有这个 calldata，我们有这个发送到我们智能合约的 calldata。

---

      And we called the calldata opcode.

      我们调用了 calldata 操作码。

---

      And what it did was it says, okay, let's pop off this zero.

      它所做的是它说，好的，让我们弹出这个零。

---

      And let's stick this calldata on starting from the zero with since if you start from the zero with byte, that's just all the calldata, we just said, okay, we've popped off the zero.

      让我们从第零个开始粘贴这个 calldata，因为如果你从第零个字节开始，那就是所有的 calldata，我们只是说，好的，我们已经弹出了零。

---

      And now all that's on the stack is the calldata is this big, big thing right here.

      现在堆栈上所有的是 calldata，是这个大东西。

---

      So cool.

      太酷了。

---

      Now we have the whole calldata onto our stack here.

      现在我们这里有整个 calldata 在我们的堆栈上。

---

      Great.

      太棒了。

---

      What's next?

      下一步是什么？

---

      Next is the hard part.

      接下来是困难的部分。

---

      And if you don't understand this part, that's totally okay.

      如果你不理解这部分，那完全没问题。

---

      Because what we need to do is we need to lop off all of this, right?

      因为我们需要做的是我们需要去掉所有这些，对吧？

---

      Because just this is our function selector.

      因为只有这个是我们的函数选择器。

---

      So how do we cut down the calldata to just the function selector, we have this huge, huge, huge thing.

      那么我们如何将 calldata 减少到只有函数选择器，我们有这个巨大的东西。

---

      And we only want this.

      我们只想要这个。

---

      How do we cut it down, there must be an opcode that will help us do this pretty easily.

      我们如何减少它，必须有一个操作码可以帮助我们轻松地做到这一点。

---

      So there's a lot of approaches we can take to do this.

      所以我们可以采取很多方法来做到这一点。

---

      But one of the easiest and most efficient ones is going to be this SHR.

      但是最简单和最有效的方法之一将是这个 SHR。

---

      This is where we're going to shift the bits towards the least significant one.

      在这里，我们将把这些位向最低有效位移动。

---

      And to do this, you need two values on the stack, you need a shift number of bits to shift to the right, and the value, the 32 bytes that you want to shift.

      要做到这一点，你需要堆栈上的两个值，你需要一个要向右移动的位数，以及该值，你要移动的 32 个字节。

---

      So this SHR is the right shift for bits.

      所以这个 SHR 是位右移。

---

      But for the SHR opcode, let's say this is our text, this is our hex here.

      但是对于 SHR 操作码，假设这是我们的文本，这是我们的十六进制。

---

      0x01021.

      0x01021。

---

      So this is in bytes, of course, right?

      所以这当然是以字节为单位的，对吧？

---

      Each two of these, oh, excuse me, let's get rid of that one.

      每两个，哦，对不起，让我们去掉那个。

---

      This is a byte and this is a byte.

      这是一个字节，这是一个字节。

---

      And as we know, one byte equals eight bits.

      我们知道，一个字节等于八位。

---

      So the shift opcode is how many bits to shift to the right.

      所以 shift 操作码是要向右移动多少位。

---

      So if we look at this as being two sets of eight bits, we can actually rewrite this.

      所以如果我们把这个看作是两组八位位，我们实际上可以重写它。

---

      You can use cast if we want, we do cast dash dash two base, grab this and say bin for binary.

      如果需要，可以使用 cast，我们执行 cast --to-base，抓住这个并说 bin 表示二进制。

---

      And boom, this is it in bits or in its binary.

      这是它以位或二进制形式表示的。

---

      We go 1, 2, 3, 4, 5, 6, 7, 8.

      我们数 1, 2, 3, 4, 5, 6, 7, 8。

---

      This first part represents the 02.

      第一部分代表 02。

---

      And this one over here represents the 01.

      这边这个代表 01。

---

      Right?

      对吧？

---

      If I change this to like an F1, we're going to see we're going to get a much different value.

      如果我把它改成 F1，我们会看到我们会得到一个非常不同的值。

---

      0xf102 with, it's going to be a lot bigger, obviously, because that F1 is now going to use all eight bits.

      0xf102，它会大得多，很明显，因为 F1 现在将使用所有八位。

---

      So 1, 2, 3, 4, 5, 6, 7, 8.

      所以 1, 2, 3, 4, 5, 6, 7, 8。

---

      Boom.

      砰。

---

      This is the 02 and this is going to be the F1.

      这是 02，这将是 F1。

---

      Okay.

      好的。

---

      Hopefully you're following along with me.

      希望你跟着我。

---

      If you're not following along with me, play with this cast to base between bin, deck and hex.

      如果你没有跟着我，请使用这个 cast 命令在 bin、deck 和 hex 之间进行转换。

---

      So this is the hex.

      所以这是十六进制。

---

      This is the bin.

      这是二进制。

---

      And then what was deck?

      那么 deck 是什么？

---

      Deck 6,100, whatever, right?

      Deck 6,100，随便什么，对吧？

---

      That's the decimal equivalent of that binary.

      那是该二进制的十进制等效值。

---

      Anyways.

      无论如何。

---

      So this is the binary representation of this hex.

      所以这是这个十六进制的二进制表示。

---

      So if we say this is the value that we want to shift and we want to shift it by two, well, what are we going to get?

      所以如果我们说这是我们想要移动的值，并且我们想要将其移动两位，那么我们将得到什么？

---

      Well, we're going to shift off these two values here and shift everything else to the right.

      好吧，我们将在这里移出这两个值，然后移动其他所有内容向右。

---

      So now this is going to be our value.

      所以现在这将是我们的值。

---

      1, 2, 3, 4, 5, 6, 7, 8.

      1, 2, 3, 4, 5, 6, 7, 8。

---

      This is going to be what's left.

      这将是剩下的。

---

      And we can pull up cast and see what this is in both hex and in decimals.

      我们可以调出 cast，看看这是什么十六进制和十进制。

---

      And we'll put a 0B at the front of this to tell cast this is a binary.

      我们将在其前面放置一个 0B，以告诉 cast 这是一个二进制。

---

      But if we take this and we do cast, you can actually do dash dash to base, or you can actually just do to base, paste this in with the 0B to tell Foundry it's a binary.

      但是如果我们采用这个并执行 cast，实际上可以执行 --to-base，或者实际上可以直接执行 to-base，粘贴这个，并在其中包含 0B，以告诉 Foundry 这是一个二进制。

---

      And we say hex, we get resulted with 0x40, which again, if we do the decimal, we get 64.

      我们说 hex，我们得到的结果是 0x40，如果再次我们执行十进制，我们得到 64。

---

      So if we shift over two bits, 0, 0, 1, 2, excuse me, we shift over two bits, we get 0x40.

      所以如果我们右移两位，0，0，1，2，不好意思，我们右移两位，得到 0x40。

---

      Let's shift over two more bits, right?

      让我们再右移两位，好吗？

---

      So let's go, let's do four bits, right?

      所以我们来，我们做四位，好吗？

---

      So that would be two more.

      所以这将是再加两个。

---

      Copy this, do the same thing, paste it in, decimal is going to be 16.

      复制这个，做同样的事情，粘贴进去，十进制将是 16。

---

      The hex is going to be 0x10.

      十六进制将是 0x10。

---

      So what this right shift does is it just pushes the whole thing to the right, a number of bits until we're left with whatever's left over.

      所以这个右移的作用就是将整个东西向右推，若干位，直到我们剩下剩余的东西。

---

      We can actually validate if we did this correct in our heads, right?

      我们实际上可以验证一下，看看我们是否在脑海中做对了，对吧？

---

      So we had this 0x012.

      所以我们有这个 0x012。

---

      Let's say we have the 0x012, we want to push it by four, we said we got what?

      假设我们有 0x012，我们想把它推四位，我们说我们得到了什么？

---

      We got 16.

      我们得到了 16。

---

      We can actually see that this is correct by trying this out right in our even.codes.playground.

      我们实际上可以通过尝试来验证这是正确的就在我们的 even.codes.playground 中。

---

      So there's this playground tab here where you can actually switch to playing with YUL, Solidity, byte codes, and then opcodes as well.

      所以这里有一个 playground 标签你可以在这里切换到使用 YUL、Solidity、字节码，以及操作码。

---

      So we're going to go to mnemonic because that's going to be opcodes.

      所以我们要去 mnemonic，因为它将是操作码。

---

      SHR needs a value and then a shift.

      SHR 需要一个值，然后是一个 shift。

---

      So shift needs to be the top of the stack.

      所以 shift 需要在堆栈的顶部。

---

      So first thing we need to do is we need to push, push two, this onto our stack, right?

      所以我们需要做的第一件事是我们需要 push，将 two，这个 push 到我们的堆栈上，对吧？

---

      So we're going to push this onto our stack so that this is now it's on the stack.

      所以我们要把这个 push 到我们的堆栈上，这样这个现在它就在堆栈上了。

---

      Then we need to push one, four.

      然后我们需要 push one，four。

---

      So we're going to push this onto the stack.

      所以我们要把这个 push 到堆栈上。

---

      We're going to push four onto the stack.

      我们要把 four push 到堆栈上。

---

      And then we're going to do a right shift.

      然后我们要做一个右移。

---

      So when we do this, so when we do this playground here, what's going to happen is we're going to push 0x0102 onto the stack.

      所以当我们这样做，所以当我们在这里做这个 playground 时，将会发生的是，我们将把 0x0102 push 到堆栈上。

---

      Then we're going to push 0x04 onto the stack.

      然后我们将把 0x04 push 到堆栈上。

---

      Then we're going to call SHR, which is going to shift this to the right by four.

      然后我们将调用 SHR，它将把这个向右移动四位。

---

      And what we're going to be left with is poof, this value shifted to the right by four.

      我们将剩下的是，这个值向右移动了四位。

---

      So let's see what this looks like when we actually run this in our playground here.

      所以让我们看看当我们实际在我们的 playground 中运行它时会是什么样子。

---

      If we click run, and we zoom out just a hair, we have our opcodes up here.

      如果我们点击运行，然后稍微缩小一点，我们这里有我们的操作码。

---

      And down here, we'll have our stack storage, etc.

      在下面，我们将有我们的堆栈存储等等。

---

      So there's not really a way for me to keep both in frame at the same time.

      所以实际上我没有办法同时将两者都放在画面中。

---

      But I guess we'll, we'll have to make do here.

      但我想我们必须在这里凑合一下。

---

      So if I want to step into this, we can go opcode by opcode.

      所以如果我想单步执行，我们可以逐个操作码地执行。

---

      So first, let's do the push to 0102.

      所以首先，让我们执行 push 到 0102。

---

      Boom, step into it.

      砰，单步执行。

---

      After that executes, we scroll down here, we now see 102 is now on the stack.

      执行完之后，我们向下滚动，我们现在看到 102 现在在堆栈上。

---

      So now we're going to push.

      所以现在我们要 push。

---

      Oops, excuse me, this should be push 0x04.

      哎呀，不好意思，这应该是 push 0x04。

---

      Push 0x04.

      Push 0x04。

---

      Sorry, let's run that again.

      抱歉，让我们再运行一次。

---

      0102.

      0102。

---

      Great.

      太棒了。

---

      Now we're going to push 10x04.

      现在我们要 push 10x04。

---

      Okay, let's run that.

      好的，让我们运行它。

---

      Okay, great.

      好的，太棒了。

---

      Now our stack has 0x04 at the top and 0x0102 at the bottom of the stack.

      现在我们的堆栈顶部有 0x04，底部有 0x0102。

---

      Based off our calculations here, we should return 16.

      根据我们这里的计算，我们应该返回 16。

---

      So now let's go ahead and step into it.

      所以现在让我们继续单步执行。

---

      We get 10 on the stack.

      我们在堆栈上得到 10。

---

      And this is the hex here.

      这是这里的十六进制。

---

      So if we do cast to base 0x10 decimal, we see we do indeed get 16.

      所以如果我们转换为 0x10 十进制，我们看到我们确实得到了 16。

---

      So our math here is right.

      所以我们这里的数学是正确的。

---

      And we've learned how a right shift with all of our bits works.

      我们已经了解了右移是如何处理所有位的。

---

      Now, when we do this calldata load opcode, the calldata load can only put 32 bytes onto the stack.

      现在，当我们执行这个 calldata load 操作码时，calldata load 只能将 32 字节放入堆栈。

---

      So if this is our calldata, again, we have 1, 2, 3, 4, 5, 6, 7, 8, 9, 10.

      所以如果这是我们的 calldata，我们再次有 1, 2, 3, 4, 5, 6, 7, 8, 9, 10。

---

      1, 2, 3, 4, 5, 6, 7, 8, 9, 20.

      1, 2, 3, 4, 5, 6, 7, 8, 9, 20。

---

      1, 2, 3, 4, 5, 6, 7, 8, 9, 30.

      1, 2, 3, 4, 5, 6, 7, 8, 9, 30。

---

      1, 2, 3, 4, 5, 6, 7, 8, 9, 40.

      1, 2, 3, 4, 5, 6, 7, 8, 9, 40。

---

      1, 2, 3, 4, 5, 6, 7, 8, 9, 50.

      1, 2, 3, 4, 5, 6, 7, 8, 9, 50。

---

      1, 2, 3, 4, 5, 6, 7, 8, 9, 60.

      1, 2, 3, 4, 5, 6, 7, 8, 9, 60。

---

      1, 2, 3, 4, 64.

      1, 2, 3, 4, 64。

---

      These little numbers divided by two since every