import os
from git import Repo

repo = git.Repo()
staged_files = repo.index.diff("HEAD")
print("=============== list modified files ===============")
for x in staged_files:
    print(x.a_path)
    if website not in x.a_pth:
        run_job = False
        break
    else:
        run_job = True

