# JJFly
git reset learn
git reset --hard Head
git reset --hard head1
git reset --hard 0b5cb67 head 是一个指针，

create git repository
git init; git clone url

git add file.txt(git add .)
git commit -m 'des'
git status // git diff
git push origin master/dev

版本回退
git reset --hard Head^回到上一版本
git reset --hard 0b5cb67 回到制定版本
每一次的命令
git reflog
小结：HEAD指向的版本是当前版本，Git允许我们在版本历史之间穿梭 git reset --hard commit_id;
回退版本之前 用git log 查看提交历史，确定可以会退到哪个版本
git reflog查看命令历史，确定会到拿一个版本









