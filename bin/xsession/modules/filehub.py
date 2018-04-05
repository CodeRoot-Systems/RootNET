'''
    RootNETs File hub module
'''
import os
import ipfsapi.client as node
from services.base  import baseManager

class archiver():

    def __init__(self, files, wrap):
        self.files = files # List object with string based (file path) items.
        self.wrap = wrap

    def addFiles(self):
        daemon = node.Client(host='localhost', port=4001, base='api/v0', chunk_size=4096)

        for file in self.files:
            if os.path.exists(file):
                daemon.add(file, recursive=True, wrap_with_directory=True)

class publisher():
    def __init__(self):
        pass