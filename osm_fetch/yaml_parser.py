from enum import Enum
import argparse

from pydantic import BaseModel
from pydantic_yaml import parse_yaml_file_as
from rich.pretty import pprint

class Operation(str, Enum):
    difference = "difference"
    union = "union"

class ConfigLayer(BaseModel):
    name : str
    operation : Operation

class UnsealingConfig(BaseModel):
    layers : list[ConfigLayer]
    city: str

def parse_config(filename):
    return parse_yaml_file_as(UnsealingConfig, filename)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("file")
    args = parser.parse_args()
    filename = args.file
    config = parse_yaml_file_as(UnsealingConfig, args.file)
    pprint(config)