# Usage : python3 ./update-chart-version.py ./pathTo/Chart.yaml version new-version
import sys
import ruamel.yaml

print ("File name: %s" % (sys.argv[1]))
print ("Image Name: %s" % (sys.argv[2]))
print ("Tag: %s" % (sys.argv[3]))
fname = sys.argv[1]
fieldName = str(sys.argv[2])
value = str(sys.argv[3])

# Check if file exists
from pathlib import Path
if Path(fname).is_file():
    print ("File exist")
else:
    raise ValueError('File not found.')

stream = open(fname, 'r')
yaml = ruamel.yaml.YAML()  # defaults to round-trip if no parameters given
code = yaml.load(stream)
code[fieldName] = value
yaml.dump(code, sys.stdout)
with open(fname, "w") as f:
    yaml.dump(code, f)