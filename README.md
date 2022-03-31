## 破解软件下载：
https://download.csdn.net/download/u013731154/18612953

## 环境：
红蜘蛛 v6.2.1160 安装在默认位置

![](https://img-blog.csdnimg.cn/20210512165834448.png)

## 实现效果：

![](https://img-blog.csdnimg.cn/20210512170559726.gif)

不妨碍软件的其他功能
## 简单使用方法：
双击启用，Windows xp以上需要管理员权限

**破解补丁替换成功：**

![](https://img-blog.csdnimg.cn/20210512170436912.png)
![](https://img-blog.csdnimg.cn/2021051217482851.png)

**首次运行后可见如下文件：**

![](https://img-blog.csdnimg.cn/20210512170723631.png)![](https://img-blog.csdnimg.cn/20210512170737441.png)

Restore.exe用于还原，Crack.exe用于破解，resources中包含右边四个文件

Close Red Spider.exe用于关闭红蜘蛛相关所有进程

REDAgent.exe与redhooks.dll为修改好的破解补丁，用于替换

Uninstall.exe用于卸载红蜘蛛

## 注意事项：
1.还原
双击Restore.exe进行还原，下面是还原成功的截图

![](https://img-blog.csdnimg.cn/20210512171642859.png)

2.破解前已经被控制
使用Ctrl+Alt+Delete，点击切换用户，再进入系统即可短暂解除控制

利用这段时间运行Crack.exe即可

3.调整窗口后窗口黑掉
将鼠标移动到图示位置（上中位置的小黑条）一下即可

![](https://img-blog.csdnimg.cn/20210512171833940.png)

4.自动替换补丁失败
应该是本机红蜘蛛未安装在默认目录导致，可以参考下面的基本原理

解决方法需要进行手动替换

将上述resources中的REDAgent.exe替换到实际安装目录，最好做好备份，用于手动还原

redhooks.dll文件目录应该没啥问题

5.基本原理
软件实质为写好的脚本文件，将破解好的文件对原文件进行替换，由于破解过程并没有记录，这里只简单说一下

软件使用的吾爱破解工具包中的OllyDbg吾爱专版，对红蜘蛛软件进行断点调试，分别找出了redhooks.dll中鼠标键盘钩子的创建，REDAgent.exe中的创建窗口以及动态修改窗口属性的部分

对这些代码进行修改，跳过了钩子创建，修改创建窗口的参数，跳过了动态修改窗口属性的代码

crack脚本的代码：
```bat
@echo off
cd /d "%~dp0\resources"
::Default
set exePath=C:\3000soft\Red Spider\
set dllPath=C:\Windows\SysWOW64\
::For other cases
if not exist "%dllPath%redhooks.dll" (
set dllPath=C:\Windows\System32\
)
if not exist "%exePath%REDAgent.exe" (
set exePath=C:\Program Files\3000soft\Red Spider\
)
::Start
echo ------------------------------
echo 1.Kill processes of RedSpider
echo ------------------------------
echo.
taskkill /im rscheck.exe /f
taskkill /im redagent.exe /f
taskkill /im checkrs.exe /f
taskkill /im epointer.exe /f
echo.
if not exist "%dllPath%redhooks.dll.bak" (
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<-^>Backup %dllPath%redhooks.dll as redhooks.dll.bak
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo.
rename %dllPath%redhooks.dll redhooks.dll.bak 
)
if not exist "%exePath%REDAgent.exe.bak" (
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo ^<-^>Backup %exePath%REDAgent.exe  as REDAgent.exe.bak
echo - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
echo.
rename "%exePath%REDAgent.exe" REDAgent.exe.bak
)
echo -------------------------------------------
echo 2.Replace %dllPath%redhooks.dll
echo -------------------------------------------
echo.
copy redhooks.dll %dllPath%
IF "%ERRORLEVEL%"=="1" (
echo.
echo - - - - - - - - - - - - - - - - - -
echo ^<!^>Failed to replace redhooks.dll
echo - - - - - - - - - - - - - - - - - -
goto :FAIL
)
echo.
echo -----------------------------------------------
echo 3.Replace %exePath%REDAgent.exe
echo -----------------------------------------------
echo.
copy REDAgent.exe "%exePath%"
IF "%ERRORLEVEL%"=="1" (
echo.
echo - - - - - - - - - - - - - - - - - - -
echo ^<!^>Failed to replace REDAgent.exe
echo - - - - - - - - - - - - - - - - - - -
goto :FAIL
)
echo.
echo -------------
echo 4.Completed!
echo -------------
echo.
echo ---------------------------------------------
echo 5.Reopen %exePath%REDAgent.exe
echo ---------------------------------------------
echo.
start /d "%exePath%" REDAgent.exe
pause
exit
:FAIL
echo.
echo - - - - - - - - - - -
echo ^<!^>Failed to crack
echo - - - - - - - - - - -
echo.
start /d "%exePath%" REDAgent.exe
pause
```
默认在`C:\3000soft\Red Spider\`或`C:\Program Files\3000soft\Red Spider\`两个目录进行REDAgent.exe的替换，这两个目录是红蜘蛛的默认安装目录
默认在`C:\Windows\SysWOW64\`或`C:\Windows\System32\两个目录进行redhooks.dll`的替换，这两个目录分别为64位与32位系统dll存放目录

目录正确的话就能自动完成文件替换，否则需手动替换
