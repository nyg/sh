##  Raspberry Pi 5 – Desktop

### Pre-Install

Set-up options with the Raspberry Pi Imager.

### Post-Install

1. Keyboard layout
   1. Model: Generic 105-key PC
   2. Layout: German (Switzerland)
   3. Variant: French (Switzerland)
2. Apt update / upgrade
3. Install scripts
   1. curl ok
   2. configure zzsh
      1. echo $XGF_SESSION_TYPE to know if i'm using wayland or not
   3. install p10k (did it work?)
      1. note: install  zsh is outdated? install omz
   4. configure git
   5. on mbp, add raspberrypi5 to etc hosts
      1. ssh user@raspberrypi5, worked
      2. scp git@github.com* user@raspberrypi5:.ssh
   6. change upstream and origin as explain in macos doc
   7. configure ssh client for ssh config
   8. push master in user-sh
   9. install misc linux apt after some modifications
   10. configure vim
   11. configure bash, issue with zsh scripts but should be fixed
   12. install of zsh
   13. change launcher icons (folder, terminator, firefox)
   14. install vscodium
       1. how to reinstall settings quickly
   15. brave browser, ok fixed it arm64 instead of aarch64
   16. install sublime text, ok
   17. installed postman, fixed issues
   18. installed typora, ok
   19. install jenv, fixed issues
   20. visualvm ok
   21. jetbrains toolbox,  no arm64 bin, but coming
   22. mvnd, no aarch64 bin...  #888 issue
   23. install pyenv, ok

### TODO

* mvn script
* keyboard arrow issues with different terminal
* location of .bashrc inputrc profile
* is profile sourced with zsh?
