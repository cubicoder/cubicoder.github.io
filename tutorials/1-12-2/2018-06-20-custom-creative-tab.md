---
layout: post
title: Custom Creative Tab
date: 2018-06-20
---

We can add our own creative tab for our mod’s items and blocks to go in. Start by making a new package in `com.cubicoder.tutorial` called `tabs`, and create a class there called `TutorialTab`.
```java
package com.cubicoder.tutorial.tabs;
 
import com.cubicoder.tutorial.TutorialMod;
import com.cubicoder.tutorial.init.ModItems;
 
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.ItemStack;
import net.minecraftforge.fml.relauncher.Side;
import net.minecraftforge.fml.relauncher.SideOnly;
 
public class TutorialTab extends CreativeTabs {
 
    public TutorialTab() {
        super(TutorialMod.MODID);
    }
 
    @SideOnly(Side.CLIENT)
    @Override
    public ItemStack getTabIconItem() {
        return new ItemStack(ModItems.FIRST_ITEM);
    }
 
}
```
In the constructor, we set the unlocalized name for the tab, adding our mod id in front. Then, in `getTabIconItem()`, we set the item to be used for the icon of our tab. You can also use a block for this, using `Item.getItemFromBlock()`.

Add a localization for your tab in the en_us.lang file:
```
itemGroup.tutorialmod=Tutorial Mod
```
Add an instance of your tab to the `TutorialMod` class.
```java
public static final CreativeTabs TUTORIAL_TAB = new TutorialTab();
```
Change the `setCreativeTab()` method in your `ItemFirstItem` and `BlockFirstBlock` constructors to reference your creative tab.
```java
setCreativeTab(TutorialMod.TUTORIAL_TAB);
```
That’s all you have to do to have your own creative tab!
![tab0](/img/7tab/tab0.png)
