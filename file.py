print("hello from base machine, to container")

import os


def make_dir_on_container():
    os.system("mkdir /tmp/hello_from_base_machine.txt")


make_dir_on_container()
