# JJFly

into ssh floder
cmd + shift + G

git reset learn
git reset --hard Head
git reset --hard head1
git reset --hard 0b5cb67 head 是一个指针，

create git repository
git init;创建一个本地的仓库
git clone url

git add file.txt(git add .)  把文件修改添加到暂存区
git commit -m 'des' 把暂存区的所有内容提交当前分支
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

git status -- checkout// edit the file and then not add .
edit ; git checkout -- file

rm file.txt -----just remove from floder if you want to recovery it-----git checkout -- file.txt
git rm file.txt---will go into git---if you want to recovery then git reset --hard HEAD^(it is a pointer)

在远程创建一个git仓库之后关联本地的仓库
cd localRepository
git remote add origin git@github.com:dashuai007/JJFly.git
git pull
git push --force origin master本地库的所有内容推送到远程库

git branch
git branch newBranch
git checkout master
git merge dev//newBranch
git branch -d dev/newBranch

git master


