import os
from git import Repo

repo = Repo('../../../main-cv')
index = repo.index
print("=============== list modified files ===============")

count_modified_files = len(repo.index.diff(None))
count_staged_files = len(repo.index.diff("HEAD"))
print count_modified_files, count_staged_files

