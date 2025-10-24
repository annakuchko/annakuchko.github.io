"""Utility functions for testing BLIP-2 question answering on driving scenes.

The module mirrors the workflow described in the blog post. It lazily loads the
vision-language model, caches prompts, and exposes a helper that bundles
questions relevant to road-safety audits.
"""

from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, List

import torch
from PIL import Image
from transformers import Blip2ForConditionalGeneration, Blip2Processor


@dataclass
class DrivingScene:
    """Container for a driving frame and optional metadata."""

    image_path: Path
    description: str | None = None

    def load(self) -> Image.Image:
        """Return the RGB image for downstream inference."""

        return Image.open(self.image_path).convert("RGB")


class VQAPipeline:
    """Thin wrapper around BLIP-2 for self-driving safety prompts."""

    def __init__(self, model_name: str = "Salesforce/blip2-opt-2.7b") -> None:
        device = "cuda" if torch.cuda.is_available() else "cpu"
        torch_dtype = torch.float16 if device == "cuda" else torch.float32

        self.processor = Blip2Processor.from_pretrained(model_name)
        self.model = Blip2ForConditionalGeneration.from_pretrained(
            model_name,
            torch_dtype=torch_dtype,
        ).to(device)
        self.device = device
        self.torch_dtype = torch_dtype

    def ask(self, scene: DrivingScene, questions: Iterable[str], *, max_new_tokens: int = 50) -> List[str]:
        """Return answers for the provided questions."""

        image = scene.load()
        answers: List[str] = []

        for question in questions:
            inputs = self.processor(
                images=image,
                text=question,
                return_tensors="pt",
            ).to(self.device, self.torch_dtype)
            output = self.model.generate(**inputs, max_new_tokens=max_new_tokens)
            answers.append(self.processor.decode(output[0], skip_special_tokens=True))

        return answers


DEFAULT_QUESTIONS: List[str] = [
    "Is there a pedestrian in the crosswalk?",
    "What colour is the traffic light?",
    "Are any vehicles merging into our lane?",
    "Is it safe to proceed through the intersection?",
]


def run_cli(image_path: str) -> None:
    """Simple CLI for manual experiments."""

    pipeline = VQAPipeline()
    scene = DrivingScene(Path(image_path))
    answers = pipeline.ask(scene, DEFAULT_QUESTIONS)

    for question, answer in zip(DEFAULT_QUESTIONS, answers):
        print(f"Q: {question}\nA: {answer}\n")


if __name__ == "__main__":  # pragma: no cover - convenience entry point
    import argparse

    parser = argparse.ArgumentParser(description="Run BLIP-2 VQA on a driving image")
    parser.add_argument("image", help="Path to the road-scene image")
    parser.add_argument("--model", default="Salesforce/blip2-opt-2.7b", help="Model identifier")
    args = parser.parse_args()

    pipeline = VQAPipeline(model_name=args.model)
    scene = DrivingScene(Path(args.image))
    answers = pipeline.ask(scene, DEFAULT_QUESTIONS)

    for question, answer in zip(DEFAULT_QUESTIONS, answers):
        print(f"Q: {question}\nA: {answer}\n")
