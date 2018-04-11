import os, zipfile

# Exceptions
class NullPath(Exception):
    def __init__(self, path):
        self.error = '<--!PATH_MISSING: ' + path + ' !-->'
        self.code = 2

# Compression Algorithms
class zipper():
    def __init__(self, file):
        self.file = file

    def zip(self):
        try:

            if os.path.exists(self.file):

                if os.path.isdir(self.file):
                    zip = zipfile.ZipFile(self.file + '.zip', 'w')

                    for root, dirs, files in os.walk(self.file, topdown=True):

                        for file in files:
                            zip.write(os.path.join(root, file), os.path.relpath(os.path.join(root, file), self.file),
                                      compress_type=zipfile.ZIP_DEFLATED)

                    zip.close()
                    return self.file+'.zip'
                else:
                    baseName = os.path.basename(os.path.abspath(self.file))
                    extPoint = baseName.find('.')
                    output = os.path.join(os.path.dirname(os.path.abspath(self.file)),baseName[:extPoint]+'.zip')
                    zip = zipfile.ZipFile(output,'w')

                    zip.write(self.file, baseName, compress_type=zipfile.ZIP_DEFLATED)
                    zip.close()

                    return output

            else:

                raise NullPath(self.file)

        except NullPath as exception:
            print(exception.error)
            exit(exception.code)

    def unzip(self):
        try:
            if os.path.exists(self.file):
                zip = zipfile.ZipFile(self.file)
                zip.extractall(self.file[:-4])

            return self.file[:-4]

        except NullPath as exception:
            print(exception.error)
            exit(exception.code)



