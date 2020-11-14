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



#### 删除远程tag

```
git push origin :refs/tags/v0.1
git push --delete origin v1.0
```

