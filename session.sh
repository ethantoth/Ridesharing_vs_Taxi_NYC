
## Way to solve conflicts on git bash. 

ethan@DESKTOP-3MGT4Q0 MINGW64 ~
  $ cd Desktop/Info_201/Ridesharing_vs_Taxi_NYC

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

modified:   server.R
modified:   ui.R

no changes added to commit (use "git add" and/or "git commit -a")

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

modified:   server.R
modified:   ui.R

no changes added to commit (use "git add" and/or "git commit -a")

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git pull
remote: Enumerating objects: 7, done.
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 4 (delta 2), reused 4 (delta 2), pack-reused 0
Unpacking objects: 100% (4/4), done.
From https://github.com/ethantoth/Ridesharing_vs_Taxi_NYC
d578e13..ec5c11f  master     -> origin/master
error: Your local changes to the following files would be overwritten by merge:
  ui.R
Please commit your changes or stash them before you merge.
Aborting
Updating d578e13..ec5c11f

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git status
On branch master
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
(use "git pull" to update your local branch)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

modified:   server.R
modified:   ui.R

no changes added to commit (use "git add" and/or "git commit -a")

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git status
On branch master
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
(use "git pull" to update your local branch)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
(use "git checkout -- <file>..." to discard changes in working directory)

modified:   server.R
modified:   ui.R

no changes added to commit (use "git add" and/or "git commit -a")

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git pull
error: Your local changes to the following files would be overwritten by merge:
  ui.R
Please commit your changes or stash them before you merge.
Aborting
Updating d578e13..ec5c11f

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git add server.R

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git add ui.R

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git status
On branch master
Your branch is behind 'origin/master' by 1 commit, and can be fast-forwarded.
(use "git pull" to update your local branch)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

modified:   server.R
modified:   ui.R


ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git commit -m "to merge with sofia"
[master 78c1e2e] to merge with sofia
2 files changed, 34 insertions(+), 20 deletions(-)

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git pull
Auto-merging ui.R
CONFLICT (content): Merge conflict in ui.R
Automatic merge failed; fix conflicts and then commit the result.

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master|MERGING)
$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 1 different commits each, respectively.
(use "git pull" to merge the remote branch into yours)

You have unmerged paths.
(fix conflicts and run "git commit")
(use "git merge --abort" to abort the merge)

Changes to be committed:
  
  modified:   TaxiFHVui.R

Unmerged paths:
  (use "git add <file>..." to mark resolution)

both modified:   ui.R


ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master|MERGING)
$ git add ui.R

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master|MERGING)
$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 1 different commits each, respectively.
(use "git pull" to merge the remote branch into yours)

All conflicts fixed but you are still merging.
(use "git commit" to conclude merge)

Changes to be committed:
  
  modified:   TaxiFHVui.R
modified:   ui.R


ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master|MERGING)
$ git commit -m "solved conflict errors"
[master cc445b0] solved conflict errors

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
(use "git push" to publish your local commits)

nothing to commit, working tree clean

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$ git push
Enumerating objects: 13, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 8 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (7/7), 1.53 KiB | 224.00 KiB/s, done.
Total 7 (delta 4), reused 0 (delta 0)
remote: Resolving deltas: 100% (4/4), completed with 2 local objects.
To https://github.com/ethantoth/Ridesharing_vs_Taxi_NYC.git
ec5c11f..cc445b0  master -> master

ethan@DESKTOP-3MGT4Q0 MINGW64 ~/Desktop/Info_201/Ridesharing_vs_Taxi_NYC (master)
$
  