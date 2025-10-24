---
title: "Thompson Sampling Logbook"
excerpt: "A Bayesian experimentation lab that turns posterior math into auditable notebooks."
collection: portfolio
---

## Overview

The [thompson_log](https://github.com/annakuchko/thompson_log) lab converts theory notes on Bayesian bandits
into executable experiments. Each notebook incrementally introduces priors, likelihoods, and contextual
features so teams can watch decision boundaries evolve round by round.

### Applications & Use Cases

- **Product analytics** teams running sequential tests that must balance discovery with exploitation.
- **Ad-tech bidders** calibrating click-through rate models while respecting spend caps.
- **Academic courses** that need transparent simulations of posterior updates for classroom discussion.

### Repository Highlights

- `bandits/bernoulli.py`, `bandits/gaussian.py`, and `bandits/contextual.py` provide plug-and-play reward
  simulators with reproducible randomness and logging.
- `agents/` implements Thompson Sampling policies with optional hierarchical priors and contextual feature
  transforms.
- `experiments/` notebooks stitch agents and bandits together, saving posterior traces and regret curves to
  `artifacts/runs/` for later inspection.
- `dashboards/streamlit_app.py` publishes an interactive regret explorer that non-technical stakeholders can
  use to replay decisions.

### Code Walkthrough

```python
from agents.contextual import LinearThompson
from bandits.contextual import ContextualLinearBandit

bandit = ContextualLinearBandit(n_arms=5, context_dim=12, noise_std=0.05)
agent = LinearThompson(prior_mean=0.0, prior_cov=0.5, exploration_bonus=2.0)

for t in range(5_000):
    context = bandit.sample_context()
    arm = agent.select_arm(context)
    reward = bandit.pull(arm, context)
    agent.update(arm, reward, context)
```

Every run persists posterior parameters and reward histories, making it easy to reproduce dashboards or
export CSVs for compliance reviews.

[Read the project story]({{ '/posts/2024/06/thompson-log/' | relative_url }}){: .btn .btn--primary}
[Inspect the thompson_log repo](https://github.com/annakuchko/thompson_log){: .btn .btn--inverse}
