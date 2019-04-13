---
layout: post
title: Furnace Recipes
date: 2018-06-29
---

After crafting recipes come furnace recipes. Unfortunately, these aren’t JSON files (yet), but only require a few lines of code. For organization purposes, we’re going to make a package named recipes in `com.cubicoder.tutorial`, and in it goes a class named `ModRecipes`. This will hold all our recipes, as well as custom recipe systems if we get that advanced.

In `ModRecipes`, make a `public` `static` `void` method called `initSmelting()`.
```java
package com.cubicoder.tutorial.recipes;

public class ModRecipes {

	public static void initSmelting() {

	}

}
```
In initSmelting(), we add this line:
```java
GameRegistry.addSmelting(Items.DIAMOND, new ItemStack(ModItems.FIRST_ITEM), 10.0F);
```
The `addSmelting()` method takes in three parameters: the input (`Item`, `Block`, or `ItemStack`), the output (`ItemStack`), and the experience gained (`float`) (in points, not levels).

Finally, just call `ModRecipes.initSmelting()` in your main class’s `init()` method, and that’s it!
![smelting0](/img/11smelting/smelting0.png)
