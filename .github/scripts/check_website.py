import os
from git import Repo

repo = Repo('../../../main-cv')
index = repo.index
print("=============== list modified files ===============")
for x in index.diff('HEAD'):
    print(x)



