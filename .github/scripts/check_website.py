import os
from git import Repo

repo = Repo('../../../main-cv')
staged_files = repo.index.diff("HEAD")
print("=============== list modified files ===============")
for x in staged_files:
    print(x.a_path)


for item in repo.index.diff(None):
    print (item.a_path)