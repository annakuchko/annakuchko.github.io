---
title: "BLIP-2 VQA for Self-Driving Diagnostics"
excerpt: "Vision-language probes that explain autonomous driving decisions in plain language."
collection: portfolio
---

## Overview

This project prototypes a question-answering co-pilot on top of BLIP-2 so autonomous driving stacks can
explain themselves. By pairing driving frames with targeted prompts, engineers can interrogate what the model
sees, how it describes risks, and whether its reasoning aligns with safety protocols.

### Applications & Use Cases

- **Safety audits** that demand natural-language justifications for braking, lane changes, or cautious driving.
- **Tele-operations** where remote supervisors need quick summaries of on-vehicle camera feeds.
- **Dataset annotation** pipelines that bootstrap captions and scene metadata before manual review.

### Repository Highlights

- `files/vqa_blip2/playground.py` in this site repo exposes a lightweight CLI that mirrors the blog workflow
  and can be dropped into notebooks or monitoring scripts.
- Hugging Face's `Blip2Processor` and `Blip2ForConditionalGeneration` are loaded lazily so GPU and CPU
  experiments share the same interface.
- Prompt bundles capture safety-critical questions (traffic-light states, pedestrian presence, merge conflicts)
  to ensure evaluations cover edge cases.

### Code Walkthrough

```python
from pathlib import Path

from files.vqa_blip2.playground import DEFAULT_QUESTIONS, DrivingScene, VQAPipeline

pipeline = VQAPipeline()
scene = DrivingScene(Path("data/urban_junction.jpg"))
for question, answer in zip(DEFAULT_QUESTIONS, pipeline.ask(scene, DEFAULT_QUESTIONS)):
    print(f"{question} -> {answer}")
```

Integrating the pipeline with telemetry dashboards makes it easier to flag contradictory answers (e.g. "Is the
light red?" answered "No" while the detector sees braking vehicles) before releasing new autonomy builds.

[Study the VQA concept note]({{ '/posts/2025/06/blog-post-1/' | relative_url }}){: .btn .btn--primary}
[Open the BLIP-2 playground script]({{ '/files/vqa_blip2/playground.py' | relative_url }}){: .btn .btn--inverse}
