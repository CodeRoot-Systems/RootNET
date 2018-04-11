# Encryption Ciphers
import bcrypt, pyAesCrypt, os

# Exceptions
class NullPath(Exception):
    def __init__(self, path):
        self.error = '<--!PATH_MISSING: ' + path + ' !-->'
        self.code = 2

# Ciphers
class hashCipher():
    def __init__(self, secret):
        self.secret = secret.encode('utf-8')

    def hash(self):
        __hash = bcrypt.hashpw(self.secret, salt=bcrypt.gensalt())

        return __hash

    def compare(self, xsalt):
        result = False
        result = xsalt  == bcrypt.hashpw(self.secret, xsalt)

        return result


class aesCipher():
    # Buffer size = 64K
    __bufferSize = 64*1024
    def __init__(self, key, file):
        self.key = key
        self.file = file

    def encrypt(self):
        try:
            if os.path.exists(self.file):
                encFile = self.file + '.encrypted'
                pyAesCrypt.encryptFile(self.file, encFile, self.key, self.__bufferSize)

                return encFile
            else:
                raise NullPath(self.file)
        except NullPath as exception:
            print(exception.error)
            exit(exception.code)


    def decrypt(self):
        try:
            if os.path.exists(self.file):
                origFile = self.file[:-10]
                pyAesCrypt.decryptFile(self.file, origFile, self.key, self.__bufferSize)

                return origFile

            else:
                raise NullPath(self.file)

        except NullPath as exception:
            print(exception.error)
            exit(exception.code)

