import os
from git import Repo

repo = Repo('../../../main-cv')
index = repo.index
print("=============== list modified files ===============")

diff = repo.git.diff('HEAD~1..HEAD', name_only=True)
print(diff)

if "website/" in diff:
    run_job = True
else:
    run_job = False

print(run_job)
