---
title: "Inverse Optimal Stopping Solver"
excerpt: "Learning hidden reward functions from observed exercise decisions."
collection: portfolio
---

## Overview

The [inverse-optimal-stopping](https://github.com/annakuchko/inverse-optimal-stopping) project flips the
classical optimal stopping problem: rather than solving for the best decision rule, it infers the reward
surface that would make observed stopping times rational. The differentiable pipeline makes it practical to
interrogate real trading or operational logs.

### Applications & Use Cases

- **Structured products desks** reverse-engineering the utility functions implied by client exercise
  decisions.
- **Operations research teams** diagnosing why call-centre workflows or inventory policies stop at specific
  thresholds.
- **Academic collaborations** exploring identifiability of stopping problems with partial observations.

### Repository Highlights

- `models/diffusions.py` simulates geometric Brownian motion and Ornstein–Uhlenbeck processes with calibrated
  drift/volatility parameters.
- `solvers/forward.py` computes optimal stopping boundaries for candidate reward functions using dynamic
  programming and collocation methods.
- `solvers/inverse.py` wraps PyTorch autograd around the forward solver so gradient-based optimisers can tweak
  reward parameters.
- `notebooks/experiments.ipynb` walks through synthetic and semi-real datasets with visual diagnostics.

### Code Walkthrough

```python
from solvers.inverse import InverseStoppingSolver
from models.diffusions import GeometricBrownianMotion

process = GeometricBrownianMotion(mu=0.07, sigma=0.2)
solver = InverseStoppingSolver(
    process=process,
    reward_basis="quadratic",
    smoothness_penalty=1e-3,
)

estimated_reward = solver.fit(observed_stopping_times)
```

The solver iteratively adjusts reward coefficients until simulated stopping distributions align with
observations, exposing the hidden incentives driving the behaviour.

[Read the research memo]({{ '/posts/2024/06/inverse-optimal-stopping/' | relative_url }}){: .btn .btn--primary}
[Audit the inverse-optimal-stopping repo](https://github.com/annakuchko/inverse-optimal-stopping){: .btn .btn--inverse}
