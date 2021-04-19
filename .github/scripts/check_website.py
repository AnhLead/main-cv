import os
from git import Repo

repo = Repo('../../../main-cv')
staged_files = repo.index.diff("HEAD")
print("=============== list modified files ===============")
for x in staged_files:
    print(x)


for item in repo.index.diff(None):
    print (item)

contents = get_contents("")
for content_file in contents:
    print(content_file)