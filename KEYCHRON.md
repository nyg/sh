# Keyboard modifications

* Layout: Swiss French
* Keyboards + OS:
  * MacBookPro + macOS
  * Keychron K3 + macOS
  * Keychron K3 + Ubuntu

The goal is maintain maximum similarity between the three keyboard + OS combinations above.

## Common

* Caps lock → Escape
  * macOS: via Karabiner
  * Ubuntu: ?
* K3 only: ~~swap right option/alt gr with fn key~~ not recognized by the keyboard
* Cmd/Alt + Esc → Navigate through application windows
  * macOS: System Preferences
  * Ubuntu: ?


## macOS / System Preferences

* Mission Control
  * Ctrl + up → Show Desktop
  * Ctrl + down → Application windows
* Keyboard
  * Move focus to the next window
* Input Sources
  * Ctrl + space → Select the previous input source
* Services
  * ?
* App Shortcuts
  * Shift + Cmd + / → Show Help Menu

## macOS / Karabiner

* Simple modifications
  * All: caps lock → escape
  * MBP fix: probably a bug with Karabiner (see [Karabiner-Elements#2027](https://github.com/pqrs-org/Karabiner-Elements/issues/2027))
    * grave_accent_and_tilde → non_us_backlash
    * non_us_backlash → grave_accent_and_tilde
    * backslash → non_us_pound
  * K3: ~~right command → fn and fn → right option~~ right_command → right_option
* Complex modifications
  * *Map Left Option plus h/j/k/l to Arrows* rule
  * option + …

    | From                          | To                      |
    | ----------------------------- | ----------------------- |
    | è (option + open_braket)      | [ (option + 5)          |
    | ¨ (option + close_braket)     | ] (option + 6)          |
    | à (option + quote)            | { (option + 8)          |
    | $ (option + non_us_pound¶)    | } (option + 9)          |
    | < (option + non_us_backslash) | \ (option + shift + 7)  |
    | ^ (option + equal_sign)       | ~ (option + n)          |
    | ? (option + hyphen)           | ´ (option + equal_sign) |
    | é (option + semicolon)        | ∆ (option + k)          |
    | option + 5                    | *disabled*              |
    | option + 6                    | ¬ (option + l)          |
    | option + 8                    | ¢ (option + semicolon)  |
    | option + 9                    | *disabled*              |
    | option + n                    | *disabled*              |

## Ubuntu

### Keychron K3

* [Make Fn keys work](https://gist.github.com/andrebrait/961cefe730f4a2c41f57911e6195e444#make-fn--f-keys-work)
* Exchange alt gr and fn ?
