title: Parallax for Dummies
Date: 2015-03-15
Category: Tower Defense
Tags: tower-defense, unity, tutorial
Slug: parallax-for-dummies
Author: TJ
Summary: An enlightening guide on how to create a simple parallax effect in Unity. Using parallax is a really cool way to breathe life into your games.

<p>
    Welcome to the enlightening guide on how to create a simple parallax effect in the Unity editor.
    A parallax effect is an apparent change in the direction of an object caused by a change in observational position that provides a new line of sight.
    In Unity, we'll try and create this effect using the camera as the point of perspective that is changing.
    Basically, as the camera moves around our scene, we will make multiple images appear to be moving at different speeds.
    Luckily, this is an incredibly easy and impressive effect to implement in the Unity editor.
</p>

<p>
    <img src="/static/images/parallax_demo.gif" style="width: 90%;">
    <span class="caption"><a href="http://i.imgur.com/pxVijIt.gifv">imgur</a></span>
</p>

<p>
    First things first, we're going to need a sweet environment to bring to life with our Unity skills.
    Being the thrifty game designers we are, let's head to the internet.
    Search for *parallax* on a site that has images free for commercial use like these on <a href="http://opengameart.org/art-search?keys=parallax">opengameart.org</a>.
    Next, find an appropriate set of images, or an image you can cut up with your favorite image processor to make.
    Grab your own, or <a href="http://opengameart.org/content/hd-multi-layer-parallex-background-samples-of-glitch-game-assets">download the example</a> we use in our main menu for Aurora TD.
</p>

<p>
    Unzip the intriguing "transition_01-mixed composition" set of images to your desktop.
    Note that the images are already cut out for you.
    This will save lots of work, great!  
	Now, for each image in your composition, make a new plane and name it accordingly.
	I used P-0n <description> for my names.
	a couple mountains, a gradient, and three foreground images.
	If the images don't come in order, you will have to figure out which order they go yourself.
	open up each picture in windows photo viewer(or be hardcore and do it in unity) and piece together which one goes where, then name them accordingly with 01 being the closest.
	Take picture 01 and apply it to your plane 01.
	Set the plane's position in your inspector at 0,0,0.
	Then adjust your camera to get a good view of it.
</p>

<img src="/static/images/parallax_planes.jpg" style="max-width: 90%;">

<p>
	Using parallax is a really cool way to breathe life into your games.
	It's been used in hundreds of places.
	League of Legends and Guild Wars 2, for example, use parallax in their videos as a low cost way to animate cutscenes.
</p>

<h4>See It in Action in Aurora Tower Defense</h4>
<img src="/static/images/parallax_aurora_menu.gif" style="width: 90%;">

<p>
    For the source, check out the project on <a href="https://github.com/Final-Parsec/AuroraTD">Github</a>.
</p>