# Factorio-CPU
> Personal project implementing a rudimentary CPU in the video game Factorio

# About
This is a repository detailing a personal project of trying to design and implement a basic CPU in the video game Factorio. Given that the main part of the project is the "hardware" developped inside an external video game, this repository mainly contains small code snippets used to interact with the CPU, the game, and small tools to make my life easier, in addition to serving as a description and documentation of the project.

This project started simply as an exploration of logic gates and their behavior when used together. Being, at the logical level, the elementary components in computers, I find it extremely interesting how we can use them as simple building blocks to create more and more complicated components. These can, in turn, be treated as new elementary building blocks at higher levels of abstraction, eventually leading to the creation of a processor.

After playing around with logic gates, I started trying to make more complicated components like adders, registers, and RAM function inside the game. This, together with the experience of learning about processor architecture and binary logic in my Engineering Degree, led to a wish of trying to make a (allthough very rudimentary) functional 8-bit CPU tying these different components together. Sticking with individual logic gates and signal lines representing 1 bit each leads to some limitation on implementation, but serves as a proof of concept for the sake of my own interest. Using more of the game's circuit network feature and working at a slightly higher level of abstraction will hopefully allow the implementation of a more interesting 32-bit CPU capable of running more advanced programs.

**This project is very much a WIP, but continues to provide me with both a lot of head-scratching and satisfaction to my curiosity.**

<details open>
<summary><h1> What is <img width="205" height="34" alt="factorio-logo" src="https://github.com/user-attachments/assets/a78293fa-a5d1-4d3a-8094-88de39abdeda" />? (And why am I even talking about it?)</h1></summary>
  
<a href="https://www.factorio.com/">Factorio</a> is simply one of the greatest video games ever created in which you strive for automation, design, create and manage a factory. A further description of the game is, however (sadly), not at all relevant for this project. The "why" is perhaps more interesting.

As mentioned this project started with the simple exploration of, and experimenting with, logic gates. Using the application <a href="https://logisimevolution.com/">Logisim Evolution</a> (allthough a very powerfull tool) quickly became cumbersome when sticking with the elementary logic gates and not using the built-in, more advanced components. As I was only searching for an environement to easily play around and explore these concepts in, I searched for other alternatives, preferably something I was already used to. Considering the simple binary logic needed, my mind quickly fell on the Redstone component in Minecraft, the game's more or less analog to real world electricity. 

<img width="241" height="213" alt="Example of AND-gate and NOT-gate implemented in Minecraft" src="https://github.com/user-attachments/assets/b6d5906d-9074-4e41-9cd5-c5355360c0e3" align="left"/>

Using the games different Redstone components and controling their ON or OFF states can easily be used to model functioning logic gates like shown here with an AND-gate and NOT-gate. 

Minecraft might be the definition of a sandbox game, but the implementation of binary logic quickly requires a lot of building and also incurs a lot of propagation delay. This is not to say it is not possible work around these limitations as people have definetely created some very powerfull CPUs, and fully functionning computers inside of Minecraft (<a href="https://www.youtube.com/watch?v=-BP7DhHTU-I&t=119s">Making Minecraft inside Minecraft</a>), but it didn't give me the immidiate freedom and ease of use I wished for.

<br clear="left"/>
<br/>


I then landed on Factorio, a game I was already playing and very familiar with. More precisely, it was the game's signal and circuit network feature that caught my attention. While being intended as a very powerful and flexible control system for the factories you create in the game, it is also very easy to simulate signals with ON or OFF states. I was already very familiar with the games components, controls and features, and it also has built-in Copy/Cut-Paste and Blueprint features. Furthermore, in it's sandbox mode, the game also allows the player to freeze time and control the speed and execution of individual game ticks, perfect for these types of simulations.

The Blueprint feature is a very powerfull extension of the Copy-Paste feature allowing the player to save different builds and paste them as necessary. Where this feature really shines, however, is in the fact that the blueprints are sharable outside of the game through <a href="https://wiki.factorio.com/Blueprint_string_format">blueprint strings</a>. This means that the content of the blueprint can be exported and extracted as raw JSON, allowing it to be externaly modified and then reinserted into the game.  

For these reasons, I continued to experiment with logic gates and creating more complex components inside the game of Factorio while also writing some scripts and programs to modify and create the blueprints I wanted inside the game.

</details>
