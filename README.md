# NovelShell
A Quickshell Configuration, made by yours truly

**NOTE**: Made for Hyprland + Arch **ONLY**
## Demo Video


https://github.com/user-attachments/assets/193b3a6a-0d07-457c-94e2-164bb6a18c4c



## Installing Guide
- Clone the repo
- Run the install script
- Add ```exec-once = qs``` to your Hyprland Config (usuallly located at "/home/<username>/.config/hypr/hyprland.conf")
- The command for the app launcher is ```qs ipc call launcher showL```, so use it in conjunction w/ your app launching shortcut
- The command for the lock_screen is ```qs ipc call launcher lock```, so use that wherever you need the lockscreen to appear

## Configuration
- Define new themes under ./config/quickshell/themes
- Change theme file under the ```themePath``` field of ./config/quickshell/config/config.json
- You'll need to add lockscreen wallpapers manually to whichever theme you want to use, since I don't want to include any wallpapers along with the github repo.

Here's a theme file format
```json
{
    "backgroundColor": # background color,
    "primaryTextColor": # primary text color,
    "secondaryTextColor": # secondary text color,
    "disabledColor": # color for disabled buttons/ui elements,
    "lock_screen": # lock screen path (only absolute paths allowed)
}
```
