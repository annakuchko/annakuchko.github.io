---
layout: single
title: "A Thompson Sampling Logbook for Bayesian Decision Making"
date: 2024-06-05
permalink: /posts/2024/06/thompson-log/
tags:
  - thompson sampling
  - bayesian methods
  - experimentation
  - python
excerpt: "Documenting my iterative experiments with contextual bandits and Bayesian posterior tracking from the thompson_log repository."
---

## From Theory Notes to a Working Playground

I created the [thompson_log](https://github.com/annakuchko/thompson_log) repository as a living lab notebook while studying **Thompson Sampling**. Instead of keeping equations in isolation, I translated each concept into executable Python experiments so that I could *see* posterior distributions evolve.

The project mixes Markdown reflections, Jupyter notebooks, and modular utilities that make it easy to try variations of multi-armed bandit problems—Bernoulli, Gaussian, and contextual setups.

## Architecture and Utilities

- **`bandits/`** defines reward simulators for different priors and likelihoods.
- **`agents/`** houses Thompson Sampling strategies for discrete and contextual arms.
- **`experiments/`** contains reproducible notebooks that log posterior snapshots and regret curves.
- Shared helpers handle seeding, plotting, and experiment metadata so every run can be compared apples-to-apples.

The goal is to keep the code expressive enough for research while staying approachable for teaching or presentation purposes.

## Lessons from the Logbook

1. **Posterior Matching Matters** – Aligning priors with true reward distributions accelerates convergence dramatically. I demonstrate how mis-specified priors inflate regret, which was eye-opening when visualized.
2. **Contextual Features Amplify Value** – Using linear models over contextual features helps the agent prioritize promising arms early, especially in non-stationary settings.
3. **Logging is a Superpower** – Saving posterior parameters after every round made it easy to debug and explain surprising exploration decisions.

These experiments translate directly into product analytics scenarios: think A/B testing where decisions must be made sequentially, or recommendation systems that balance novelty and exploitation.

## Where to Go Next

I plan to extend the logbook with hierarchical priors and Thompson Sampling for combinatorial bandits. If you want to follow along or run the experiments yourself, clone the repository and execute the notebooks in the `experiments/` folder. The README includes quick-start instructions and dependency pins.
