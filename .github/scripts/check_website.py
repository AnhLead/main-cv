import os
from git import Repo

repo = Repo('../../../main-cv')
index = repo.index
print("=============== list modified files ===============")
for x in index.diff('HEAD'):
    print(x)

for x in index.diff():
    print(x)

for x in index.diff(none):
    print(x)

hcommit = repo.head.commit
for diff_added in hcommit.diff('HEAD~1').iter_change_type('A'):
    print(diff_added)

for c in repo.index.diff(None):
    print(c)

for b in repo.index.diff(None):
    print(b)

for a in repo.untracked_files:
    print(a)

for x in hcommit.diff()                  # diff tree against index
    print(x)
for x in hcommit.diff('HEAD~1')          # diff tree against previous tree
    print(x)
for x in hcommit.diff(None) 
    print(x)