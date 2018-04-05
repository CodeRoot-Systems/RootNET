# ++++++++++++++++++++++++++++++++++ RootNET ++++++++++++++++++++++++++++++++++
'''
- Based on Project Wormhole, by codeRoot Systems.

'''

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

from services.daemon import ipfsManager

if __name__ == '__main__':
    daemon = ipfsManager()
    daemon.daemonInitializor()