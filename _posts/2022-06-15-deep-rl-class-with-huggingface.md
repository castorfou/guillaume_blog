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

and from discord a lecture from Pieter Abbeel explaining Q-value to DQN and why we have this double network at [L2 Deep Q-Learning (Foundations of Deep RL Series](https://www.youtube.com/watch?v=Psrhxy88zww). This is part of a larger lecture available at [Foundations of Deep RL -- 6-lecture series by Pieter Abbeel](https://www.youtube.com/watch?v=2GwBez0D20A&list=PLwRJQ4m4UJjNymuBM9RdmB3Z9N5-0IlY0)

And then a video explaining [Deep RL at the Edge of the Statistical Precipice](https://agarwl.github.io/rliable/). This was from a paper at Neurips.



# [Unit 4](https://thomassimonini.medium.com/an-introduction-to-unity-ml-agents-with-hugging-face-efbac62c8c80) - An Introduction to **Unity ML-Agents with Hugging Face 🤗**

(no post in github for this one) Thomas starts with evolutions on RL domain, citing [Decision Transformers](https://huggingface.co/blog/decision-transformers) as one of the last hot topic. And then introduces Unity and how it can now be used with RL agents.

![unity ML-Agents toolkit](https://miro.medium.com/max/1400/0*kYixBHKWwmY65Mg_)

Interesting idea to introduce [curiosity](https://medium.com/data-from-the-trenches/curiosity-driven-learning-through-next-state-prediction-f7f4e2f592fa) and to make it real as an intrinsic reward. 



> *Note: It guided me to gentle introductions to [cross-entropy for machine learning](https://machinelearningmastery.com/cross-entropy-for-machine-learning/) and [information entropy](https://machinelearningmastery.com/what-is-information-entropy/).*
>
> - ***Low Probability Event** (surprising): More information. High entropy.*
>
> - ***Higher Probability Event** (unsurprising): Less information. Low entropy.*
>
> - ***Skewed Probability Distribution** (unsurprising): Low entropy.*
>
> - ***Balanced Probability Distribution** (surprising): High entropy.*
>
> 
>
> $$
> Information:
> 
> \\h(x)=-\log(P(x))
> $$
>
> $$
> Entropy:
> \\H(X) = – \sum_{x \in X} P(x)  \log(P(x))
> $$
>
> $$
> Cross-Entropy:\\H(P, Q) = – \sum_{x \in X} P(x)  \log(Q(x))
> $$
> 
>
> Cross-Entropy and KL divergence are similar but not exactly the same. Specifically, the KL divergence measures a very similar quantity to  cross-entropy. It measures the average number of extra bits required to  represent a message with Q instead of P, not the total number of bits.
>
>
>
>$$
>KL\ Divergence\ (relative\ entropy):
> \\KL(P||Q)=– \sum_{x \in X} P(x)  \frac{\log(Q(x))}{\log(P(x))}
> \\H(P, Q) = H(P) + KL(P || Q)
> $$
> 
> 

Here are the steps for the training:

* clone repo and install environment

```bash
# from ~/git/guillaume
git clone https://github.com/huggingface/ml-agents/
# bug with python 3.9 - https://github.com/Unity-Technologies/ml-agents/issues/5689
conda create  --name ml-agents python=3.8
conda activate ml-agents
# Go inside the repository and install the package 
cd ml-agents 
pip install -e ./ml-agents-envs 
pip install -e ./ml-agents
```

* download the Environment Executable (pyramids from [google drive](https://drive.google.com/drive/folders/1cjUOCB6gikJHmOnoQ5R9oM7-_zAFXuA2))

Unzip it and place it inside the MLAgents cloned repo **in a new folder called trained-envs-executables/linux**

* modify nbr of steps to 1000000 in `config/ppo/PyramidsRND.yaml`
* train

```bash
mlagents-learn config/ppo/PyramidsRND.yaml --env=training-envs-executables/linux/Pyramids/Pyramids --run-id="First Training" --no-graphics
```

* monitor training

```bash
tensorboard --logdir results --port 6006
```

(auto reload is off by default this day, click settings and check Reload data) (because I have installed v2.3.0 and not 2.4.0, there is [no autofit domain to data](https://github.com/tensorflow/tensorboard/issues/1946) and it is annoying)

* push to 🤗 Hub

Create a new token (https://huggingface.co/settings/tokens) **with write role**

Copy the token, Run this and past the token `huggingface-cli login`

Push to Hub

```bash
mlagents-push-to-hf --run-id='First Training' --local-dir='results/First Training' --repo-id='Guillaume63/MLAgents-Pyramids' --commit-message='Trained pyramids agent upload'
```

and now I can play it from [https://huggingface.co/Guillaume63/MLAgents-Pyramids](https://huggingface.co/Guillaume63/MLAgents-Pyramids) and watch your Agent play...

