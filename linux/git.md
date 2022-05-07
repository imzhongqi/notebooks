### 指定 work tree

```sh
git --work-tree /path/to/dir status
```

以 `/path/to/dir`  目录为 root 目录



只提交 abc 目录：

```
*
!.gitignore        
!abc/          
!abc/*
```



```sh
# 删除远程 git server tag
git push origin :refs/tags/v0.1
git push --delete origin v1.0

git commit --amend           # 修改描述信息
git push -u origin master    # 将 master 分支推送到 origin，同时制定 origin 为默认主机 

git push origin :develop     # 删除 origin 主机上的 develop 分支，与 git push origin -d develop
git push -f
git push -4/-6 							 # 制定使用 IPv4 或 IPv6

# git rm 删除文件
git rm --cached test.txt  	 # 删除缓存数据 
git rm -rf data              # 删除目录以及文件，移除索引

# git reset 取消操作
git reset --hard HEAD~N      # 撤销最近 N 次的 commit。在这之后的 commit 都丢弃
git reset --soft HEAD~N      # 撤销最近 N 次的 commit。在这之后的 commit 都会暂存状态， 等待提交

git remote set-url --add origin <url2>    # 为 origin 多添加一个 url，这样就可以一次推送两个远程仓库
git remote set-url origin git@github.com:xxx/xxx.git # 重新关联本地仓库到新的远程仓库

git config -e     					 # 使用 git 默认的 editor 查看 config 文件内容

git log                      # 现实提交记录

git status                   # 查看当前 git 状态

# git branch
git branch                  # 显示分支列表
git branch -r               # 显示远程分支列表
git branch -a               # 显示所有分支列表
git branch newxxx           # 创建 newxxx 分支
git branch -d xxx           # 删除 xxx 分支
git branch -d -r xxx        # 删除远程分支，同：git push origin :xxx

# git checkout
git checkout xxx            # 切换到新的分支 xxx
git checkout <tag>          # 切换到指定的 tag 版本
git checkout .              # 放弃修改所有文件，未提交的文件
git checkout -b newbranch   # 从当前的分支创建一个 newbranch，并 checkout 过去
```



**git ssh debugging**

```
GIT_SSH_COMMAND="ssh -vvv" git clone git@github.com:imzhongqi/dotfiles
```



**不使用 .gitignore 忽略文件，仅在本地生效**

```
echo "exclude_file" >> .git/info/exclude
```





**修改最后一次的提交**

```
git commit --amend
```









相关文章：

https://deepzz.com/post/git-commands.html