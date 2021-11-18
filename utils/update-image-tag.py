import sys
import ruamel.yaml

print ("File name: %s" % (sys.argv[1]))
print ("Image Name: %s" % (sys.argv[2]))
print ("Tag: %s" % (sys.argv[3]))
fname = sys.argv[1]
imageName = str(sys.argv[2])
tag = str(sys.argv[3])

# Check if file exists
from pathlib import Path
if Path(fname).is_file():
    print ("File exist")
else:
    raise ValueError('File not found.')

stream = open(fname, 'r')
yaml = ruamel.yaml.YAML()  # defaults to round-trip if no parameters given
code = yaml.load(stream)
code[imageName]['image']['tag'] = tag
yaml.dump(code, sys.stdout)
with open(fname, "w") as f:
    yaml.dump(code, f)


# paramLength = len(code['spec']['source']['helm']['parameters'])
# paramName = imageName + ".image.tag"

# for x in range(paramLength):
#  for key, value in code['spec']['source']['helm']['parameters'][x].items():
#     if code['spec']['source']['helm']['parameters'][x]['name'] == paramName:
#         code['spec']['source']['helm']['parameters'][x]['value'] = tag
    
