# Setting Up Your C++ Compiler 🛠

Welcome to the first step in your C++ journey! Before you can start writing code, you'll need to set up a C++ compiler. Don't worry, it's easier than convincing a cat to take a bath! 🐱💦

## Table of Contents
- [Linux](#linux)
- [Windows](#windows)

---

## Linux 🐧

Ah, Linux. The developer's paradise. Setting up a C++ compiler here is a breeze. You have a few options, but we'll go with `g++`, which is a part of the GNU Compiler Collection.

### Steps

1. **Open Terminal**: Just press `Ctrl + Alt + T` and voila! A terminal appears as if by magic.
2. **Update Package List**: Run `sudo apt update` to make sure you have the latest package listings.
3. **Install g++**: Run `sudo apt install build-essential` to install `g++` and other essential compilation tools.

That's it! You can now compile C++ programs. Test it by running `g++ --version`.

---

## Windows 💻

Ah, Windows. The OS that asks if you're sure you want to do something, then asks if you're *really* sure. Setting up a C++ compiler here is not as straightforward as on Linux, but hey, we can still make it work!

### Steps 🪜

1. **Download MinGW**: Visit the [MinGW website](https://mingw-w64.org/) and download the installer.
2. **Install MinGW**: Run the installer and follow the on-screen instructions.
3. **Set Environment Variables**: 
    - Search for "Environment Variables" in the Windows search bar.
    - Add the path to your MinGW `bin` folder to the `Path` variable. Typically, this is `C:\MinGW\bin`.


Now, you should be able to run `g++` from the Command Prompt. Test it by running `g++ --version`.

#### Video Tutorial 📹
If you have any trouble, you can follow along with this video tutorial: [How to install MinGW w64 on Windows 10/11 [2023 Update] MinGW GNU Compiler | C & C++ Programming](https://www.youtube.com/watch?v=FEeFG9OR-QU&ab_channel=GeekyScript)

---

Congratulations, you've successfully set up your C++ compiler! Now, you can move on to [setting up your IDE](SettingUpIDE.md) or [try out your first C++ program](../tasks/beginner/hello-world.md)! ➡️