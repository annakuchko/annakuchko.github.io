---
layout: single
title: "Inverse Optimal Stopping: Reconstructing Objectives from Decisions"
date: 2024-06-06
permalink: /posts/2024/06/inverse-optimal-stopping/
tags:
  - stochastic processes
  - optimal stopping
  - inverse problems
  - research notes
excerpt: "Insights from my inverse-optimal-stopping repository on learning hidden reward structures from observed stopping times."
---

## Motivation

In quantitative finance and operations research, we often observe decisions (like when a trader exits a position) but not the latent reward function that drives those decisions. My [inverse-optimal-stopping](https://github.com/annakuchko/inverse-optimal-stopping) project investigates how to **recover the hidden objective** from observed stopping policies.

Rather than solving a classic optimal stopping problem (where the reward is known and we seek the stopping rule), I flip the question: *given a set of realized stopping times, what reward function would make them optimal?*

## Methodological Building Blocks

1. **Diffusion Models for State Dynamics** – I model the underlying process as a 1D diffusion with drift and volatility parameters estimated from data. The repo includes utilities for simulating geometric Brownian motion and Ornstein-Uhlenbeck processes.
2. **Variational Formulation** – The inverse problem is cast as an optimization over reward function parameters, minimizing the discrepancy between observed stopping times and those predicted by the candidate reward.
3. **Regularization and Identifiability** – To avoid degenerate solutions, I introduce smoothness penalties and anchor constraints that keep the recovered reward realistic.

## Code Highlights

- `models/` implements forward and inverse solvers using PyTorch autograd to differentiate through simulated stopping policies.
- `data/` provides synthetic datasets for validation as well as hooks for plugging in real-world time series.
- `notebooks/` demonstrate end-to-end experiments, including sensitivity analyses on observation noise and prior assumptions.

## Results So Far

Experiments show that even with noisy observation of stopping times, the inverse solver can recover reward curves that closely match the ground truth. The approach is especially robust when the reward function is smooth and monotonic. Visualizations in the notebooks compare estimated versus true boundaries and highlight convergence diagnostics.

## Future Directions

Next steps include:

- Extending the framework to multi-dimensional state processes.
- Incorporating Bayesian priors over reward parameters for uncertainty quantification.
- Testing on historical datasets where exercise decisions are documented (e.g., employee stock options).

If inverse problems intrigue you, the repository offers a reproducible pathway from mathematical formulation to differentiable code.
