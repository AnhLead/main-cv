import os
from git import Repo

repo = Repo(self.rorepo.working_tree_dir)
staged_files = repo.index.diff("HEAD")
print("=============== list modified files ===============")
for x in staged_files:
    print(x.a_path)
    if website not in x.a_pth:
        run_job = False
        print("False")
        break
    else:
        run_job = True
        print("True")

