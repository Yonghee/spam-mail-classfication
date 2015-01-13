__author__ = 'yhlee'

import re

regex = re.compile('^(.+):\s+continuous\.')

f = open("data/spambase.names")
out = open("data/headers", "w")

for line in f.readlines():
    # print(line)
    m = regex.match(line)
    if m:
        # print line
        header =  m.group(1) + "\n"
        out.writelines(header)
