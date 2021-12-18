# 数据库课设
## 开发分支为dev！


## Git工作流程

1. git pull origin dev (在着手开发之前!)
2. 自己commit自己的，并附带消息
3. git pull origin dev --rebase（如果有冲突的话要手动合并，不可自动合并）
4. git push origin dev



## Git提交规范

fix：修复了哪里的bug

update： 更新了什么功能（接口路径、接口METHOD、接口参数）

注意Git提交的时候使用idea的选择文件，只选择自己更改过的文件，不要提交全部，否则会和他人更改发生冲突


## 运行
前端：进入db_frontend文件夹，npm install --registry https://registry.npm.taobao.org, npm run serve
后端：参考其他人的文件配置自己的文件，然后在application.properties里面选择自己的配置文件，不要提交application.properties文件！

