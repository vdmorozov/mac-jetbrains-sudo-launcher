# mac-jetbrains-sudo-launcher
Allows to automatically run as root the latest version of any of JetBrains instruments, installed via Toolbox on Mac OS.

# use-case
Once I needed to start built-in PHP web server on port 80 on Mac with PhpStorm Run tool. I tryed it but got a `Permission denied` error. Then I found where PhpStorm executable is, launched it with `sudo` and web server started without any problem. It could be good enough workaround (btw, maybe there is more easy way, idk), but it makes no sense to run the exact version of application when using JetBrains Toolbox launcher and autoupdate. 

So I wrote this sudo launcher.

# usage
By default this script is set up to launch PhpStorm from its default path (`~/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/{$versionNumber}/PhpStorm.app/Contents/MacOS/phpstorm`). You can modify this behavior by changing variables `theAppToLaunchPath` and `theRelativeExecPath`.

`theAppToLaunchPath` must be set to a path to the folder, that contains installed version of the application in appropriate named subfolders (e.g. `173.4127.29`, `172.4144.1459`). By default it's `~/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/`.

`theRelativeExecPath` must be set to a path from a concrete version folder to the executive file of application. By default it's `PhpStorm.app/Contents/MacOS/phpstorm`

The launcher script will:
1) scan `theAppToLaunchPath` for subfolders;
2) interpret their names as versions;
3) sort this versions to find the latest one ;
4) run as root the latest version of the app using `theRelativeExecPath`.

Then you can export this script as an app and run it any way you want. 
