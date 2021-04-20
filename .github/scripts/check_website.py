import os
from git import Repo

repo = Repo('../../../main-cv')
index = repo.index
print("=============== list modified files ===============")

diff = repo.git.diff('HEAD~1..HEAD', name_only=True)
print(diff)
print('\n')

if "website/" in diff:
    print('\n')
    exit #exit return 0 == Success
else:
    print('No files required for upload \n')
    exit(1) #exit return 1 == Failed
