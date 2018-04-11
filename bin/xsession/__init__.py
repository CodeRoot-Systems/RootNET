'''
    RootNETs File hub module
'''
import os, json
import ipfsapi.client as node
from lib.libbase import baseManager

from lib.libipfs import worker
#from lib.libcrypt import

# Exceptions
class NullPath(Exception):
    def __init__(self, path):
        self.error = '<--!PATH_MISSING: ' + path + ' !-->'
        self.code = 2

# Modules
class archiver():
    __daemon = node.Client(host='localhost', port=5001, base='api/v0', chunk_size=4096)
    __base = baseManager()
    #__cipher =

    def __init__(self, files):
        self.pathArr = files            # List object with string based (file path) items.
        self.root = self.__base.root + 'filehub/'

        if not os.path.exists(self.root):
            os.mkdir(self.root, mode=0o755)
            os.mknod(self.root+'archive', mode=0o755)


    def rdCurrent(self):
        root = open(file=self.root+'archive', mode='r', buffering=-1)
        content = json.load(root)
        xr = []

        for item in content['archive']:
            xr.append(item)

    def validate(self, file):
        archive = self.rdCurrent()



    def addFiles(self):
        try:
            content = []

            for path in self.pathArr:
                file = os.path.basename(os.path.abspath(path))

                if os.path.exists(path):

                    if os.path.isdir(path):
                        hash = ''
                        size = ''
                        items = []

                        #Symmetric Encryption here
                        # ----
                        chunk = self.__daemon.add(path, recursive=True, wrap_with_directory=True,
                                                  chunker='size-2048')

                        for object in chunk:
                            if object['Name'] == file:
                                hash = object['Hash']
                                size = object['Size']
                            elif object['Name'] != '':
                                items.append(dict(item=object['Name'], hash=object['Hash'],
                                                  size=object['Size']))

                        content.append(dict(dir=file, hash=hash, size=size, items=items))

                    else:
                        #Symmetric Encryption here
                        chunk = self.__daemon.add(path, chunker='size-2048')
                        hash = chunk['Hash']
                        size = chunk['Size']
                        content.append(dict(file=file, hash=hash, size=size))



                else:
                    raise NullPath(path)

            self.wrt(content)
            return content

        except NullPath as exception:
            print(exception.error)
            exit(exception.code)

    def wrt(self, content):
        #archive = self.rdCurrent()
        root = open(self.root+'archive', mode='w')
        json.dump(dict(archive=content), fp=root)

class publisher():
    def __init__(self):
        pass


if __name__ == '__main__':
    arch = archiver(['/home/leamer/Downloads/Compressed/sofia/SIL Open Font License.txt', '/home/leamer/Documents/Agile Methods of Development/Agile-Manifesto.pdf'])
    x = arch.addFiles()
    #x = arch.rdCurrent()
    print(x)

    #daemon = node.Client(host='localhost', port=5001, base='api/v0', chunk_size=4096)
    #print(daemon.add('/home/leamer/Downloads/Compressed/walkway/Freeware License.txt', chunker='size-2048'))
