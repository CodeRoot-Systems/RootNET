import os, json
#from lib.libcrypt import
from lib.libipfs import worker as Node
from lib.libbase import baseManager as Base

class filehub():
    __base = Base()
    #__node = Node()

    def __init__(self, files):
        self.files = files
        self.root = os.path.join(self.__base.root, 'filehub')

        if not os.path.exists(self.root):
            os.mkdir(self.root, mode=0o755)

    def archive(self):
        # META info from archive loaded and used to compare archived items
        # and those on wait to avoid file redundancy
        root = os.path.join(self.root, 'archive')
        archive = []
        zipList = []
        cryptList = []
        uploadList = []

        if not os.path.exists(root):
            os.mknod(root, mode=0o755)

        stream = open(root, 'r')
        content = json.load(stream)
        stream.close()
        del(stream)

        for item in content['archive']:
            archive.append(item['file'])
        del(content)

        # Comparison at this point
        for file in self.files:
            title = os.path.basename(os.path.abspath(file))
            for item in archive:
                if item == title:
                    pass
                else:
                    zipList.append(file)

        # Zipping at this point - Depends on libzip
        for item in zipList:
            if os.path.exists(item):
                # Zipping at this point ()
                # Then Encryption
                # Then Upload
                pass

        # Encryption at this point - Depends on libcrypt
        for item in cryptList:
            pass


        # Upload at this pint - Depends on libipfs
        for item in uploadList:
            pass



        # Archives updated with new META
        return root

if __name__ == '__main__':
    x = filehub('fdsfd')
    print(x.archive())




