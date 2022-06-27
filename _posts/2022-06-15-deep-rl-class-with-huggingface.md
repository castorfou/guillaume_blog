---
title: "Deep RL class - huggingface"
description: par Thomas Simonini
toc: true
comments: true
layout: post
categories: [reinforcement learning, huggingface]
image: images/RL.png
---

Didn't mention that but I have started [The Hugging Face Deep Reinforcement Learning Class](https://github.com/huggingface/deep-rl-class) by Thomas Simonini.

Thomas is now part of HuggingFace.

1st step is to fork the repo, and for mine it is [here](https://github.com/castorfou/deep-rl-class).

And clone it locally: `git clone git@github.com:castorfou/deep-rl-class.git`



I followed the 1st unit in May/11.

there is a community on discord at [https://discord.gg/aYka4Yhff9](https://discord.gg/aYka4Yhff9), with a lounge about RL.

# [Unit 1](https://github.com/huggingface/deep-rl-class/tree/main/unit1) - Introduction to Deep Reinforcement Learning

* It starts with some [general introduction to deep RL](https://huggingface.co/blog/deep-rl-intro) and then a quizz.
* 1st practice uses this lunar lander environment, and you train a PPO agent to get the highest score, 
* and this runs on colab : [https://github.com/huggingface/deep-rl-class/blob/main/unit1/unit1.ipynb](https://github.com/huggingface/deep-rl-class/blob/main/unit1/unit1.ipynb) (just by clicking on ![https://camo.githubusercontent.com/84f0493939e0c4de4e6dbe113251b4bfb5353e57134ffd9fcab6b8714514d4d1/68747470733a2f2f636f6c61622e72657365617263682e676f6f676c652e636f6d2f6173736574732f636f6c61622d62616467652e737667](https://camo.githubusercontent.com/84f0493939e0c4de4e6dbe113251b4bfb5353e57134ffd9fcab6b8714514d4d1/68747470733a2f2f636f6c61622e72657365617263682e676f6f676c652e636f6d2f6173736574732f636f6c61622d62616467652e737667))
* there is a leaderboard running under huggingface (one can publish models to huggingface) [https://huggingface.co/spaces/chrisjay/Deep-Reinforcement-Learning-Leaderboard](https://huggingface.co/spaces/chrisjay/Deep-Reinforcement-Learning-Leaderboard) . Just need an huggingface account for that (used my Michelin account)

A guide has been recently added explaining how to tune hyperparameters using optuna. 👉 [https://github.com/huggingface/deep-rl-class/blob/main/unit1/unit1_optuna_guide.ipynb](https://github.com/huggingface/deep-rl-class/blob/main/unit1/unit1_optuna_guide.ipynb). Should do it!



To start unit2. Introduction to Q-Learning

* first update from fork just by clicking<img src="https://docs.github.com/assets/cb-33131/images/help/repository/fetch-upstream-drop-down.png" alt="&quot;Fetch upstream&quot; drop-down" style="zoom:15%;" />
* and update your local repo (`git fetch` `git pull`)



# [Unit 2](https://github.com/huggingface/deep-rl-class/tree/main/unit2) - Introduction to Q-Learning

* [part 1](https://huggingface.co/blog/deep-rl-q-part1) - we learned about the value-based methods and the difference between Monte Carlo and Temporal Difference Learning. Then a quizz (easy one)
* [part 2](https://huggingface.co/blog/deep-rl-q-part2) - and then Q-learning which is an **off-policy value-based method that uses a TD approach to train its action-value function**. Then a quizz (less easier)
* and [hands-on](https://colab.research.google.com/github/huggingface/deep-rl-class/blob/main/unit2/unit2.ipynb). 1st algo (FrozenLake) is published in [Guillaume63/q-FrozenLake-v1-4x4-noSlippery](https://huggingface.co/Guillaume63/q-FrozenLake-v1-4x4-noSlippery). 2nd algo (Taxi) is published in [Guillaume63/q-Taxi-v3](https://huggingface.co/Guillaume63/q-Taxi-v3). Leaderboard is [here](https://huggingface.co/spaces/chrisjay/Deep-Reinforcement-Learning-Leaderboard)



# [Unit 3](https://github.com/huggingface/deep-rl-class/tree/main/unit3) - Deep Q-Learning with Atari Games

* The Deep Q-Learning chapter 👾 👉  [https://huggingface.co/blog/deep-rl-dqn](https://huggingface.co/blog/deep-rl-dqn)
* Start the tutorial here 👉 [https://colab.research.google.com/github/huggingface/deep-rl-class/blob/main/unit3/unit3.ipynb](https://colab.research.google.com/github/huggingface/deep-rl-class/blob/main/unit3/unit3.ipynb)

from discord, a video (30') by Antonin Raffin about [Automatic Hyperparameter Optimization @ ICRA 22 - Tools for Robotic RL 6/8](https://www.youtube.com/watch?v=AidFTOdGNFQ). Never thought about it that way, it can help to speed training phase.

from discord as well a video to build a [doom ai model](https://www.youtube.com/watch?v=eBCU-tqLGfQ) (3 hours!)