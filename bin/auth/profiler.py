'''

'''
import sys, os
from lib.libcrypt import hashCipher
from lib.libbase import baseManager

# Exceptions
class registered(Exception):
    def __init__(self):
        self.status = '<!registered>'

class profiler():
    __base = baseManager()

    def __init__(self):
        self.root = self.__base.root
        self.user = self.__base.user
        self.host = self.__base.host
        self.registered = self.validation()
        self.logDir = os.path.join(self.root, 'logs')

    def session(self):
        profile = os.path.join(self.root, self.user)
        mode = ''

        if os.path.exists(profile):
            root = open(profile, 'r')

            for line in root:
                if line.startswith('status:'):
                    status = str(line[7:]).strip()

                    if status == 'Offline':
                        mode = 'Offline'
                    else:
                        mode = 'Online'
        else:
            mode = 'Inactive'

        return mode

    def keyFetch(self):
        __key = ''

        profile = (os.path.join(self.root,self.user))
        root = open(profile, 'r')

        for line in root:
            if line.startswith('secretKey:'):
                __key = line[10:]
                __key = __key.strip()
                __key = __key.encode('utf-8')

        return __key

    def validation(self):
        profile = self.root + self.user

        if os.path.exists(profile):
            registered = True
        else:
            registered = False

        return registered

    def activation(self, nodeId, publicKey, secretKey):

        path = os.path.join(self.root, self.user)
        root = open(path, 'w')

        try:
            if self.registered == True:
                raise registered()
            else:
                # Encrypting Secret Key
                __cipher = hashCipher(secretKey)
                hash = __cipher.hash()


                #cipher = encryption.hash()

                meta = [
                    'peer:'+ self.user+'\n',
                    'nodeId:'+ nodeId+'\n',
                    'ipnsId:'+self.user+'@'+self.host+'\n',
                    'publicKey:'+ publicKey+'\n',
                    'secretKey:'+ hash.decode('utf-8')+'\n',
                    'status:'+ 'Offline'+'\n'
                ]

                for item in meta:
                    root.write(item)
                    root.flush()

                alert = '<+registered>'
            return alert

        except registered:
            exception = registered()
            status = exception.status

            return status

    def authorization(self, loginKey):
        __loginKey = loginKey # Write function to hash key *** depends on libcrypt
        __cipher = hashCipher(loginKey)
        result = False
        secret = self.keyFetch()
        result = __cipher.compare(secret)

        return result

    def setState(self, status):
        profile = os.path.join(self.root,self.user)
        root = open(profile, 'r')
        details = []

        for line in root:
            if line.startswith('status:'):
                details.append('status:Online')
            else:
                details.append(line)
        root.close()
        root = open(profile, 'w')
        root.writelines(details)
        root.close()