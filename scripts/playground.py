#!/usr/bin/env python3

from typing import Optional, Any
from pathlib import Path
import subprocess


class InputException(Exception):
    ...


def yn(user_reply: str, default_val: Optional[bool] = None) -> bool:
    y_answers = ['y', 'yes', 'true']
    n_answers = ['n', 'no', 'false']
    
    if user_reply.lower() in y_answers:
        return True
    
    if user_reply.lower() in n_answers:
        return False
    
    if user_reply == "" and default_val is not None:
        return default_val

    raise InputException()


def noop(user_reply: str) -> str:
    return user_reply


def user_input(question: str, conv_func: callable = noop):
    passed_conv = False
    while not passed_conv:
        try:
            result = conv_func(input(question))
            passed_conv = True
        except InputException:
            pass
    
    return result


def input_with_default(user_input: str, default_value: Any) -> Any:
    return user_input or default_value


PLAYGROUND_PATH = Path.home() / "projects" / "playground"

def validate_playground(name: str) -> bool:
    return (PLAYGROUND_PATH / name).exists()


def create_playground(name: str):
    playdir = PLAYGROUND_PATH / name
    filename = user_input("Enter file name (main.py): ", lambda x: input_with_default(x, "main.py"))
    
    playdir.mkdir(exist_ok=True)
    filepath: Path = playdir / filename
    
    filepath.touch()
    

def open_playground():
    playground_name = user_input("Enter playground: ")
    if not validate_playground(playground_name):
        should_create = user_input(f"Playground `{playground_name}` does not exist. Create one? [Y/n]: ", lambda x: yn(x, True))
        if should_create:
            create_playground(playground_name)
        else:
            return
    
    playdir = PLAYGROUND_PATH / playground_name
    if validate_playground(playground_name):
        subprocess.run(["code", playdir])
    else:
        raise RuntimeError(f"Could not open {playdir}")
    

if __name__ == "__main__":
    open_playground()