# Encryption Ciphers
import bcrypt
# Exceptions

# Ciphers
class pHashing():
    def __init__(self, secret):
        self.secret = secret.encode('utf-8')

    def hash(self):
        __hash = bcrypt.hashpw(self.secret, salt=bcrypt.gensalt())

        return __hash

    def compare(self, xsalt):
        result = False
        result = xsalt  == bcrypt.hashpw(self.secret, xsalt)

        return result
