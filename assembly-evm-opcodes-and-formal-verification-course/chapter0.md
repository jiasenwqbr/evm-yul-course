      Welcome to the assembly EVM opcodes and formal verification smart contract course.
    
       欢迎来到汇编、EVM 操作码和形式化验证智能合约课程。


​      

      This was previous part two or part three of the security course, but we decided to branch it off because we do teach a lot of stuff that maybe even security people don't care to know, maybe just advanced smart contract developers want to know, but we figured we'd put it in its own spot.
    
       这以前是安全课程的第二部分或第三部分，但我们决定将其分离出来，因为我们确实教授了很多即使是安全人员可能也不想了解的内容，也许只有高级智能合约开发者才想了解，但我们认为应该把它放在一个单独的地方。


​      

      And this course is pretty insane. This course is for those developers and security researchers who want to hit that top 1% of blockchain knowledge.
    
       而且这门课程非常疯狂。本课程是为那些想要达到区块链知识前 1% 的开发者和安全研究人员准备的。


​      

      If you take this course, if you go through all the way to the end of this course, at the end of this, you will be able to disassemble smart contracts. You'll be able to learn byte codes. You'll be able to, at the lowest level, understand how to make your contracts more gas optimized because you understand what every single opcode does.
    
       如果你参加这门课程，如果你一直学完本课程，到最后，你将能够反汇编智能合约。你将能够学习字节码。你将能够在最低级别理解如何使你的合约更加 gas 优化，因为你了解每个操作码的作用。


​      

      Additionally, we're going to teach you how to write your own smart contracts in opcodes. And we're going to do that by teaching you about two languages called Yul and Huff. These are two very low-level smart contract programming languages that allow us to build insanely gas-optimized smart contracts.
    
       此外，我们将教你如何编写你自己的智能合约，使用操作码。我们将通过教授你两种语言分别是 Yul 和 Huff 来实现这一点。这两种都是非常底层的智能合约编程语言，允许我们构建极其 gas 优化的智能合约。


​      

      As always on Cypher and OpDraft, the approach we take is by doing project-based work. And we're going to be working specifically with three projects that might seem like it's a very small course because it's only three projects, but we go very deep, very advanced, and we take very different routes to these three projects.
    
       像在 Cypher 和 OpDraft 上一样，我们采取的方法是做基于项目的工作。我们将专门研究三个项目，这些项目可能看起来像是一个非常小的课程，因为它只有三个项目，但我们会非常深入、非常高级地研究，并且我们采取非常不同的方法来处理这三个项目。


​      

      And then finally, in the second and last sections of this course, we're going to teach you formal verification. If you're here at this course, you should already be familiar with what fuzzing is. Fuzzing is always going to be the step you should take in your smart contracts before you come to formal verification. So if you're here, you should already understand fuzzing. Once you understand fuzzing, once you understand invariants, we can go one step further and do something where we actually formally verify our smart contracts.
    
       最后，在本课程的第二部分和最后一部分，我们将教你形式化验证。如果你来参加这门课程，你应该已经熟悉什么是模糊测试（fuzzing）。模糊测试始终是你应该采取的步骤，在进行形式化验证之前，对你的智能合约进行模糊测试。所以如果你在这里，你应该已经理解模糊测试。一旦你理解了模糊测试，一旦你理解了不变量，我们就可以更进一步做一些我们可以形式化验证我们的智能合约的事情。


​      

      Fuzzing is incredibly powerful because it does a whole bunch of random stuff to try to break some invariant of our protocol, but formal verification can actually prove if that invariant holds in all cases. And it is an incredibly powerful tool for testing smart contracts.
    
       模糊测试非常强大，因为它会做一大堆随机的事情，试图打破我们协议的某些不变量，但形式化验证实际上可以证明该不变量在所有情况下是否成立。它是一个非常强大的智能合约测试工具。


​      

      Vitalik actually recently put out a Twitter post where he was excited for AI to actually help write these formal verification tests. And as of right now, a lot of formal verification is a bit of a nice-to-have, but there are a lot of cases where formal verification has actually found massive critical vulnerabilities. And arguably, I believe that as we make formal verification easier and easier to use, it's going to be the future of testing along with fuzzing for smart contracts.
    
       Vitalik 最近发布了一条 Twitter 帖子，他对人工智能能够帮助编写这些形式化验证测试感到兴奋。就目前而言，许多形式化验证有点像是可有可无的东西，但是有很多形式化验证实际上发现了大量严重漏洞的案例。我认为，随着我们使形式化验证更容易和更易于使用，它将成为未来智能合约测试的一部分，与模糊测试一起。


​      

      We're going to teach you to use two very powerful tools, Halmos and Certora, and we're even going to walk you through some other tools like Control by Runtime Verification.
    
       我们将教你使用两个非常强大的工具，Halmos 和 Certora，我们甚至会带你了解其他一些工具，例如 Runtime Verification 的 Control。


​      

      So because this is so level, because this is so intense, because what we're going to be learning is so much harder than a lot of the stuff that's on Uptraft, we're going to be throwing Uptraft away a lot of the funny business.
    
       因为这是如此底层，因为这是如此紧张，因为我们将要学习的内容比 Uptraft 上的很多东西都要难得多，我们将抛弃很多玩笑。


​      

      Okay, I can't help myself. I'll probably still sometimes make some bad jokes.
    
       好吧，我忍不住。我可能还是会时不时地讲一些糟糕的笑话。


​      

      If you want to become a top smart contract developer, you need to know this stuff so that when you're doing gas optimizations, you can understand exactly how these work. And a lot of top smart contract developers code assembly in their smart contract for one reason or another.
    
       如果你想成为一名顶级的智能合约开发者，你需要了解这些东西，这样当你进行 gas 优化时，你可以准确地理解它们是如何工作的。许多顶级的智能合约开发者出于某种原因在他们的智能合约中编写汇编代码。


​      

      And for you security engineers out there, a lot of the best smart contract security researchers do fuzzing in their private audits and sometimes in their competitive audits as well. But additionally, some of the top smart contract security researchers go an extra step further where if their fuzzing doesn't quite pan out, they go the extra mile and try formal verification. And sometimes in specific scenarios, that's where they'll find a bug.
    
       对于你们这些安全工程师来说，很多最好的智能合约安全研究人员在他们的私人审计和有时在他们的竞争性审计中也会进行模糊测试。此外，一些顶级的智能合约安全研究人员会更进一步，如果他们的模糊测试没有完全成功，他们会付出额外的努力并尝试形式化验证。有时在特定情况下，他们会在那里发现一个错误。


​      

      But some of the most important things we're going to be teaching you here is as you get this experience using these tools, you're going to learn when these tools make sense to use, when formal verification makes sense to use, when fuzzing makes sense to use, and so much more.
    
       但我们将要教你的最重要的事情是，当你获得使用这些工具的经验时，你将学习什么时候使用这些工具是有意义的，什么时候形式化验证是有意义的，什么时候模糊测试是有意义的，以及更多。


​      

      So this is probably going to be the most advanced EVM smart contract course you'll ever take, period. And if you're here, it's because you are already a really good smart contract or Solidity or even a Vyper developer at this point. And you're looking to take it to the next step. And that's what we're going to do in this course. We're going to bring you to the next step.
    
       所以这可能是最先进的 EVM 智能合约课程，句号。如果你在这里，那是因为你已经是一个非常优秀的智能合约或 Solidity 甚至 Vyper 开发者了。你正在寻求将其提升到下一个层次。这就是我们在这门课程中要做的事情。我们将带你到下一个层次。


​      

      So with that, as always, I want to give you a huge thank you for showing up to this course and taking this. This is how we scale Web3. This is how we make Web3 better by us as a collective getting smarter, getting better, getting more powerful when it comes to smart contract development and security.
    
       因此，与往常一样，我想给你一个巨大的感谢，感谢你参加这门课程并学习它。这就是我们扩展 Web3 的方式。这就是我们如何通过作为一个集体变得更聪明、更好、更强大来使 Web3 变得更好，尤其是在智能合约开发和安全方面。


​      

      So buckle up because we got a lot of work to do in this course.
    
       所以做好准备，因为我们在这门课程中有很多工作要做。


​      

      As always, let's get started with the best practices.
    
       与往常一样，让我们从最佳实践开始。


​      

      So as always, let's jump into some best practices for this course.
    
       与往常一样，让我们开始介绍本课程的一些最佳实践。


​      

      Now, whether you're taking this on Cypher and Uptraft or on YouTube, there's some links that you need to know about. On any course on Cypher and Uptraft, usually the initial the welcome lesson is going to have some links for you to follow along.
    
       现在，无论你是在 Cypher 和 Uptraft 上还是在 YouTube 上学习这门课程，都有一些你需要了解的链接。在 Cypher 和 Uptraft 上的任何课程中，通常最初的欢迎课程都会有一些链接供你参考。


​      

      The most important link is always going to be this GitHub resources link that comes along with the course because this GitHub resources link is going to have every single link, every resource, everything that you'll need to be good to be successful in this course.
    
       最重要的链接始终是这个与课程一起提供的 GitHub 资源链接，因为这个 GitHub 资源链接将包含每个链接、每个资源，以及你需要的一切，才能在本课程中取得成功。


​      

      Every single one of these courses additionally is going to come with a discussions tab, which will look something like this. This is where we want you to ask questions, engage with teaching assistants, etc. so that if you have questions about the course, you can come here. Whether or not it's YouTube or Cypher and Uptraft, everyone should use this exact same link.
    
       此外，这些课程中的每一个都将附带一个讨论选项卡，看起来像这样。我们希望你在这里提问，与助教互动等等，这样，如果你对课程有疑问，你可以来这里。无论是在 YouTube 还是在 Cypher 和 Uptraft 上，每个人都应该使用这个完全相同的链接。


​      

      If you are watching this on YouTube, if you scroll down into the description, the links for the GitHub will be in the description of the YouTube video itself.
    
       如果你正在 YouTube 上观看此视频，如果你向下滚动到描述中，GitHub 的链接将在 YouTube 视频本身的描述中。


​      

      So for this course, the assembly EVM opcodes and formal verification, I'm building the course as I'm recording it. So if we go to this first lesson here, we can hit this GitHub resources bit and it'll bring us to the GitHub associated with this course, which is going to have all the projects, all the code bases, all the examples, all the links, etc. in this GitHub. We'll additionally have a lot of them in the written lessons of Uptraft as well.
    
       所以对于这门课程，汇编、EVM 操作码和形式化验证，我正在录制时构建课程。所以如果我们去这里的第一个课程，我们可以点击这个 GitHub 资源位，它会将我们带到与本课程相关的 GitHub，它将包含所有项目、所有代码库、所有示例、所有链接等等。我们还将在 Uptraft 的书面课程中提供很多。


​      

      And again, I'm building this as I'm recording it. Be sure to click the links at the bottom, which will give you a link to the GitHub discussions. This is where you should ask questions about the course and the Discord, and the Discord where you can chat with other students. Ideally, all of your technical questions should be in the GitHub discussions so that other students can find them a lot easier and use your conversations to help themselves out.
    
       再说一次，我正在录制时构建它。请务必点击底部的链接，这将给你一个指向 GitHub 讨论的链接。你可以在这里提出关于课程和 Discord 的问题，在 Discord 中，你可以与其他学生聊天。理想情况下，你所有的技术问题都应该在 GitHub 讨论中提出，这样其他学生可以更容易地找到它们，并使用你的对话来帮助自己。


​      

      Oftentimes, if you ask a technical question in the Discord, I will push you to the GitHub discussions.
    
       通常，如果你在 Discord 中提出技术问题，我会将你推到 GitHub 讨论中。


​      

      Now, importantly, I expect everyone who's taking this course to have some context on how to ask really good questions. But for those who do not, I have some docs in here, how to ask a question, which gives you a rundown of how to ask questions, and then also how to answer a question. I'll leave a link to the lesson in Cypher and Uptraft where we go over both of these.
    
       现在，重要的是，我希望每个参加这门课程的人都具备一些关于如何提出真正好的问题的背景知识。但是对于那些没有的人，我在这里有一些文档，关于如何提问，其中给出了如何提问的概要，以及如何回答问题。我将留下一个指向 Cypher 和 Uptraft 中课程的链接，我们在其中回顾了这两个问题。


​      

      Now, this space moves incredibly quickly, and because of that, sometimes we have to make updates to sections because the best practice has changed, the tool has updated, etc. And because of that, on Cypher and Uptraft, if you scroll down to any lesson, there will be an updates section. So there will be an updates thing, a little number here, and for example, here we have example update. But in here, it'll give you the context and how to adjust what you're doing, whether you're coding, whether you're doing an audit, etc., so that you can continue to follow along with the video. So all the code should be up to date, but the video might be a little bit out of date, and you'll know that it's out of date because there will be that updates section here.
    
       现在，这个领域发展得非常快，因此，有时我们必须对章节进行更新，因为最佳实践已经改变，工具已更新等等。因此，在 Cypher 和 Uptraft 上，如果你向下滚动到任何课程，都会有一个更新部分。所以会有一个更新提示，这里会有一个小数字，例如，这里我们有示例更新。但在这里，它会给你上下文以及如何调整你正在做的事情，无论是编码、审计等等，以便你可以继续跟随视频学习。所以所有的代码都应该是最新的，但是视频可能有点过时，你会知道它已经过时，因为这里会有那个更新部分。


​      

      If you find a video that you think is out of date, then be sure to go over to GitHub Discussions and ask a question, because oftentimes the video isn't out of date and there's just something you need to tweak in your code in order to get it right.
    
       如果你发现一个你认为已经过时的视频，那么一定要去 GitHub Discussions 提问，因为通常视频并没有过时，只是你需要调整你的代码中的一些东西才能使其正确。


​      

      All of this is to say, use the GitHub repo to your advantage. Use it for discussions, use it for code, use Cypher and Uptraft to see the updates, and even in the GitHub repo, there will be a link to Cypher and Uptraft talking about the different updates.
    
       所有这些都是为了说明，利用 GitHub 仓库对你有利。用它来进行讨论，用它来获取代码，使用 Cypher 和 Uptraft 查看更新，即使在 GitHub 仓库中，也会有一个链接到 Cypher 和 Uptraft，讨论不同的更新。


​      

      And additionally, once we do get to the coding portion of this course, it's a good idea to code along with me as I'm explaining things. So having the video up as well as your coding screen is a good idea, so you can follow along with me as I'm explaining it.
    
       此外，一旦我们开始本课程的编码部分，在我解释事情的时候，跟着我一起编码是个好主意。因此，同时打开视频和你的编码屏幕是个好主意，这样你就可以在我解释的时候跟着我一起学习。


​      

      Take breaks. I cannot tell you how many people have tried to rush through these courses and be like, oh, I'm going to finish in a single weekend. Your brain doesn't work like that. Your brain needs time to absorb the information. So take breaks. Maybe every 25 minutes to a half hour, take a five minute break. Or maybe you like working in longer chunks. Maybe take a whole hour and then take a 15-20 minute break. Don't try to rush through the whole video in a day. You're not going to retain the information. Go outside, go for a walk, grab some ice cream, get some coffee, go to the gym. Your brain needs time to have the information settle. Maybe every two hours, just step away. Maybe be done for the day. Work at whatever pace makes sense for you. Everyone's going to have a different learning pace. There is no right speed for this course. I've had people take my courses in two weeks, in three months, in six months. It doesn't matter. Pick a pace that you can do and stick to it.
    
       休息一下。我无法告诉你有多少人试图匆忙完成这些课程，并且想，哦，我将在一个周末内完成。你的大脑不是那样工作的。你的大脑需要时间来吸收信息。所以休息一下。也许每 25 分钟到半小时，休息五分钟。或者你喜欢更长时间地工作。也许工作一整个小时，然后休息 15-20 分钟。不要试图在一天内匆忙看完整个视频。你不会记住这些信息的。出去走走，散散步，吃点冰淇淋，喝杯咖啡，去健身房。你的大脑需要时间来沉淀信息。也许每两个小时，就离开一下。也许今天就到此为止。以对你来说有意义的任何速度工作。每个人都会有不同的学习节奏。这门课程没有正确的速度。我曾有人在两周、三个月、六个月内完成我的课程。这没关系。选择一个你能做到的速度并坚持下去。


​      

      Not only work at your pace, make sure that I'm talking at a pace that makes sense for you. Now on both YouTube and Cypher and Updraft, there are ways to actually change the speed at which I speak. Here's how you can do it for YouTube. There's a little gear icon in the YouTube video here where you can change the speed of how I'm talking and how fast the video is going. So if I'm talking way too fast for you, then you can slow me down. But if I'm talking too slow, then you can speed me up. And for Cypher and Updraft, it's the same thing. There's this little marker in the bottom right where you can actually change the speed at which I talk or at which the video goes.
    
       不仅要按照你的节奏学习，还要确保我说话的速度对你来说是有意义的。现在在 YouTube 和 Cypher and Updraft 上，都有方法实际改变我说话的速度。这是你在 YouTube 上可以这样做的方法。在 YouTube 视频中有一个小齿轮图标，你可以在这里改变我说话的速度和视频播放的速度。所以如果我说话太快了，你可以放慢我的速度。但如果我说话太慢了，你可以加快我的速度。对于 Cypher 和 Updraft，也是一样。在右下角有一个小标记，你可以在那里改变我说话的速度或视频播放的速度。


​      

      Additionally, we have a closed captions feature or a subtitles feature. Right now, there's a whole list of different languages that are supported on Cypher and Updraft. If you'd like to add support for your native language, please make an issue or a discussion in the Cypher and Updraft GitHub repo.
    
       此外，我们还有一个隐藏字幕功能或字幕功能。现在，Cypher 和 Updraft 上支持一整列不同的语言。如果你想添加对你的母语的支持，请在 Cypher 和 Updraft GitHub 仓库中提出一个 issue 或发起一个讨论。


​      

      So make the adjustments you need to make me go the speed you want me to go.
    
       所以做出你需要做的调整，让我以你想要的速度进行。


​      

      And of course, this course is modular. So you can bounce around topic to topic and go to where you want to go. Like I said, go the pace and take the learnings that you want to do.
    
       当然，这门课程是模块化的。所以你可以在不同的主题之间跳跃，去你想去的地方。就像我说的，按照你的节奏学习，并学习你想学习的知识。


​      

      And after every lesson, it might be a good idea to go back and reflect on each lesson to really make sure the knowledge gets ingrained. Repetition is the mother of skill. And we're going to be repeating a lot of smart contract development.
    
       在每节课之后，回去回顾每节课，真正确保知识得到巩固，可能是一个好主意。熟能生巧。我们将重复大量的智能合约开发。


​      

      Blockchain development and open source development world is incredibly collaborative. So be sure to use tools like, of course, the GitHub discussions tab, Ethereum Stack Exchange, the decentralized Q&A forum, Piranha, issues on different GitHubs, artificial intelligence, and more. And the reason I'm putting so much emphasis on this, and that I will continue to put so much emphasis on this, knowing where to go for information and how to collaborate with people is often more important than your smart contract knowledge. Because oftentimes you're going to run into issues you don't know how to solve. So we're going to teach you to unblock yourself on this and really anything in life. Plus syncing with other people in the space makes it way more fun. And additionally in here we give some suggestions of some different AI tools or other forums where you can and should ask questions. Being a security researcher and smart contract developer oftentimes is more about knowing where to get the answer than memorizing the answer yourself.
    
       区块链开发和开源开发世界是非常协作的。所以一定要使用像 GitHub discussions 标签页，Ethereum Stack Exchange，去中心化问答论坛，Piranha，在不同的 GitHub 上的 issues，人工智能等等这样的工具。我之所以如此强调这一点，并且我将继续如此强调这一点，是因为知道在哪里获取信息以及如何与他人协作通常比你的智能合约知识更重要。因为你经常会遇到你不知道如何解决的问题。所以我们将教你如何解决这个问题，实际上是生活中的任何事情。此外，与这个领域的其他人同步会更有趣。此外，在这里我们给出了一些关于不同人工智能工具或其他你可以并且应该提问的论坛的建议。成为一名安全研究员和智能合约开发者通常更在于知道在哪里获得答案，而不是自己记住答案。


​      

      Now for people using this on Cypher and Updraft, this doesn't apply to YouTube. All of these courses additionally come with a written lesson for each one of these courses. So if you're like, wow that Patrick guy is really annoying and I would rather just read this, well then perfect. We have written lessons for each one of these lessons as well. Although we do recommend you watch the videos as well because watching these videos can actually give you a lot more context about what's something supposed to look like, what it's supposed to feel like, etc.
    
       现在对于在 Cypher 和 Updraft 上使用它的人来说，这不适用于 YouTube。所有这些课程还附带了每个课程的文字版本。所以如果你觉得，哇，那个 Patrick 真的很烦人，并且我宁愿只阅读这个，那就太好了。我们也有每个课程的文字版本。虽然我们确实建议你也观看视频，因为观看这些视频实际上可以给你更多关于某事物应该是什么样子，它应该是什么感觉等等的背景信息。


​      

      Now additionally just like all of our Updraft courses, each one of these lessons comes packed with a little challenge NFT that you can mint on a L2 to actually prove that you learned the knowledge. These are optional challenges of course. You can use them to actually claim a badge to prove you actually know how to do whatever we were teaching in that lesson or section.
    
       现在，就像我们所有的 Updraft 课程一样，每个课程都包含一个小的挑战 NFT，你可以在 L2 上铸造，以实际证明你学到了知识。这些当然是可选的挑战。你可以使用它们来实际申领一个徽章，以证明你实际上知道如何做我们在该课程或章节中教授的任何内容。


​      

      Now for this course there are a lot of prerequisites. Number one, you need a very solid grasp of solidity. Ideally you have a very solid grasp of Foundry and ideally you have gone through the security and auditing course on Cypher and Updraft. If you haven't gone through these courses on Cypher and Updraft that's okay. However I highly recommend doing the security auditing course before coming here because we teach you a lot of component skills before getting here.
    
       现在，这门课程有很多先决条件。首先，你需要非常扎实地掌握 Solidity。理想情况下，你应该非常扎实地掌握 Foundry，并且理想情况下你已经完成了 Cypher 和 Updraft 上的安全和审计课程。如果你还没有完成 Cypher 和 Updraft 上的这些课程，那也没关系。但是，我强烈建议你在来这里之前完成安全审计课程，因为我们在到达这里之前会教你很多组成技能。


​      

      Some of the tools that we're assuming that you already know how to work with are going to be Foundry, VS Code or some type of text editor, Git at least knowing how to do git clones, some basic Unix or Linux terminal commands, GitHub or any cloud git provider, and if you're on a Windows machine we assume that you have WSL installed and that's what you're working with in your text editor.
    
       我们假设你已经知道如何使用的工具包括 Foundry，VS Code 或某种类型的文本编辑器，Git 至少知道如何进行 git 克隆，一些基本的 Unix 或 Linux 终端命令，GitHub 或任何云 git 提供商，如果你使用的是 Windows 机器，我们假设你已经安装了 WSL，并且你正在文本编辑器中使用它。


​      

      If you don't have these installed we will have a link in the GitHub repo and in the written lessons of this course to the Cypher and Updraft lessons to actually install these tools so that you can go ahead and move forward.
    
       如果你没有安装这些，我们将在 GitHub 仓库和本课程的书面课程中提供一个链接，链接到 Cypher 和 Updraft 课程，以便实际安装这些工具，这样你就可以继续前进。


​      

      So if you do not have these tools listed on the screen right now installed, pause the video, go download those tools, and potentially ideally go back to the different courses that use these tools. We teach you how to use all these tools and the blockchain basics all the way up to the advanced Foundry and I highly recommend that as a prerequisite as well.
    
       所以如果你没有安装屏幕上列出的这些工具，现在就暂停视频，去下载那些工具，并且可能理想情况下回到使用这些工具的不同课程。我们教你如何使用所有这些工具和区块链基础知识，一直到高级 Foundry，我强烈建议你也将其作为先决条件。


​      

      There's a large assumption here that you're not a noob. You've been around the block and because of that I'm going to treat you as such. Get ready for a challenge that's going to level you up. So get ready for a challenging course that's going to explode your knowledge from being intermediate to advanced to a top one percent smart contract developer or security researcher.
    
       这里有一个很大的假设，你不是一个新手。你已经有了一些经验，因此我将这样对待你。准备好迎接一个将提升你的水平的挑战。所以准备好迎接一个具有挑战性的课程，它将爆炸式地增长你的知识，从中间水平到高级水平，成为顶尖的 1% 的智能合约开发者或安全研究员。


​      

      Let's dive in to section one, the horse store.
    
       让我们深入第一部分，马匹商店。


​      

      Now before we move on to Math Masters I have a little optional video for you to watch which will actually go over the differences between Vypr and Solidity but under the hood and what causes the difference in gas that they take. You've just learned a lot about the Solidity compiler just by looking at the opcodes that it puts out and especially we've learned about the Solidity free memory pointer. In this video you're actually going to learn how Vypr takes a very different approach to compilers which makes for some interesting gas trade-offs.
    
       现在在我们继续 Math Masters 之前，我有一个可选视频供你观看，它将实际介绍 Vypr 和 Solidity 之间的差异，但在底层以及是什么导致了它们所消耗的 gas 的差异。通过观察 Solidity 编译器输出的 opcodes，你已经学到了很多关于 Solidity 编译器的知识，特别是我们了解了 Solidity 的 free memory pointer。在本视频中，你将学习 Vypr 如何采用一种非常不同的编译器方法，从而产生一些有趣的 gas 权衡。


​      

      So the difference between Vypr and Solidity isn't just syntactic it's also how they operate under the hood. So if you want to learn more about how these different compilers work and how the opcodes that they generate actually are very very different then watch this excerpt of Vypr versus Solidity and why they have the gas trade-offs that they do. Have fun.
    
       因此，Vypr 和 Solidity 之间的区别不仅仅是语法上的，还在于它们在底层如何运作。因此，如果你想了解更多关于这些不同编译器如何工作，以及它们生成的 opcodes 实际上是如何非常非常不同的，那么请观看 Vypr 与 Solidity 的这段摘录，以及它们为什么会有这样的 gas 权衡。玩得开心。


​      

      Vyper or Solidity which smart contract language is better? In this video we will look at popularity, developer experience, gas optimization, opcode use, and gas optimization to compare the languages.
    
       Vyper 还是 Solidity，哪个智能合约语言更好？在本视频中，我们将从受欢迎程度、开发者体验、gas 优化、opcode 使用和 gas 优化等方面来比较这些语言。


​      

      We're going to be comparing Vypr and Solidity because they are by far the two most popular smart contract programming languages. Additionally we're going to include Huff and Yul because they are lower level languages that are great to benchmark to and you can't really fairly assess Solidity without including Yul. The language holy wars on Twitter has fueled a little bit of this debate but spoiler alert they're all fantastic languages. Additionally these languages keep improving over time and in about a year this video might be totally outdated. We'll find out.
    
       我们将比较 Vypr 和 Solidity，因为它们是目前最流行的两种智能合约编程语言。此外，我们将包括 Huff 和 Yul，因为它们是更低级别的语言，非常适合作为基准，而且如果不包括 Yul，你无法真正公平地评估 Solidity。Twitter 上的语言圣战在一定程度上助长了这场辩论，但剧透一下，它们都是非常棒的语言。此外，这些语言一直在不断改进，大约一年后这个视频可能就完全过时了。我们会发现的。


​      

      So let's start our smart contract gas smackdown.
    
       那么，让我们开始我们的智能合约 gas 大战吧。


​      

      According to DeFi Llama for total value locked Solidity secures about 87 percent of all DeFi smart contracts and then next is Vypr at about eight percent. Curve finance being a big reason that Vypr is up there. So if pure popularity is what you're looking for you don't need to look farther than Solidity.
    
       根据 DeFi Llama 的数据，就总锁定价值而言，Solidity 占据了大约 87% 的 DeFi 智能合约，其次是 Vypr，约占 8%。Curve finance 是 Vypr 占据如此高份额的一个重要原因。因此，如果纯粹的受欢迎程度是你所追求的，那么你无需再关注 Solidity 之外的语言。


​      

      Now for the next three sections we're going to compare a smart contract that does essentially the same things. It needs to have a private number at storage slot0, have a function with the read number function signature that reads what's at storage slot0 and allows you to update that number with this store number function signature. And if you'd like to follow along with all the code here we have a github repo in the description with all the code that we're going to go through.
    
       接下来三个部分，我们将比较一个智能合约，它本质上做的是相同的事情。它需要在 storage slot 0 有一个私有数字，有一个带有 read number 函数签名的函数，用于读取 storage slot 0 的值，并允许你使用这个 store number 函数签名来更新该数字。如果你想跟着学习这里的所有代码，我们在描述中提供了一个 github 仓库，其中包含所有我们将要讲解的代码。


​      

      So here's what the four contracts look like. Solidity, Vypr, Huff, Yul. Despite looking at these four contracts we can feel the developer experience of writing in these languages. Just looking at the code we can see that Solidity and Vypr are substantially quicker to write because there's way less code here. This makes a lot of sense as these are higher level languages while Yul and Huff are meant to be lower level language code. For that reason alone it's so easy to see why Vypr and Solidity have so much more adoption. Higher level languages are generally easier understood by humans with more abstraction underneath the hood, while lower level languages are the reverse of that. They're harder for humans to understand, but you can be more fine tuned with what you're doing.
    
       这就是这四个合约的样子。Solidity, Vypr, Huff, Yul。尽管看了这四个合约，我们还是能感受到用这些语言进行开发的开发者体验。仅从代码来看，我们可以看到 Solidity 和 Vypr 编写速度要快得多，因为这里的代码要少得多。这是很有道理的，因为这些是更高级的语言，而 Yul 和 Huff 旨在成为更低级别的语言代码。仅凭这一点，就很容易理解为什么 Vypr 和 Solidity 拥有更多的采用率。更高级别的语言通常更容易被人类理解，因为底层有更多的抽象，而更低级别的语言则相反。它们更难让人类理解，但你可以更精细地调整你正在做的事情。


​      

      Now let's focus on the higher level languages for a second. And I promise we're about to get to gas optimization. I promise we're so close. You can clearly see Vyper draws inspiration from Python and Solidity draws inspiration from JavaScript. So if you like Python, boom, if you like JavaScript, boom, there you go.
    
       现在让我们花点时间关注一下更高级别的语言。我保证我们马上就要讲到 gas 优化了。我保证我们快到了。你可以清楚地看到 Vyper 从 Python 中汲取灵感，而 Solidity 从 JavaScript 中汲取灵感。所以如果你喜欢 Python，那就选 Vypr，如果你喜欢 JavaScript，那就选 Solidity，就是这样。


​      

      Now let's talk developer experience tooling. I'm not going to go into tooling too much because the tooling for the high level languages is really good. And the tooling for the lower level languages isn't as good, but still good enough. Solidity definitely comes as a first class citizen for most popular frameworks like hardhat, foundry, remix, and brownie. Vyper can be added as a plugin to these but comes as a first class citizen to brownie, Apex, and Titan Boa. Often you'll have a little bit less support, but with a foundry plugin, you're good to go.
    
       现在让我们来谈谈开发者体验工具。我不会过多地介绍工具，因为高级语言的工具非常好。而低级语言的工具没有那么好，但仍然足够好。对于大多数流行的框架，例如 hardhat, foundry, remix, 和 brownie，Solidity 绝对是作为一等公民出现的。Vyper 可以作为插件添加到这些框架中，但它是 brownie, Apex, 和 Titan Boa 的一等公民。通常你会得到较少的支持，但是使用 foundry 插件，你就可以开始了。


​      

      All right, now let's talk gas. And specifically, we're going to look at the three most important parts of a smart contract, the contract creation gas costs, the contract runtime gas costs, and then the metadata as well. Contract creation gas is how much it costs to deploy your smart contract. Runtime gas costs are how much it costs to interact and call functions in your contract. And then metadata is optional data appended to the end of your code. It'll contain things like language, version, etc.
    
       好了，现在让我们来谈谈 gas。具体来说，我们将看看智能合约的三个最重要的部分，合约创建 gas 成本、合约运行时 gas 成本，以及元数据。合约创建 gas 是部署智能合约的成本。运行时 gas 成本是在合约中交互和调用函数的成本。元数据是附加到代码末尾的可选数据。它将包含诸如语言、版本等信息。


​      

      Now before we actually deploy these and see the gas comparisons, we actually need to compile these contracts. Now there's a lot of different flags we can use to compile them more gas efficiently or less gas efficiently. And I'm sure I'm going to get a ton of comments because I already know some of the ways that I could have made these more gas efficient. But we've chosen just to go with some relatively popular settings for compiling your contracts. And if you want to check out the GitHub repo associated with this, you can see those or we will put them on the screen right here.
    
       在我们实际部署这些合约并查看 gas 比较之前，我们实际上需要编译这些合约。现在有很多不同的标志可以使用，以便更高效或更低效地编译它们。我确信我会收到大量的评论，因为我已经知道一些可以使这些合约更节省 gas 的方法。但我们选择了一些相对流行的设置来编译你的合约。如果你想查看与此相关的 GitHub 仓库，你可以查看这些设置，或者我们会将它们放在屏幕上。


​      

      And after we compile them, we can now deploy them and see how much gas they consume. Now you'll notice this fifth column here called Sol-Yul. Solidity can be combined with the Yul programming language, which again is one of these lower level programming languages to make your Solidity go faster or be more performant. The idea here is that you get the high level advantages of Solidity while being able to tinker down with the EVM when you need to.
    
       在我们编译它们之后，我们现在可以部署它们并查看它们消耗多少 gas。现在你会注意到这里的第五列叫做 Sol-Yul。Solidity 可以与 Yul 编程语言结合使用，Yul 再次是一种更低级别的编程语言，可以使你的 Solidity 运行得更快或性能更高。这里的想法是，你可以获得 Solidity 的高级优势，同时能够在需要时对 EVM 进行调整。


​      

      As we can see, lower level languages like Huff and Yul are more gas efficient than Vypr and Solidity, which makes sense because they're lower level. Vypr seems to be a little bit more efficient than Solidity and Huff and Yul seem to be both more efficient than both Vypr and Solidity. Our Sol-Yul seems to be the worst by far, but we'll see why that normally isn't the case.
    
       正如我们所看到的，像 Huff 和 Yul 这样的低级语言比 Vypr 和 Solidity 更节省 gas，这是有道理的，因为它们是更低级别的语言。Vypr 似乎比 Solidity 稍微有效率一些，而 Huff 和 Yul 似乎都比 Vypr 和 Solidity 更有效率。我们的 Sol-Yul 似乎是最差的，但我们将看看为什么通常情况下不是这样。


​      

      Now before we understand any of these differences of the contract creation code, let's look at the runtime differences. Remember, we're going to be storing a number and reading a number from our contracts. And here are those results. We didn't have data for Yul because I didn't feel like making a Yul foundry plugin, but I'm sure the gas costs there are going to be similar to that of Huff. Keep in mind, the gas costs here are running a whole testing function. That's why the number seems so much higher than it probably actually is. But we can still see there's a major difference in gas between these languages.
    
       在我们理解合约创建代码的任何这些差异之前，让我们看看运行时的差异。记住，我们将从我们的合约中存储一个数字并读取一个数字。这是这些结果。我们没有 Yul 的数据，因为我不想制作一个 Yul foundry 插件，但我确信那里的 gas 成本将与 Huff 相似。请记住，这里的 gas 成本是运行整个测试函数。这就是为什么这个数字看起来比实际可能要高得多。但是我们仍然可以看到这些语言之间的 gas 存在重大差异。


​      

      Okay, so let's go back to the contract creation. So now we have a good idea of approximately what we're working with here. Now, I got to warn you, we are about to get really nerdy, like really nerdy. And for this section, it's good to have some understanding of how EVM opcodes work. So I've left a link in the description to the OpenZeppelin deconstructing a Solidity smart contract, which will give you a really good idea of how these contracts work and a lot of the opcodes associated with them. Because yes, we're going into opcodes now. So feel free to pause and take a look at that now.
    
       好的，让我们回到合约创建。现在我们对我们在这里处理的内容有了一个大致的了解。现在，我必须警告你，我们即将变得非常书呆子气，非常书呆子气。对于本节，最好对 EVM opcodes 的工作方式有所了解。因此，我在描述中留下了一个链接，指向 OpenZeppelin 的解构 Solidity 智能合约，这将使你对这些合约的工作方式以及与之相关的许多 opcodes 有一个很好的了解。因为是的，我们现在要进入 opcodes 了。所以请随时暂停并立即查看。


​      

      Again, remember when you compile a smart contract, it's typically split up into the contract creation code, the actual runtime code, and then optional metadata and then constructor arguments, but we're not going to go into that.
    
       再次，请记住，当你编译一个智能合约时，它通常分为合约创建代码、实际运行时代码，然后是可选的元数据和构造函数参数，但我们不会深入探讨。


​      ![image-20251027121833117](images/image-20251027121833117.png)

      Now brace your eyes because here come the opcodes. In your compiled bytecode, you can typically find the three different sections creation code, runtime code and metadata by looking at your bytecode and looking to see what sections are unreachable. This can be a little tricky, but typically looking for return opcodes, the F3 binary is a good place to start. You can also look for opcodes like 39, which is the code copy opcode, which copies your contract onto the blockchain. And instead of looking directly at the binary, usually it's easier to look at the opcodes instead. Most compilers have an option to output the opcodes instead of just the binary. The Solidity Compiler does something really nice for organization and adds an invalid opcode between these three sections to make them real easy to locate. Section A is our contract creation code, section B is our runtime code and section C is our metadata.
    
       现在睁大你的眼睛，因为 opcodes 来了。在编译后的 bytecode 中，你通常可以通过查看你的 bytecode 并查看哪些部分是无法访问的来找到三个不同的部分：创建代码、运行时代码和元数据。这可能有点棘手，但通常寻找返回 opcodes，F3 二进制文件是一个很好的起点。你也可以寻找像 39 这样的 opcodes，它是代码复制 opcode，它将你的合约复制到区块链上。而且通常查看操作码而不是直接查看二进制文件会更容易。大多数编译器都有一个选项可以输出操作码，而不仅仅是二进制文件。Solidity 编译器在组织方面做得非常好，并在这三个部分之间添加一个无效操作码，使它们非常容易定位。A 部分是我们的合约创建代码，B 部分是我们的运行时代码，C 部分是我们的元数据。


​      

      So for our contract creation gas comparisons, we want to focus on our sections A.
    
       因此，对于我们的合约创建 Gas 比较，我们希望专注于 A 部分。


​      

      Now here is the full binary of the contract creation code for all of these contracts. That's it. It's only a few opcodes that make up the contract creation bytecode. We aren't going to go over what every opcode and every piece of binary is doing here, but in the article associated with this video, again, in the description, we go over that for you if you're interested. Instead in this video, we're just going to focus on what each language is doing differently to make for these gas differences.
    
       现在，这是所有这些合约的合约创建代码的完整二进制文件。就这样。只有几个操作码组成了合约创建字节码。我们不会详细介绍每个操作码和每个部分的二进制文件在这里的作用，但在与此视频相关的文章中，同样在描述中，如果你有兴趣，我们会为你介绍。相反，在本视频中，我们将只关注每种语言的不同之处，从而导致这些 Gas 差异。


​      

      Now for contract creation, Huff, Vyper and Yul do pretty much nearly exactly the same thing. This list of seven opcodes just takes your code and sticks it on chain. That's it. Now Solidity takes a slightly different route. And even these opcodes still do approximately what the other languages do. You can still see the code copy opcode here as well. It's all this extra stuff at the beginning that makes the differences in gas. Solidity is doing the following extra work. It's creating a free memory pointer, and then checking to see if you sent any ETH when deploying your contract. And remember, these little bits of extra work costs gas. Anything you do extra costs gas.
    
       现在对于合约创建，Huff, Vyper 和 Yul 几乎做了完全相同的事情。这七个操作码的列表只是获取你的代码并将其放在链上。就这样。现在 Solidity 采取了稍微不同的路线。即使这些操作码仍然大致执行其他语言所做的事情。你仍然可以在这里看到代码复制操作码。正是开头的所有这些额外的东西导致了 Gas 的差异。Solidity 正在执行以下额外工作。它正在创建一个空闲内存指针，然后检查在部署合约时是否发送了任何 ETH。请记住，这些额外的少量工作会消耗 Gas。你做的任何额外的事情都会消耗 Gas。


​      

      We'll talk about the free memory pointer later. But one of these things that is fantastic is it is checking to see if we're sending ETH with our contract. This is advantageous so that we don't accidentally send some ETH that becomes unrecoverable. We don't lock ETH into our contract forever. Solidity is looking out for us.
    
       我们稍后会讨论空闲内存指针。但其中一件很棒的事情是它正在检查看看我们是否正在通过我们的合约发送 ETH。这很有利，这样我们就不会意外地发送一些无法恢复的 ETH。我们不会将 ETH 永远锁定在我们的合约中。Solidity 正在为我们着想。


​      

      Interestingly, if you add a constructor to your Vyper code, and then recompile, you'll get an ETH check in the Vyper binary as well. Vyper and Solidity looking out for us devs.
    
       有趣的是，如果你将构造函数添加到你的 Vyper 代码中，然后重新编译，你也会在 Vyper 二进制文件中获得 ETH 检查。Vyper 和 Solidity 都在为我们开发者着想。


​      

      Now it's these additive checks that are looking out for us are typically what make Vyper and Solidity more expensive than Huff and Yul. They're doing some extra work under the hood to look out for us and protect us from doing something stupid.
    
       现在，正是这些为我们着想的附加检查通常使 Vyper 和 Solidity 比 Huff 和 Yul 更昂贵。他们在幕后做一些额外的工作来关注我们并保护我们免于做一些愚蠢的事情。


​      

      Yul and Huff on the other hand are gonna say hey, we're gonna do only what you tell us to do. We're not doing any checks unless you tell us to do some checks.
    
       另一方面，Yul 和 Huff 会说，嘿，我们只会做你告诉我们做的事情。除非你告诉我们做一些检查，否则我们不会做任何检查。


​      

      And it's this extra free memory pointer, which is why the Solidity code here is going to be so much more gas expensive. The Vyper code after the Solidity and Solidity-Yul is going to be the second most expensive because the Vyper runtime code is just going to be bigger because it also does a lot of checks that we're going to see in a minute. While Huff and Yul are going to be around the same.
    
       正是这个额外的空闲内存指针，这就是为什么这里的 Solidity 代码会消耗更多的 Gas。在 Solidity 和 Solidity-Yul 之后的 Vyper 代码将成为第二昂贵的，因为 Vyper 运行时代码只会更大，因为它也做了很多检查，我们稍后会看到。而 Huff 和 Yul 将大致相同。


​      

      Now let's talk runtime code. Remember for the runtime code, we're measuring how much it costs to store and then how much it costs to read from our contract. And I was able to walk opcode by opcode through this by using foundry test --debug and then my test function. It's really nice. I highly recommend you try it out.
    
       现在让我们谈谈运行时代码。请记住，对于运行时代码，我们正在衡量存储成本然后从我们的合约中读取的成本。我能够使用 foundry test --debug 然后是我的测试函数，逐个操作码地完成此操作。这真的很好。我强烈建议你尝试一下。


​      

      Let's start with Huff. And we'll just look at storing the number 77 by calling the store number function signature. Here are the opcodes for calling store number. The first thing that our contract does is it'll figure out what function to call based on the data that's sent. We send over data associated with the store number function. Then we store the data in the contract. Boom, that's it.
    
       让我们从 Huff 开始。我们将只看看通过调用存储数字函数签名来存储数字 77。以下是调用存储数字的操作码。我们的合约做的第一件事是它会根据发送的数据弄清楚要调用什么函数。我们发送与存储数字函数相关的数据。然后我们将数据存储在合约中。砰，就这样。


​      ![image-20251027122539198](images/image-20251027122539198.png)

      Let's see what Vyper and Solidity add on here. Vyper is still doing those first two pieces that Huff does. Although it looks like we add three checks in here. We make sure we have enough data to call a function. We make sure we didn't send any ETH and then we make sure we have enough data for a number. These checks make sure that users don't accidentally send some data to our contract that screws it up or locks money in our contract forever. It costs extra gas, but it makes us extra safe.
    
       让我们看看 Vyper 和 Solidity 在这里添加了什么。Vyper 仍然在做 Huff 所做的前两件事。虽然看起来我们在这里添加了三个检查。我们确保有足够的数据来调用函数。我们确保没有发送任何 ETH，然后我们确保有足够的数据来表示一个数字。这些检查确保用户不会意外地将一些数据发送到我们的合约，导致它崩溃或将资金永远锁定在我们的合约中。它会消耗额外的 Gas，但它使我们更加安全。


​      

      Now let's see what the major difference in Solidity is. We can see Solidity does the same three checks, has that additional free memory pointer, and takes a slightly different route on how it sets up the contract and does the checks.
    
       现在让我们看看 Solidity 的主要区别是什么。我们可以看到 Solidity 做了相同的三个检查，具有额外的空闲内存指针，并在如何设置合约和进行检查方面采取了稍微不同的路线。


​      

      So what are the main differences between these languages? Solidity has the free memory pointer. Vyper and Solidity both do extra checks on ETH and data size, and they all have slight difference in which opcodes they use to do what. That last piece typically makes negligible gas differences, but it's interesting nonetheless. For example, Solidity uses is zero versus Vyper uses XOR, even though they kind of do the same thing, and it doesn't really make a difference.
    
       那么这些语言之间的主要区别是什么？Solidity 具有空闲内存指针。Vyper 和 Solidity 都对 ETH 和数据大小进行额外的检查，并且它们都在使用哪些操作码来做什么方面略有不同。最后一部分通常会产生可以忽略不计的 Gas 差异，但尽管如此，它还是很有趣的。例如，Solidity 使用 is zero，而 Vyper 使用 XOR，即使它们有点做同样的事情，而且实际上并没有什么区别。


​      

      But okay, so what's this free memory pointer? Why does Solidity have it but not Yul, not Vyper, and not Huff? And here's another one of the major differences between the languages, how they manipulate memory. Memory in the EVM is a big array that is alive for the duration of a function. Once the function ends, memory ends. And when you want to put something new into memory, the free memory pointer always points to the end of the memory. So you always know what index you can add memory to. If you want to add memory, check the free memory pointer, add your stuff to where it's pointing, and then update the pointer. This is great since there are data structures like dynamic arrays that we may have to load into memory, and they won't be sure how much memory we need to allocate them. So we need a way to allocate dynamic amounts of memory.
    
       但是，好吧，那么这个空闲内存指针是什么？为什么 Solidity 有它，但 Yul、Vyper 和 Huff 没有？这是这些语言之间的另一个主要区别，即它们如何操作内存。EVM 中的内存是一个大数组，它在函数执行期间一直存在。一旦函数结束，内存就结束。当你想在内存中放入新的东西时，空闲内存指针始终指向内存的末尾。所以你总是知道你可以将内存添加到哪个索引。如果你想添加内存，检查空闲内存指针，将你的东西添加到它指向的位置，然后更新指针。这很棒，因为有一些数据结构，如动态数组，我们可能需要加载到内存中，并且它们不确定我们需要为它们分配多少内存。所以我们需要一种分配动态内存量的方法。


​      

      Vyper does this a little differently. Vyper doesn't allow for variables to be of unknown sizes. So it doesn't need a free memory pointer because it always knows exactly how much memory it's going to need to call a function. So instead, at runtime, Vyper just allocates the spots where it needs and assigns everything to a position in memory. This is also why Vyper doesn't get stacked to deep errors since it's using memory statically as opposed to dynamically. In Vyper, there are no dynamic data structures. You are forced to say exactly how big your arrays and how big your objects are, which is why Vyper can assign memory statically.
    
       Vyper 对此的处理方式略有不同。Vyper 不允许变量具有未知大小。所以它不需要空闲内存指针，因为它总是准确地知道调用函数需要多少内存。因此，相反，在运行时，Vyper 只分配它需要的位置并将所有内容分配到内存中的一个位置。这也是为什么 Vyper 不会出现堆栈太深错误，因为它使用静态内存而不是动态内存。在 Vyper 中，没有动态数据结构。你必须准确说明你的数组有多大以及你的对象有多大，这就是为什么 Vyper 可以静态分配内存。


​      

      Now, this might sound like an advantage, and you'd be like, oh, why doesn't every language just do that? Let's look at an example of a tradeoff. In Solidity, we can declare a dynamic array with no size constraint. We can always push more items to an array, and when we load the array into memory, our array could be of any size since the array is dynamic, and we need the free memory pointer to know where to put our memory. In Vyper, you can have a dynamic array, but you must specify a maximum size. When you load an array into memory, Vyper will always know exactly how much memory it needs, so it doesn't need the free memory pointer. This means that Vyper can often be more gas efficient than Solidity when it comes to memory management. This can be seen as an advantage or a disadvantage depending on who you talk to.
    
       现在，这听起来可能像是一个优势，你会想，哦，为什么每种语言都不这样做呢？让我们看一个权衡的例子。在 Solidity 中，我们可以声明一个没有大小限制的动态数组。我们总是可以将更多项目推送到数组中，当我们将数组加载到内存中时，我们的数组可以是任何大小，因为数组是动态的，我们需要空闲内存指针来知道在哪里放置我们的内存。在 Vyper 中，你可以拥有一个动态数组，但你必须指定一个最大大小。当你将数组加载到内存中时，Vyper 将始终准确地知道它需要多少内存，因此它不需要空闲内存指针。这意味着 Vyper 在内存管理方面通常比 Solidity 更节省 Gas。这可以被看作是一个优势或劣势，这取决于你和谁交谈。


​      

      And remember, Huff and Yul don't do any of this, they just do exactly what you tell them to do.
    
       请记住，Huff 和 Yul 不做任何这些，它们只是完全按照你告诉它们做的去做。


​      

      Speaking of Yul, though, looking at my chart above, working with Solidity and Yul seems to be like the worst option, since at least the contract creation code is so much more expensive. However, we know from bigger projects that this isn't the case. One of the most popular projects that was written as a Solidity version, and then as a Solidity and Yul version is the Cport project. And after a git clone and a few tweaks, we can run our gas comparisons. On average, the function calls performed 25% better on the Solidity and Yul versions, and the contract creation performed about 40% better. That's a lot of gas. I wonder how much they could have saved in pure Yul. I wonder how much they could have saved with Vyper. I wonder.
    
       说到 Yul，不过，看看我上面的图表，使用 Solidity 和 Yul 似乎是最糟糕的选择，因为至少合约创建代码要贵得多。但是，我们从更大的项目中知道情况并非如此。最流行的项目之一是用 Solidity 编写的，然后是 Solidity 和 Yul 版本，即 Cport 项目。在 git clone 和一些调整之后，我们可以运行我们的 gas 消耗对比。平均而言，Solidity 和 Yul 版本的函数调用性能提高了 25%，合约创建性能提高了约 40%。这节省了很多 gas。我想知道如果用纯 Yul 编写，他们能节省多少。我想知道如果用 Vyper 编写，他们能节省多少。我想知道。


​      

      And finally, the metadata. Vyper and Solidity both append some extra data to the end of our contracts. It's small enough, though, and it's only a one time expenditure. So we're basically going to ignore it. And if you want to, you can chop it off anyways.
    
       最后是元数据。Vyper 和 Solidity 都会在合约末尾附加一些额外的数据。不过它足够小，而且只是一次性的开销。所以我们基本上会忽略它。如果你想，你也可以把它去掉。


​      

      Okay, we've gone through a lot here.
    
       好了，我们已经讲了很多了。


​      

      So I know at the beginning, I told you use whatever you want, but it's time for my official recommendation. And my official recommendation for the smart contract language that you should use is whatever you want to use.
    
       所以我知道一开始我告诉你们用任何你们想用的，但现在是时候给出我的正式建议了。我正式建议你使用的智能合约语言是任何你想用的。


​      

      But seriously, each one of these has their advantages and is worthwhile for production EVM code. And here are my final thoughts on all of this.
    
       但说真的，每一种语言都有其优点，并且值得用于生产环境的 EVM 代码。以下是我对所有这些的最终想法。


​      

      If you're coding production smart contracts, use Vyper or Solidity. They're both high level languages that will protect you from shooting yourself in the foot by looking at calldata sizes and accidentally sending E and safe math. And they're just both great languages. So pick whichever one and have fun.
    
       如果你正在编写生产环境的智能合约，请使用 Vyper 或 Solidity。它们都是高级语言，可以通过查看 calldata 大小和意外发送 E 和安全数学运算来保护你免于自食其果。它们都是很棒的语言。所以选择任何一个并享受乐趣。


​      

      Huff and Yul are fantastic languages, if you need very specifically performant code, or you're looking to learn more about the EVM. I don't recommend using these languages for all your production code. I do think though they are fantastic to learn and understand.
    
       Huff 和 Yul 是非常棒的语言，如果你需要非常具体的性能代码，或者你希望更多地了解 EVM。我不建议将这些语言用于所有生产代码。但我认为它们非常适合学习和理解。


​      

      And then finally, understand the memory differences between Vyper and Solidity. Again, one of the main differences in our gas costs is going to be this free memory pointer. Keep this in mind when you get advanced and you're looking to understand more of the underlying differences between these tools.
    
       最后，了解 Vyper 和 Solidity 之间的内存差异。同样，我们的 gas 成本的主要差异之一是这个空闲内存指针。当你变得更高级并希望更多地了解这些工具之间的根本差异时，请记住这一点。


​      

      We have learned a lot here. I hope you did too.
    
       我们在这里学到了很多。我希望你也一样。


​      

      Now these languages will continue to evolve and will likely continue to see more EVM languages pop up like Reach or Fae. Fee? Fae? Fie? I don't know how to pronounce it. And I'm willing to bet a lot of this video will might be outdated in a year because these teams are moving so fast building these amazing languages.
    
       现在，这些语言将继续发展，并且可能会继续看到更多 EVM 语言涌现，例如 Reach 或 Fae。Fee? Fae? Fie? 我不知道该怎么发音。我敢打赌，这个视频的很多内容可能会在一年内过时，因为这些团队的开发速度太快了，构建这些令人惊叹的语言。


​      

      So huge thank you to both Solidity and Vyper teams for building these awesome languages and all the other teams working on fantastic EVM languages and all smart contract languages for that matter.
    
       非常感谢 Solidity 和 Vyper 团队构建了这些很棒的语言，以及所有其他致力于开发出色的 EVM 语言以及所有智能合约语言的团队。


​      

      And that's it. Hope you learned a lot. Let me know in the comments section if you learned anything or if you hated the way I compiled my contracts because I'm sure some of you did or if when you did some gas comparisons, you found something else and we'll see you next time.
    
       就这样。希望你学到了很多。如果你学到了什么，请在评论区告诉我，或者如果你讨厌我编译合约的方式，因为我确信你们中的一些人会这样，或者当你进行一些 gas 消耗对比时，你发现了其他的东西，我们下次再见。