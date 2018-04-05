import subprocess
import ipfsapi

# ************* IPFS Manager *************
class ipfsManager():
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
        state = 'false'

        if self.version != '!!Missing':
            process = subprocess.run(['ipfs init'], shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            execCode = str(process.returncode)

            if execCode is not 0:
                state = 'true'
            else:
                state = 'false'
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
        if self.initialized is not 'false':
            client = ipfsapi.Client(host='localhost', port=5001, base='api/v0', chunk_size=4096)
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

if __name__ == "__main__":
    xd = ipfsManager()
    print(xd.getNodeID())
    #print(dir(xd.getNodeID()))