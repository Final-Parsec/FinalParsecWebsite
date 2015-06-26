title: PyGame Interview
Date: 2015-05-03
Category: Space Snakes : Prototype
Tags: snakes, pygame
Slug: pygame-interview
Author: Baer
Summary: The entire Final Parsec team gets interviewed by Sharon Lougheed. We discuss how it all got started and our experiences developing with Python and PyGame.

Recently, I ran into Sharon looking for people to talk to over on [/r/pygame](http://www.reddit.com/r/pygame/), a small but active community.
She's an undergrad student at University of Texas at Dallas working on an [educational blog](http://learningpygame.blogspot.com/) all about game programming with Python and PyGame.
Final Parsec's first foray into game programming was our attempt to build Space Snakes with PyGame.
Even if we have moved toward Unity and C# for most of our development, we've got some experience with the library and still have a strong passion for Python.
Needless to say, we were interested and I reached out to Sharon.

This culminated in a great interview which you can listen to right here. If you'd rather read, the transcript is included as well.

<audio controls>
  <source src="/static/audio/PyGameInterview.mp3" type="audio/mpeg">
</audio>

**Sharon:** Hello everyone!  My name is Sharon Lougheed, and I'm a student at The University of Texas at Dallas.  And I'm interviewing an awesome team of game developers from a company called Final Parsec.  Would you guys like to introduce yourselves?

**TJ:** Sure!  My name is TJ Brosnan.

**Matt:** And I'm Matt Bauer.

**Baer:** And my name is Baer Bradford.

**Sharon:** Okay, so what do you guys do at your team?

**TJ:** We try and make games on our spare time.  It started out as sort of a tool to start learning a new software language called Python.  And from there, we just kind of took on it because we had so much fun to start trying to do new games.

**Sharon:** Are you guys all programmers?

**Baer:** Yes, we're all programmers and developers.  We all went to TCU and majored in computer science.  And that's actually been kind of one of the downfalls of our triumvirate I think is that we lack really badly for art and audio kind of work.  But we definitely manage the programming side very well.

**Sharon:** So how and when did you first learn Python?

**Baer:** Well, for me, I actually started learning Python for my job.  I was working at a company and we were using it to build websites with the framework called Flask.  And we dug pretty deep into it, but not quite in the same way when I met with Matt and TJ and started working on Space Snakes.  How did you guys-- When did you get into Python?  This was the first time you guys started working with it, right?

**TJ:** Yeah, I also got into it for a job.  I actually wanted to try and make a game with Python in order to use it as a tool to learn it so I could do some scripting for my internship at one of the companies I was working for at TCU.

**Matt:** And TJ recruited me shortly after deciding to make a game, and I just wanted to do that.  So that's all-- that was the only reason.  I had no reason to do it for a job.

**TJ:** Yeah, and thn Matt kind of took it away and spent hours and hours doing it.

**Matt:** Yeah.  I stayed up all night a few nights.

**Sharon:** So I understand you were using Pygame when you were working on Space Snakes.  Could you tell us a bit about it, and how would you describe the experience?

**TJ:** I think Matt has a lot to say about Pygame.

**Matt:** Yeah... So Pygame it was a lot of fun developing.  It really gets very close to the OpenGL type of programming without actually having to do OpenGL.  And you don't get a lot of the hand-holding that other game engines like Unreal and Unity 3D do for you.  But at the same time, you have to actually have to program all those things yourself.  So you're spending a lot of time implementing things that have been done thousands of times by other people.  So I really liked it as a learning tool, and it was great to get into.  But after we actually made the switch over to Unity 3D, we just found all these things that we had actually programmed ourselves were just done automatically for us.  So that was pretty nice, and it was a lot easier than chugging through Pygame.

**Sharon:** So I'm going to guess that's why you had difficulty finishing the game?

**Matt:** Yeah.  So we got very far.  We did a whole lot of work, and we finally started to do the multiplayer/networking aspect of our game, and we just realized that it was going to take us probably another year to get anywhere close to what we wanted and what we were going to expect from it.  And that's about whenever I started looking for other engines and saw-- just ran across this tutorial that basically did what we wanted to do in about 10 hours.  And it's like, well... we could do this for another months, or we could learn Unity 3D and could probably be done in a couple of weeks, so that when I started making the switch over.

**Sharon:** For a team that doesn't have art or music people, Space Snakes looks like a pretty cool game.

**TJ:** Yeah, well we were actually able to recruit my friend for some of the art on Space Snakes.  Actually most of it he was able to put together for us, but he was pretty unreliable, and his work kind of tapered off towards the end of the project.  So in our newer games we had to dip into free and open game art and stuff like that.

**Sharon:** Ah, I see.  Alright... What advice do you have for those who are new to Pygame or game development in general?

**Baer:** My advice would actually be to try to start a smaller scale game than something like Space Snakes.  Don't envision that you're going to build a game that has different types of levels and multiplayer and half a dozen different weapons and lobby systems and all kinds of things like that.  It's probably much better for you to try to start with something smaller and then build your way up in subsequent games.

**TJ:** Also, when you do start small like that, you start reusing your code over and over.  So, like, you don't have to rebuild your lobby system or your menu system.  You just go and copy that over and change all the art around and apply all those concepts to your new game, and each game kind of builds on itself after that.

**Baer:** Yeah definitely.  If you're designing your games right, you'll be getting reusable components that you can use elsewhere for a long time in the future.

**TJ:** Another piece of advice that I would give for Pygame in particular is to look at the Python...  What did you call it Baer?

**Baer:** It's [PEP8](https://www.python.org/dev/peps/pep-0008/).  And PEP stands for... I can't actually remember off the top of my head, but it's pretty much a Python standard or convention and PEP8 refers to how everything is formatted and organized and it really helps the readability of your code, which is a big advantage of writing in Python to begin with.

**TJ:** It was, yeah.  Baer came into Space Snakes like a couple months after Matt and I started, and soon as he got here we started switching things over to how he did it at his job to PEP8, and things started to click much faster and it looked better too.

**Sharon:** Oh, my friend mentioned that, and I was wondering should-- is it a good idea to start programming according to PEP8?

**Baer:** Absolutely.  I would get into the habit as soon as you can because it's not-- If you're working on a single project by yourself, it's not going to be such a big deal, but as soon as you get into a team environment, following conventions is going to be one of the most valuable things you can do.  And having it as second-nature will make it so much easier.

**Sharon:** Alright.  Oh... I'm going to have to go back in my code and change it!

**Baer:** If you look around, there are actually development environments that will highlight your code that doesn't follow that standard.  We all personally use [PyCharm](http://www.jetbrains.com/pycharm/).  It's not a free piece of software, but it's one of the better development environments we've found.

**TJ:** I believe they have a free version out now.

**Baer:** Oh yeah, I think they might have a community edition, and it'll go through and tell you if you're not following the appropriate conventions and tell you exactly what you're doing wrong, which is really convenient.

**Sharon:** Well, sweet!  That sounds pretty helpful.

**TJ:** Did you have any advice Matt?

**Matt:** Mmm, nah.  I think y'all covered all the good ones.

**Sharon:** Well I think that's all the questions I have for you today, and thank you so much for agreeing to do this interview.

If you liked this, I encourage you to take a look at [Sharon's blog](http://learningpygame.blogspot.com/).