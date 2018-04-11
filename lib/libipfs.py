import subprocess, os
import ipfsapi as node

# Exceptions
from lib.__exceptions import NullPath as _NULLPATH

# ************* IPFS Manager *************
class nodeManager():
    def __init__(self):
        self.version = self.versionChecker()
        self.initialized = self.checkInit()

        #self.upstreamVer = self.upstreamVersion()

        # Processes to run if self.version == "!!Missing"
        #if self.version == "!!Missing":
            #self.ipfsInstaller()


    def versionChecker(self):
        process = subprocess.run(['ipfs version'], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        execCode = process.returncode

        if execCode is not 0:
            version = "!!Missing"
        else:
            version = process.stdout.decode('utf-8')

        return version

    #def upstreamVersion(self):
        # Method to check IPFS upstream version
        #process =

    #def ipfsInstaller(self, base):
        # Install script goes here
        # Depends on ipfsapi object
        # Arguments depend on baseManager.base

    #def ipfsUpdate(self):
        # Update script goes here
        # Depends on ipfsapi object
        # Arguments depend on baseManager.base

    def checkInit(self):
        state = False

        if self.version != '!!Missing':
            process = subprocess.run(['ipfs init'], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            execCode = str(process.returncode)

            if execCode is not 0:
                state = True
            else:
                state = False
        else:
            state = state

        return state

    def nodeInitializor(self):
        if self.version != "!!Missing":
            process = subprocess.run(['ipfs init'], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            execCode = process.returncode

            if execCode is not 0:
                #print(process.stderr.decode('utf-8'))
                exit()

    def getNodeID(self):
        # Depends on IPFS Daemon instance
        identity = ''
        if self.initialized is not 'false':
            client = node.Client(host='localhost', port=5001, base='api/v0', chunk_size=4096)
            identity = client.id()

        return identity

    # Recommend script to start daemon on system boot
    # Change method to eval the intended script instead of running subprocess here.
    # Script will depend on system.base
    def daemonLoader(self):
        # Execute a shell script instead.

        if self.version != "!!Missing":
            process = subprocess.run(['ipfs daemon'], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            execCode = str(process.returncode)

            if execCode is not 0:
                print(process.stderr.decode('utf-8'))
        else:
            execCode = 1

class worker():
    __daemon = node.Client(host='localhost', port=5001, base='api/v0', chunk_size=4096)

    def __init__(self, path):
        self.object = path

    def addFile(self):
        try:

            if os.path.exists(self.object):
                meta = self.__daemon.add(self.object, chunker='size-2048')

                return meta
            else:
                raise _NULLPATH(self.object)

        except _NULLPATH as exception:
            print(exception.error)
            exit(exception.code)



