import os
from git import Repo

repo = Repo('../../../main-cv')
index = repo.index
print("=============== list modified files ===============")


diff = repo.git.diff('HEAD~1..HEAD', name_only=True)
    print(x)