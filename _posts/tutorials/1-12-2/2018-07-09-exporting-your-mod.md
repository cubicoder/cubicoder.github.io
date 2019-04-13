---
layout: post
title: Exporting Your Mod
date: 2018-07-09
---

At this point, we’ve added a bit of content into the game, and you may be wanting to export your mod so that you can use it outside of Eclipse. This process is a little bit more complicated than exporting as a JAR file through Eclipse’s tools, especially since we are using a multi-project workspace.

First, we need to copy over a few files from your Forge directory. Copy these files into your mod’s root project folder: `.gitignore`, `build.gradle`, `gradlew`, and `gradlew.bat`, as well as the gradle folder.
![export0](/img/12export/export0.png)
Now we need to edit a few of these files. Let’s start with `.gitignore`. This file isn’t necessary for releasing your mod, but it is needed if you are posting the source on GitHub (which you need to do). This file tells **Git**Hub to **ignore** certain files or directories that aren’t relevant to the source code (e.g. all our save files). Edit it to look like this:
```
# eclipse
bin
eclipse
*.launch
.settings
.metadata
.classpath
.project

# idea
out
classes
*.ipr
*.iws
*.iml
.idea

# gradle
build
.gradle

# other
*.DS_Store*
run
!LICENSE
!README.*
!.gitignore
```
Each line specifies a directory or file to ignore. The lines with `#` characters in front are comments.

Next, we need to edit the build.gradle file. This file is responsible for giving various instructions on actually building the JAR file. We need to edit three values: version, group, and archivesBaseName. (Hopefully, these are pretty self-explanatory.) This process can be automated in 1.12.2, and will be fully automated in 1.13.
```groovy
version = "1.12.2-1.0"
group = "com.cubicoder.tutorialmod"
archivesBaseName = "TutorialMod"
```
Finally open a command prompt in the root directory of the project (TutorialMod for me) and run the command `gradlew build` (`./gradlew build` if you're not on windows). Your mod JAR will be in the directory `/build/libs/`.
![export1](/img/12export/export1.png)
Happy playing! You can now publish your mod on CurseForge if you think the world is ready for it.