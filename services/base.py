import os, sys, getpass, socket, platform
from shutil import copyfile

# ************* Base Manager *************
class baseManager():
    def __init__(self):
        self.host = self.getHostname()
        self.user = self.getUser()
        self.sysInfo = self.getSysInfo() 
        self.root = self.getRoot()
        self.avatarSrc = self.avatarSrc()


    def getUser(self):
        username = getpass.getuser()
        return username

    def getHostname(self):
        hostname = socket.gethostname()
        return hostname

    def getSysInfo(self):
        sysInfo = {}
        details = platform.uname()

        if sys.platform == 'linux' or sys.platform == 'linux2':
            sysInfo =dict(base=details.system, os=platform.dist()[0].capitalize(), kernel=details.release,
                           architecture=details.machine, processor=details.processor)
        elif sys.platform == 'darwin':
            # Find a Darwin system to perform unit-testing
            # macInfo = platform.mac_ver(release='', versioninfo=('', '', ''), machine='')
            sysInfo = dict(base=details.system, os=platform.mac_ver()[0].capitalize(), kernel=platform.release(),
                            architecture=details.machine, processor=details.processor)
        elif sys.platform == 'win32':
            sysInfo = dict(base=details.system, os=platform.win32_ver()[0].capitalize(), kernel='Windows NT',
                            architecture=details.machine, processor=details.processor)

        return sysInfo

    #def getArchitecture(self):


    def avatarSrc(self):
        path = ""
        if self.sysInfo['base'] == 'Linux' or self.sysInfo['base'] == 'Linux2':
            gnome2Base = '/home/'+self.user+'/.face'
            gnome3Base = open('/var/lib/AccountsService/users/' + self.user, 'r')

            # Gnome 2 check
            if os.path.exists(gnome2Base):
                path = gnome2Base
            else:
                #Gnome 3 check
                for line in gnome3Base:
                    if line.startswith('Icon='):
                        path = str(line[5:])
                        path = path.strip('\n')

        return path

    def getRoot(self):
        path = ''
        if self.sysInfo['base'] == 'Linux' or self.sysInfo['base'] == 'Linux2':
            path = '/home/'+self.user+'/.RootNET/'

            if not os.path.exists(path):
                os.mkdir(path)
                os.chmod(path, 0o700)

        return path


if __name__ == "__main__":
    xd = baseManager()
    print(xd.getSysInfo())


