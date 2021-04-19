import os
from git import Repo
from github import Github

repo = Repo('../../../main-cv')
staged_files = repo.index.diff("HEAD")
print("=============== list modified files ===============")
for x in staged_files:
    print(x)


for item in repo.index.diff(None):
    print (item)

repo = g.get_repo('../../../main-cv')
contents = repo.get_contents("")
for content_file in contents:
    print(content_file)