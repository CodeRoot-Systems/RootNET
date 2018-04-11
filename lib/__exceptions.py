# Global Exceptions
class NullPath(Exception):
    def __init__(self, path):
        self.error = '<--!PATH_MISSING: ' + path + ' !-->'
        self.code = 2