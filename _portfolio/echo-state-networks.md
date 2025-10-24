---
title: "Echo State Reservoirs for Reinforcement Learning"
excerpt: "Reservoir computing modules that stabilize policy gradients with lightweight memory."
collection: portfolio
---

## Overview

The [ESN-for-RL](https://github.com/annakuchko/ESN-for-RL) project equips policy-gradient agents with an
Echo State Network (ESN) front-end so they can reason over partial observations without heavy recurrent
training. A frozen random reservoir transforms observation streams into rich temporal embeddings, while a
trainable linear readout feeds downstream policies.

### Applications & Use Cases

- **Robotics simulation** where sensors are noisy and delays make raw state vectors unreliable.
- **Operations research** workloads that rely on cheap simulators (inventory control, queue management) but
  still need temporal credit assignment.
- **Educational labs** that want an approachable bridge between classical control theory and modern deep RL.

### Repository Highlights

- `esn/reservoir.py` builds sparse reservoirs with spectral-radius normalisation and teacher forcing hooks.
- `agents/policy_wrappers.py` bolts ESN embeddings onto PPO, SAC, and DQN policies with minimal boilerplate.
- `experiments/` contains reproducible Jupyter notebooks that sweep hyperparameters and log reward curves.
- `viz/latent_projections.py` projects reservoir states into 2D manifolds to debug mode collapse and drift.

### Code Walkthrough

```python
from esn.reservoir import EchoStateReservoir
from agents.policy_wrappers import ESNAugmentedPolicy

reservoir = EchoStateReservoir(
    input_dim=env.observation_space.shape[0],
    reservoir_size=1500,
    spectral_radius=0.9,
    sparsity=0.1,
)
policy = ESNAugmentedPolicy(base_agent="ppo", reservoir=reservoir)
policy.train(env_id="CartPole-v1", total_steps=400_000)
```

The wrapper keeps ESN parameters frozen while letting the policy head adapt, producing smoother learning
curves and better sample efficiency on sparse-reward tasks.

[Read the experiment log]({{ '/posts/2024/06/echo-state-networks-rl/' | relative_url }}){: .btn .btn--primary}
[Explore the ESN-for-RL repository](https://github.com/annakuchko/ESN-for-RL){: .btn .btn--inverse}
