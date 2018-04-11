import os, json
from lib.libbase import baseManager as Base
from lib.libzip import zipper as Zippy
from lib.libcrypt import aesCipher as Crypto
from lib.libipfs import worker as Node
from bin.auth.profiler import profiler

# Exceptions
from lib.__exceptions import NullPath as _NULLPATH

class filehub():
    __base = Base()
    #__node = Node()

    def __init__(self, files):
        self.files = files
        self.root = os.path.join(self.__base.root, 'filehub')

        if not os.path.exists(self.root):
            os.mkdir(self.root, mode=0o755)

    def archive(self):
        try:

            # META info from archive loaded and used to compare archived items
            # and those on wait to avoid file redundancy
            root = os.path.join(self.root, 'archive')
            archive = []
            zipList = []
            cryptList = []
            uploadList = []

            if os.path.exists(root):
                stream = open(root, 'r')
                content = json.load(stream)
                stream.close()
                del (stream)

                for item in content['archive']:
                    archive.append(item)
                del (content)

                # Comparison at this point
                for file in self.files:
                    title = os.path.basename(os.path.abspath(file))
                    for item in archive:
                        iTitle = item['Name']

                        if iTitle == title:
                            archived = True
                        else:
                            archived = False

                    if archived == False:
                        zipList.append(file)
            else:
                os.mknod(root, mode=0o755)
                for file in self.files:
                    zipList.append(file)

            # Zipping at this point - Depends on libzip
            for item in zipList:
                if os.path.exists(item):
                    zipper = Zippy(item)
                    zipped = zipper.zip()
                    cryptList.append(zipped)
                else:
                    raise _NULLPATH(item)
            del(zipList)

            
            # Encryption at this point - Depends on libcrypt
            # Initial Step - get key from profiler
            session = profiler()
            __key = session.keyFetch()
            __key = __key.decode('utf-8')

            # Final Step - encrypt file and update uploadList
            for zip in cryptList:
                if os.path.exists(item):
                    cipher = Crypto(__key, zip)
                    encrypted = cipher.encrypt()
                    uploadList.append(encrypted)
                    os.remove(zip)
                else:
                    raise _NULLPATH(item)
            del(cryptList)

            # Upload at this point - Depends on libipfs
            for crypt in uploadList:
                if os.path.exists(crypt):
                    node = Node(crypt)
                    meta = node.addFile()
                    archive.append(meta)
                    os.remove(crypt)
                else:
                    raise _NULLPATH(item)
            del(uploadList)


            # Archives updated with new META
            stream = open(root, 'w')
            json.dump(dict(archive=archive), stream)
            stream.close()
            del(stream)


            return archive


        except _NULLPATH as exception:
            print(exception.error)
            exit(exception.code)




if __name__ == '__main__':
    x = filehub(['/home/leamer/Documents/Third party files v2','/home/leamer/Documents/CoverPage (AttachmentReport).docx'])
    for item in x.archive():
        print(item)




