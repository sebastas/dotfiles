# Windows

This directory will include configurations specifically for Windows environments, such as Windows Terminal and WSL.

## Windows Terminal

Windows Terminal is a new, modern, feature-rich, productive terminal application for command-line users. It includes many of the features most frequently requested by the Windows command-line community including support for tabs, rich text, globalization, configurability, theming & styling, and more.
The Terminal doesn't consume vast amounts of memory or power.

### Install

Install the [Windows Terminal from the Microsoft Store](https://aka.ms/terminal).
This allows you to always be on the latest version when we release new builds
with automatic upgrades.

This is the preferred for installing Windows Terminal
> **Note**: Windows Terminal requires Windows 10 2004 (build 19041) or later


### Configuration

This directory contains settings for customizing [Windows Terminal](https://github.com/microsoft/terminal).

The `settings.json` file is located under `C:\Users\User\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`

#### Color scheme
Using the [Nord theme](https://www.nordtheme.com/). Copy the contents of [`nord.json`](nord-theme.json) to Windows Terminal's `settings.json` under `schemes` and then update either the default profile `colorScheme` value or per profile.

Credit for the color codes for Windows Terminal to this [issue](https://github.com/arcticicestudio/nord/issues/123).

```json
{
    "name": "Nord",
    "foreground": "#D8DEE9",
    "background": "#2E3440",
    "black": "#3B4252",
    "red": "#BF616A",
    "green": "#A3BE8C",
    "yellow": "#EBCB8B",
    "blue": "#81A1C1",
    "purple": "#B48EAD",
    "cyan": "#88C0D0",
    "white": "#E5E9F0",
    "brightBlack": "#4C566A",
    "brightRed": "#BF616A",
    "brightGreen": "#A3BE8C",
    "brightYellow": "#EBCB8B",
    "brightBlue": "#81A1C1",
    "brightPurple": "#B48EAD",
    "brightCyan": "#88C0D0",
    "brightWhite": "#E5E9F0"
}
```

#### Font

I use FiraCode NF in Windows Terminal. Can be downloaded from [here](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode).

#### Profiles

As profiles in Windows Terminal use a unique UUID, I do not include the whole `settings.json` as it has to be customized easily. Changes I make are usually in the settings GUI (`Ctrl+,`). Changes include:

- Setting the default profile to new WSL - Ubuntu profile
- Updating color scheme to Nord and font under the Appearance section of profiles (either per profile or default)


## WSL

The Windows Subsystem for Linux lets developers run a GNU/Linux environment -- including most command-line tools, utilities, and applications -- directly on Windows, unmodified, without the overhead of a traditional virtual machine or dualboot setup.

Docs can be found here: [Best practices for setting up a WSL development environment](https://learn.microsoft.com/en-us/windows/wsl/setup/environment)

### Install

Open Windows Terminal as Administrator and and run the following command in PowerShell:

```powershell
wsl --install
```

This will install the default Ubuntu distro. Reboot the machine and start up `wsl.exe` or search for *Ubuntu* in the start menu. Then proceed to set up username and password.