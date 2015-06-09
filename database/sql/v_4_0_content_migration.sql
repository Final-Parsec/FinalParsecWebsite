-- delete from post_tag;
-- delete from post;
-- delete from tag;

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('caching-and-apache','2015-02-23', 'Quick tutorial covering how HTTP headers affect browser caching and configuring Apache for your needs.', '
As you may or may not have noticed, our website is entirely comprised of static files.
We do this despite the fact that our site has a large amount of somewhat dynamic content (for instance, the blog you''re reading right now).
This is accomplished by using a static site generator ([Pelican](http://docs.getpelican.com/)) and letting Apache serve the output straight off the file system.
The primary benefits include:
<ul class=default>
    <li>Tracking changes and entire history of the site is as easy as keeping it under version control.</li> 
    <li>No server side scripting or processing to speak of.</li>
    <li>We don''t need to query a database.</li>
</ul>
These last two help cut down on the response time when a user requests content which is vitally important.

One side effect of taking this approach is that browsers can pretty aggressively cache the resources that compose your site.
This can either be a really good or really bad thing depending on the nature of your site.
Browsers caching your content can result in very quick render times, but users may be looking at stale content.
As I mention earlier in the article, our site changes frequently as we update it with new posts and such.
This means a user seeing stale content is a problem for us.

There are several ways you can tell a browser to avoid caching (or at least check for an updated version) primarily through the use of HTTP headers.
The header we''re going to be interested in is the **cache-control** header.
A few others headers exist to manipulate caching behavior. If you want to dive into more information, [take a look at this blog post](http://www.mobify.com/blog/beginners-guide-to-http-cache-headers/).

We can use the Apache module [mod_expires](http://httpd.apache.org/docs/2.2/mod/mod_expires.html) to manipulate this header.

Prior to enabling this module, you''ll want to add rules to your virtual host file (you can also put this configuration information in **.htaccess**).
Our rules allow clients to cache content for 1 month with the exception of **html** files.
These expire immediately requiring the browser to check with our server before using a cached version of the content.
Using this strategy, we get the benefits of caching where it matters (larger files like images and frequently requested files like CSS) while getting the guarantee users will always see fresh content.

<pre class=''apply-line-numbers''><code class=''hljs apache''>&lt;IfModule mod_expires.c&gt;
    ExpiresActive on
    ExpiresDefault          "access plus 1 month"

    ExpiresByType text/html "access plus 0 seconds"
&lt;/IfModule&gt;
</code></pre>

Once you''ve modified your configuration, enable the mod_expires module.
<pre class=''apply-line-numbers''><code class=''hljs bash''></code>sudo a2enmod expires</pre>

Then restart apache to ensure your changes take effect.
<pre class=''apply-line-numbers''><code class=''hljs bash''></code>sudo service apache2 restart</pre>', 'Caching and Apache', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('web-dev');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('apache');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('cache');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('a-star-pathfinding-tutorial','2014-08-03', 'Technical talk from Matt Bauer about A* pathfinding in Nauticus Act III.', '
Pathfinding plays a vital part of Nauticus Act III.
This technical tutorial demonstrates implementing and optimizing A-Star path finding in a Unity3D game.

Code from our project:
<ul>
    <li><a href="https://docs.google.com/file/d/0B-JImkXz82YGdjZpb0U3aXNubTA">EventHandler.cs</a></li>
    <li><a href="https://docs.google.com/file/d/0B-JImkXz82YGbTVtMTM4a214aXc">MinHeap.cs</a></li>
</ul>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/Lv9LyAwxGXY?rel=0" frameborder="0" allowfullscreen></iframe>
</div>


And some additional resources to help get you started:
<ul>
    <li><a href="http://www.policyalmanac.org/games/aStarTutorial.htm">A\* Pathfinding for Beginners</a></li>
    <li><a href="http://theory.stanford.edu/~amitp/GameProgramming/AStarComparison.html">Introduction to A\*</a></li>
    <li><a href="http://en.wikipedia.org/wiki/A*_search_algorithm">A\* Search Algorithm</a></li>
</ul>', 'A* Pathfinding Tutorial', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('nauticus');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('pathfinding');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('building-a-leaderboard-system','2015-03-29', 'In this post, we discuss building an online application capable of tracking score boards (leaderboards) for a number of games and categories.', '
Our ultimate goal is to create a system which can track a variety of leaderboards for our games here at Final Parsec.
The general idea is that after a player wins a game, they''ll be given a numeric score which can be used to rank all players globally.
We target a variety of platforms with our games and almost every single one will need to submit and view scores.
It''s likely we will want to display the leaderboards on our website too at some point.
Pretty much everything is going to be doing this same thing.
Maybe we should build an API to handle it.

### Designing the API

There''s not much to this. The system tracks a collection of **scores**.
 
Each score has the following attributes:
* Player''s Name
* A Numeric Score
* Assignment to a Leaderboard




<pre class=''apply-line-numbers''><code class=''hljs apache''>create table if not exists scores
(
    id int unsigned not null auto_increment,
    player_name VARCHAR(20), 
    score int unsigned,
    leaderboard_name varchar(100)
);
</code></pre>

> ### GET /scores/{leaderboard_name}
> Requests a list of scores within a certain leaderboard.






-------------------------------------------------------------------------------------
As you may or may not have noticed, our website is entirely comprised of static files.
We do this despite the fact that our site has a large amount of somewhat dynamic content (for instance, the blog you''re reading right now).
This is accomplished by using a static site generator ([Pelican](http://docs.getpelican.com/)) and letting Apache serve the output straight off the file system.
The primary benefits include:
<ul class=default>
    <li>Tracking changes and entire history of the site is as easy as keeping it under version control.</li> 
    <li>No server side scripting or processing to speak of.</li>
    <li>We don''t need to query a database.</li>
</ul>
These last two help cut down on the response time when a user requests content which is vitally important.

One side effect of taking this approach is that browsers can pretty aggressively cache the resources that compose your site.
This can either be a really good or really bad thing depending on the nature of your site.
Browsers caching your content can result in very quick render times, but users may be looking at stale content.
As I mention earlier in the article, our site changes frequently as we update it with new posts and such.
This means a user seeing stale content is a problem for us.

There are several ways you can tell a browser to avoid caching (or at least check for an updated version) primarily through the use of HTTP headers.
The header we''re going to be interested in is the **cache-control** header.
A few others headers exist to manipulate caching behavior. If you want to dive into more information, [take a look at this blog post](http://www.mobify.com/blog/beginners-guide-to-http-cache-headers/).

We can use the Apache module [mod_expires](http://httpd.apache.org/docs/2.2/mod/mod_expires.html) to manipulate this header.

Prior to enabling this module, you''ll want to add rules to your virtual host file (you can also put this configuration information in **.htaccess**).
Our rules allow clients to cache content for 1 month with the exception of **html** files.
These expire immediately requiring the browser to check with our server before using a cached version of the content.
Using this strategy, we get the benefits of caching where it matters (larger files like images and frequently requested files like CSS) while getting the guarantee users will always see fresh content.

<pre class=''apply-line-numbers''><code class=''hljs apache''>&lt;IfModule mod_expires.c&gt;
    ExpiresActive on
    ExpiresDefault          "access plus 1 month"

    ExpiresByType text/html "access plus 0 seconds"
&lt;/IfModule&gt;
</code></pre>

Once you''ve modified your configuration, enable the mod_expires module.
<pre class=''apply-line-numbers''><code class=''hljs bash''></code>sudo a2enmod expires</pre>

Then restart apache to ensure your changes take effect.
<pre class=''apply-line-numbers''><code class=''hljs bash''></code>sudo service apache2 restart</pre>', 'Building a Leaderboard System', 1, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('web-dev');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('apache');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('mysql');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('legacy-earth-enemy-health-and-explosions','2015-04-20', 'Video tutorial about managing enemy health in a rail shooter built with Unity3d. We''ll also discuss killing enemies in fiery explosions.', '
This is a continuation of Final Parsec''s tutorial series on building a space-themed rail shooter with Unity3d.
In previous tutorials, we''ve discussed enemies detecting and firing at the player.
Now we have come to the point where the player needs to be able to fight back.

In this video tutorial, I''ll discuss managing the health of enemies when they get shot by the player.
Then we''ll discuss how to make the enemies blow up and be removed from the game when they are dead.

You can follow along with the development of the project and find the source code from the tutorial on [GitHub](https://github.com/Final-Parsec/Blueshift).

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/1gTJWuKe6po?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Enemy Health and Explosions', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('snakes');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('legacy-earth');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('legacy-earth-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('legacy-earth-ship-movement','2015-02-15', 'Video tutorial about ship and camera movement in a rail shooter built with Unity3d.', '
Our new game is going to be a space rail shooter. 
Similar to the Star Fox series, we plan on creating an immersive story with a simple user interface.
The enemies will be ground turrets and flying types with multiple engagement modes.
There will also be unique boss battles at the end of most of the levels.

In this tutorial I''ll be going over the ship and camera movement.

We have our up to date source code and project files on [GitHub](https://github.com/Final-Parsec/Blueshift).

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/TKF7d1BVE0Q?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Ship Movement Tutorial', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('snakes');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('legacy-earth');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('movement');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('legacy-earth-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('legacy-earth-turrets-and-missiles','2015-02-28', 'Video tutorial about turrets and missiles in a rail shooter built with Unity3d.', '
This is a continuation of Final Parsec''s tutorial series on building a space-themed rail shooter with Unity3d.
Combat in this game involves dodging fire from ground based turrets.

In this tutorial, I''ll be going over how to build turrets which detect the player using colliders.
Then we''ll discuss how to make the turret face the player and fire.

You can follow along with the development of the project and find the source code from the tutorial on [GitHub](https://github.com/Final-Parsec/Blueshift).

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/zgqh98HZI3E?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Turrets and Missiles Tutorial', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('snakes');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('legacy-earth');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('turret');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('legacy-earth-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('nauticus-alpha-screenshots','2014-06-22', 'A first look at Nauticus, Final Parsec''s upcoming pirate adventure.', '

<p>
Caught in the golden age of piracy and a zombie apocalypse, Piro is forced into a life of heroism.
Zombies have overrun major ports, and the isolation of the sea has enabled him to survive.
The only remaining member of his crew is Hope, the sole wench to have plundered his heart.
Nauticus is a three-act tale of betrayal, survival, pillaging, and booty as the two seek refuge with an old friend.
</p>
<iframe class="imgur-album" width="100%" height="550" frameborder="0" src="http://imgur.com/a/yCmpm/embed"></iframe>', 'Nauticus Alpha Screenshots', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('nauticus');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('nauticus-first-playthrough','2014-07-27', 'Video playthrough of Nauticus, Final Parsec''s three-act game depicting the adventures of Piro.', '
<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/_It3JCNDPVI?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Nauticus First Playthrough', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('nauticus');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('nauticus-map-generation','2014-03-31', 'Learn how to programmatically generate earth-like terrain using cellular automata.', '
<h2>Introduction to Cellular Automata</h2>

<p>A cellular automaton consists of a grid of cells, each in one of a finite number of states, such as on and off. The grid can be in any finite number of dimensions. For each cell, a set of cells called its neighborhood is defined relative to the specified cell. An initial state is selected by assigning a state for each cell. A new generation is created, according to some fixed rule that determines the new state of each cell in terms of the current state of the cell and the states of the cells in its neighborhood. </p>

<h2>The Game of Life</h2>

<p>In the classic model of Cellular Automata (CA) Conway''s Game of Life, the cells follow four simple rules. <p>

<ol>
	<li>Any live cell with fewer than two live neighbors dies, as if caused by under-population.</li>
	<li>Any live cell with two or three live neighbors lives on to the next generation.</li>
	<li>Any live cell with more than three live neighbors dies, as if by overcrowding.</li>
	<i>Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.</li>
</ol>

<p>These simple rules ended up evolving complex patterns capable of motion and self-replication.So, if we take the ideas from this and apply them to map generation we should be able to create unique worlds for players to explore.</p>

<h2>Applying CA to Map Generation</h2>

<p>In Conway''s Game of Life the cell is either alive or dead and always stays in one location (Although patterns can give the appearance of motion). For map generation we are going to create agents to move fromtheir current cell to one of the neighboring cells.</p>

<h3>Creating Agents</h3>

<p>Agents work with a given set of rules. The rules of an agent are determined by what you want that agent to accomplish. Maybe you want an agent that can create meandering rivers, lakes, or mountain ranges. Rules can be developed to create all of these things. For this example we are only going to create on set of rules for all of our tile types.</p>

<p>We want our agents to create groupings of tiles that are the same, while still having an element of randomness. To accomplish this we have 2 simple rules.</p>

<ul>
	<li>An agent can only move to a neighboring tile that is not the same type that the agent is creating.</li>
	<li>An agent is more likely to move to a tile if that tile has more neighboring tiles of the agent''s type.</li>
</ul>


<h3>Initial State</h3>

<p>Initially I fill my map with one tile type, grass. Then I create a random number of Tree Agents, Mountain Agents, and Water Agents and place them randomly on the map.</p>

<p>Each agent is given a number of times they are allowed to move. When they run out of moves or they can''t find a new place to move to, they are killed. The maps that are created can be varied by changing the number of agents that are used or by changing the number of times they are allowed to move. I start by filling a percentage of the map with agents and then give them a random number from a range to determine how far they can move.</p>

<h3>Examples</h3>

<p>Here are two example maps that my agents created. The larger map is 200x200 and the smaller map is 50x50.</p>

<img src="/static/images/random_map_generation_1.png" style="width: 95%;" />

<img src="/static/images/random_map_generation_2.png" style="width: 95%;" />

<p>
<strong>Cell</strong> A cell is a location inside the Map that contains a cell type that is manipulated by an agent.<br><br>
<strong>Cell Type</strong> The type of cell it is. Our cells have the following types Grass, Mountain, Water, and Tree.<br><br>
<strong>Map</strong> The map is a 2-dimensional plane that is separated into an NxM matrix of cells.<br><br>
<strong>Neighborhood/Neighbors</strong> The neighborhood of a cell consists of any cell that is touching or diagonal to the current cell.<br><br>
	














', 'Using Cellular Automata to Create a Random Map Generator', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('nauticus');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('map-generation');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('snakes-alpha-1','2014-03-16', 'Video of Space Snakes, Final Parsec''s upcoming 2D platformer, in its alpha state.', '
<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/UjPxhrWIjJk?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Space Snakes Alpha Look', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('snakes');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('snakes-concept-art','2014-03-16', 'A first look at Space Snakes, Final Parsec''s upcoming 2D platformer.', '
<iframe class="imgur-album" width="100%" height="550" frameborder="0" src="http://imgur.com/a/f1Ryd/embed"></iframe>', 'Space Snakes Concept Art', 0, 3);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('snakes');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('alpha');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('pygame-interview','2015-05-03', 'The entire Final Parsec team gets interviewed by Sharon Lougheed. We discuss how it all got started and our experiences developing with Python and PyGame.', '
Recently, I ran into Sharon looking for people to talk to over on [/r/pygame](http://www.reddit.com/r/pygame/), a small but active community.
She''s an undergrad student at University of Texas at Dallas working on an [educational blog](http://learningpygame.blogspot.com/) all about game programming with Python and PyGame.
Final Parsec''s first foray into game programming was our attempt to build Space Snakes with PyGame.
Even if we have moved toward Unity and C# for most of our development, we''ve got some experience with the library and still have a strong passion for Python.
Needless to say, we were interested and I reached out to Sharon.

This culminated in a great interview which you can listen to right here. If you''d rather read, the transcript is included as well.

<audio controls>
  <source src="/static/audio/PyGameInterview.mp3" type="audio/mpeg">
</audio>

**Sharon:** Hello everyone!  My name is Sharon Lougheed, and I''m a student at The University of Texas at Dallas.  And I''m interviewing an awesome team of game developers from a company called Final Parsec.  Would you guys like to introduce yourselves?

**TJ:** Sure!  My name is TJ Brosnan.

**Matt:** And I''m Matt Bauer.

**Baer:** And my name is Baer Bradford.

**Sharon:** Okay, so what do you guys do at your team?

**TJ:** We try and make games on our spare time.  It started out as sort of a tool to start learning a new software language called Python.  And from there, we just kind of took on it because we had so much fun to start trying to do new games.

**Sharon:** Are you guys all programmers?

**Baer:** Yes, we''re all programmers and developers.  We all went to TCU and majored in computer science.  And that''s actually been kind of one of the downfalls of our triumvirate I think is that we lack really badly for art and audio kind of work.  But we definitely manage the programming side very well.

**Sharon:** So how and when did you first learn Python?

**Baer:** Well, for me, I actually started learning Python for my job.  I was working at a company and we were using it to build websites with the framework called Flask.  And we dug pretty deep into it, but not quite in the same way when I met with Matt and TJ and started working on Space Snakes.  How did you guys-- When did you get into Python?  This was the first time you guys started working with it, right?

**TJ:** Yeah, I also got into it for a job.  I actually wanted to try and make a game with Python in order to use it as a tool to learn it so I could do some scripting for my internship at one of the companies I was working for at TCU.

**Matt:** And TJ recruited me shortly after deciding to make a game, and I just wanted to do that.  So that''s all-- that was the only reason.  I had no reason to do it for a job.

**TJ:** Yeah, and thn Matt kind of took it away and spent hours and hours doing it.

**Matt:** Yeah.  I stayed up all night a few nights.

**Sharon:** So I understand you were using Pygame when you were working on Space Snakes.  Could you tell us a bit about it, and how would you describe the experience?

**TJ:** I think Matt has a lot to say about Pygame.

**Matt:** Yeah... So Pygame it was a lot of fun developing.  It really gets very close to the OpenGL type of programming without actually having to do OpenGL.  And you don''t get a lot of the hand-holding that other game engines like Unreal and Unity 3D do for you.  But at the same time, you have to actually have to program all those things yourself.  So you''re spending a lot of time implementing things that have been done thousands of times by other people.  So I really liked it as a learning tool, and it was great to get into.  But after we actually made the switch over to Unity 3D, we just found all these things that we had actually programmed ourselves were just done automatically for us.  So that was pretty nice, and it was a lot easier than chugging through Pygame.

**Sharon:** So I''m going to guess that''s why you had difficulty finishing the game?

**Matt:** Yeah.  So we got very far.  We did a whole lot of work, and we finally started to do the multiplayer/networking aspect of our game, and we just realized that it was going to take us probably another year to get anywhere close to what we wanted and what we were going to expect from it.  And that''s about whenever I started looking for other engines and saw-- just ran across this tutorial that basically did what we wanted to do in about 10 hours.  And it''s like, well... we could do this for another months, or we could learn Unity 3D and could probably be done in a couple of weeks, so that when I started making the switch over.

**Sharon:** For a team that doesn''t have art or music people, Space Snakes looks like a pretty cool game.

**TJ:** Yeah, well we were actually able to recruit my friend for some of the art on Space Snakes.  Actually most of it he was able to put together for us, but he was pretty unreliable, and his work kind of tapered off towards the end of the project.  So in our newer games we had to dip into free and open game art and stuff like that.

**Sharon:** Ah, I see.  Alright... What advice do you have for those who are new to Pygame or game development in general?

**Baer:** My advice would actually be to try to start a smaller scale game than something like Space Snakes.  Don''t envision that you''re going to build a game that has different types of levels and multiplayer and half a dozen different weapons and lobby systems and all kinds of things like that.  It''s probably much better for you to try to start with something smaller and then build your way up in subsequent games.

**TJ:** Also, when you do start small like that, you start reusing your code over and over.  So, like, you don''t have to rebuild your lobby system or your menu system.  You just go and copy that over and change all the art around and apply all those concepts to your new game, and each game kind of builds on itself after that.

**Baer:** Yeah definitely.  If you''re designing your games right, you''ll be getting reusable components that you can use elsewhere for a long time in the future.

**TJ:** Another piece of advice that I would give for Pygame in particular is to look at the Python...  What did you call it Baer?

**Baer:** It''s [PEP8](https://www.python.org/dev/peps/pep-0008/).  And PEP stands for... I can''t actually remember off the top of my head, but it''s pretty much a Python standard or convention and PEP8 refers to how everything is formatted and organized and it really helps the readability of your code, which is a big advantage of writing in Python to begin with.

**TJ:** It was, yeah.  Baer came into Space Snakes like a couple months after Matt and I started, and soon as he got here we started switching things over to how he did it at his job to PEP8, and things started to click much faster and it looked better too.

**Sharon:** Oh, my friend mentioned that, and I was wondering should-- is it a good idea to start programming according to PEP8?

**Baer:** Absolutely.  I would get into the habit as soon as you can because it''s not-- If you''re working on a single project by yourself, it''s not going to be such a big deal, but as soon as you get into a team environment, following conventions is going to be one of the most valuable things you can do.  And having it as second-nature will make it so much easier.

**Sharon:** Alright.  Oh... I''m going to have to go back in my code and change it!

**Baer:** If you look around, there are actually development environments that will highlight your code that doesn''t follow that standard.  We all personally use [PyCharm](http://www.jetbrains.com/pycharm/).  It''s not a free piece of software, but it''s one of the better development environments we''ve found.

**TJ:** I believe they have a free version out now.

**Baer:** Oh yeah, I think they might have a community edition, and it''ll go through and tell you if you''re not following the appropriate conventions and tell you exactly what you''re doing wrong, which is really convenient.

**Sharon:** Well, sweet!  That sounds pretty helpful.

**TJ:** Did you have any advice Matt?

**Matt:** Mmm, nah.  I think y''all covered all the good ones.

**Sharon:** Well I think that''s all the questions I have for you today, and thank you so much for agreeing to do this interview.

If you liked this, I encourage you to take a look at [Sharon''s blog](http://learningpygame.blogspot.com/).', 'PyGame Interview', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('snakes');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('pygame');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-creating-waves-of-enemies','2014-11-25', 'The fourth video tutorial of a series which takes you through the process of building a tower defense game.', '
<p>
    This tutorial goes over how to create random waves of enemies.
    The waves include bosses every 10th wave and different types of enemies. 
    Waves are sent either when an interval of time has passed or the player has commanded a new wave. 
    Also, multiple waves can be actively spawning enemies at the same time.
</p>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/2FZ30gX8Drs?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Tower Defense Tutorials Part 4', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('td-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-enemy-detection-and-firing','2014-11-23', 'Learn how to detect enemies and shoot projectiles at them. A continuation of the tower defense tutorial series.', '
<p>
    Learn how to make turrets detect enemies and shoot projectiles at them.
    A continuation of the tower defense tutorial series.
</p>


<h3>Setting Up Your Turret GameObject</h3>

<p>
    Go ahead and get started by creating a Sprite in your hierarchy.
</p>
<p>
    This should create a new <a href="http://docs.unity3d.com/Manual/class-GameObject.html" target="_blank">GameObject</a> 
    with the <a href="http://docs.unity3d.com/Manual/class-Transform.html" target="_blank">Transform</a> and 
    <a href="http://docs.unity3d.com/Manual/class-SpriteRenderer.html" target="_blank">Sprite Renderer</a> components        
</p>

<p>  
    Don''t worry too much about changing the position; we''re going to be setting that programmatically when the player tries to place a turret on the map.
    Do, however, add some cool art to the Sprite property of your renderer.
</p>

<p>
    <span class="caption">This is what we''re using for our Earth Type Turrets. Maybe one day we''ll hire an artist...</span>
    <img src="/static/images/tower_defense_enemy_detection_and_firing_earth_turret_art.png">
</p>

<p>
    Attach a MonoBehavior script and call it <span style=''font-weight: bold;''>Turret.cs</span>.
</p>

<p>
    Attach a <a href="http://docs.unity3d.com/Manual/class-SphereCollider.html" target="_blank">Sphere Collider</a> too.
    Make sure the <span style=''font-weight: bold;''>Is Trigger</span> property is checked.
    Don''t worry about changing values for <span style=''font-weight: bold;''>Center</span> and <span style=''font-weight: bold;''>Radius</span>
    as we''ll be changing these programmatically.
</p>

<p>
    
    <img src="/static/images/tower_defense_enemy_detection_and_firing_earth_turret_components.png">
    <span class="caption">Your GameObject''s components should look something like this.</span>
</p>

<p>
    Go ahead and create a prefab by dragging the turret from your scene to a directory in the project tab.
    Having our turrets as prefabs will give the benefit of being able to instantiate them from code.
    We can even create multiple prefabs which will allow for different turret types, each with their own stats, special abilities, and artwork.
</p>

<h3>Writing the Scripts</h3>

<p>
    Open up the <span style=''font-weight: bold;''>Turret.cs</span> attached to your prefab. It should look something like this:
</p>

<pre class=''apply-line-numbers''><code class=''hljs cs''>using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class Turret : MonoBehaviour
{
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}</code></pre>

<span class="caption">Take note I''ve added a couple <span class=''hljs-keyword''>using</span> statements.</span>

<p>
    Let''s add some fields and properties. Keep in mind the public fields will be accessible in Unity''s inspector panel. 
    <span style=''font-weight: bold;''>damage</span>, <span style=''font-weight: bold;''>range</span>, and <span style=''font-weight: bold;''>rateOfFire</span> are all meant to adjusted there on a 0-10 scale.
    The associated properties <span style=''font-weight: bold;''>AttackDelay</span> and <span style=''font-weight: bold;''>DetectionRadius</span> scale those values to based on the size of the map.
    <span style=''font-weight: bold;''>DetectionRadius</span> also takes responsibility for changing the size of the attached sphere collider. 
</p>

<pre class=''apply-line-numbers''><code class=''hljs cs''>// Configurable
public float accuracyError = 2.0f;
public int damage = 10;
public GameObject projectileType;
public int range = 5;
public int rateOfFire = 5;

// Constants
private const float MinAttackDelay = 0.1f;
private const float MaxAttackDelay = 2f;

// Internal
private List<EnemyBase> myTargets;
private float nextDamageEvent;
private ObjectManager objectManager;	
private static readonly object syncRoot = new object ();

// Properties
private float AttackDelay
{
    get 
    {
        int inverted = rateOfFire;
        if (rateOfFire == 0) 
        { 
            return float.MaxValue;
        }
        else if (rateOfFire < 5)
        {
            inverted = rateOfFire + 2 * (5 - rateOfFire);
        }
        else if (rateOfFire > 5) 
        {
            inverted = rateOfFire - 2 * (rateOfFire - 5);
        }
        
        return (((float)inverted - 1f) / (10f - 1f)) * (MaxAttackDelay - MinAttackDelay) + .1f;
    }
}

public float DetectionRadius
{ 
    get 
    {	
        float minRange = Mathf.Min(objectManager.Map.nodeSize.x, objectManager.Map.nodeSize.y) * 1.5f;
        float maxRange = minRange * 4f;
        
        float detectionRadius = (((float)range - 1f) / (10f - 1f)) * (maxRange - minRange) + minRange;
        detectionRadius = detectionRadius / transform.localScale.x;
        
        return detectionRadius;
    }
    set 
    {
        float minRange = Mathf.Min(objectManager.Map.nodeSize.x, objectManager.Map.nodeSize.y) * 1.5f;
        float maxRange = minRange * 4f;
        
        float detectionRadius = (((float)value - 1f) / (10f - 1f)) * (maxRange - minRange) + minRange;
        detectionRadius = detectionRadius / transform.localScale.x;
        
        SphereCollider collider = transform.GetComponent<SphereCollider> ();
        collider.radius = detectionRadius;
    }
}</code></pre>

<p>
    Here we initialize some of those private fields.
    <span style=''font-weight: bold;''>objectManager</span> is just a singleton we are using to help maintain game state.
    Matt talks more in-depth about it in some of the earlier videos from the <a href="/tag/td-video-series.html">Tower Defense Tutorial Video Series</a>.
</p>

<pre class=''apply-line-numbers''><code class=''hljs cs''>// Runs when entity is Instantiated
void Awake()
{
    objectManager = ObjectManager.GetInstance();
    objectManager.AddEntity(this);
}

// Use this for initialization
void Start ()
{
    DetectionRadius = range;
    myTargets = new List<EnemyBase>();
}</code></pre>

<p>
    These two methods track when enemies enter and exit the attached sphere collider.
    At any given time, <span style=''font-weight: bold;''>myTargets</span> should now reflect all enemies inside the sphere, the turret''s detectable area.
</p>
	

<pre class=''apply-line-numbers''><code class=''hljs cs''>void OnTriggerEnter (Collider other)
{
    if (other.gameObject.tag == "enemy") {	
        myTargets.Add (other.GetComponent<EnemyBase>());
    }
}

void OnTriggerExit (Collider other)
{
    lock (syncRoot) {
        if (other != null &&
            myTargets.Select (t => t!= null && t.gameObject).Contains(other.gameObject)) {
            myTargets.Remove (other.GetComponent<EnemyBase>());
        }
    }
    
}</code></pre>

<h3>Killing Dudes with Projectiles</h3>

<p>
    In order to create a projectile, create a new <a href="http://docs.unity3d.com/Manual/class-GameObject.html" target="_blank">GameObject</a> starting with as a sphere. 
    I ended up adding a <a href="http://docs.unity3d.com/Manual/class-MeshRenderer.html" target="_blank">Mesh Renderer</a> and a <a href="http://docs.unity3d.com/Manual/class-LineRenderer.html" target="_blank">Line Renderer</a> to get it to look like a bullet.
    Attach a MonoBehavior script called <span style=''font-weight: bold;''>Projectile.cs</span>.
    Go ahead and make a prefab from this object the same way you did for turrets.
</p>

<p>
     Nothing too crazy going on in this script.
     It requires a target enemy (and associated location) and just homes in on it until it "hits".
     We''re not doing any collision detection here, but rather checking distance between the projectile and its target.
     Once the projectile reaches the target, it destroys itself and damages the enemy by subtracting from its health. 
</p>

<pre class=''apply-line-numbers''><code class=''hljs cs''>using UnityEngine;
using System.Collections;

public class Projectile : MonoBehaviour
{
	// Configurable
	public float range;
	public float speed;
	public EnemyBase target;
	public Vector3 targetPosition;

	public int Damage { get; set; }
	
	// Internal
	private float distance;
	
	// Runs when entity is Instantiated
	void Awake ()
	{
		distance = 0;
	}
	
	// Update is called once per frame
	void Update ()
	{
		Vector3 moveVector = new Vector3 (transform.position.x - targetPosition.x,
		                                 transform.position.y - targetPosition.y,
		                                 transform.position.z - targetPosition.z).normalized;
		
		// update the position
		transform.position = new Vector3 (transform.position.x - moveVector.x * speed * Time.deltaTime,
		                                 transform.position.y - moveVector.y * speed * Time.deltaTime,
		                                 transform.position.z - moveVector.z * speed * Time.deltaTime);
		                                 
		distance += Time.deltaTime * speed;
		
		if (distance > range ||
			Vector3.Distance (transform.position, new Vector3 (targetPosition.x, targetPosition.y, targetPosition.z)) < 1) 
        {
			Destroy (gameObject);
			if (target != null) 
            {
				target.Damage (Damage);
			}
		}
	}
}</code></pre>

<p>
    Now that projectiles are good to go, drag that new projectile prefab onto the <span style=''font-weight: bold;''>projectileType</span> field (in the inspector when you''ve got a turret selected).
    Next, you''ll need the following two methods to make the turret "fire" projectiles.
    All we''re doing is setting up a loop where the turret instantiates new projectiles targeted at a random enemy within range.
</p>

<pre class=''apply-line-numbers''><code class=''hljs cs''>void Fire (EnemyBase myTarget)
{
    var targetPosition = myTarget.transform.position;
    var aimError = Random.Range (-accuracyError, accuracyError);
    var aimPoint = new Vector3 (targetPosition.x + aimError, targetPosition.y + aimError, targetPosition.z + aimError);
    nextDamageEvent = Time.time + AttackDelay;
    GameObject projectileObject = Instantiate (projectileType, transform.position, Quaternion.LookRotation (targetPosition)) as GameObject;
    Projectile projectile = projectileObject.GetComponent<Projectile> ();
    projectile.Damage = damage;
    projectile.target = myTarget;
    projectile.targetPosition = aimPoint;
}

// Update is called once per frame
void Update ()
{
    lock(syncRoot)
    {
        if (myTargets.Any())
        {
            EnemyBase myTarget = myTargets.ElementAt(Random.Range(0, myTargets.Count));
            
            
            if (myTarget != null) {
                if (Time.time >= nextDamageEvent)
                {
                    Fire(myTarget);
                }
            }
            else
            {
                nextDamageEvent = Time.time + AttackDelay;
                myTargets.Remove(myTarget);
            }              
        }
    }		
}</code></pre>

<p>
    To fill in some of the gaps like placing turrets on the map and spawning enemies, I encourage you to go take a look at some of the earlier videos from the <a href="/tag/td-video-series.html">Tower Defense Tutorial Video Series</a>. 
</p>', 'Enemy Detection and Firing', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('turret');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-interfacing-with-the-map','2014-10-02', 'The second video tutorial of a series which takes you through the process of building a tower defense game.', '
<p>
    So now that you have a grid environment similar to what we built in the <a href="/tower-defense-no-gameobject-grid.html">previous tutorial</a>, it''s time to actually start using it.
    This tutorial goes over how the user interfaces and interacts with the map.
</p>

<p>
    At this point, the primary interaction with the map will be handling a player''s clicks and placing turrets for them.
    It is necessary to ensure the turrets are placed at valid locations, and also to update the paths of enemies as the world changes around them.
    In this tutorial, we dig into placing turrets on the map. 
</p>

<p>
    Upcoming tutorials cover getting enemies to move around and making the turrets attack, so be sure to check back!
</p>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/rUhcdcS6mj4?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Tower Defense Tutorials Part 2', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('map-generation');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('td-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-in-game-menu-and-little-things','2014-12-07', 'The sixth video tutorial of a series which takes you through the process of building a tower defense game.', '
<p>
    This video demonstrates how to build an in game options menu.
    I provide a discussion on the usage of NGUI and future changes to building user interfaces in upcoming versions of Unity.
</p>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/GHbWHnSYvow?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

<p>
    We also showcase some of the enhancements we''ve made since previous videos: turret upgrades, special effects, and environment changes.
</p>', 'Tower Defense Tutorials Part 6', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('td-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-moving-enemies-and-pathfinding','2014-10-12', 'The third video tutorial of a series which takes you through the process of building a tower defense game.', '

<p>
    If you''ve been following along with our <a href="/tag/td-video-series.html">video tutorial series</a>, your game should now have a map with the basic interaction of placing turrets.
    To get the core functionality of our game, we will be needing enemies to move across the map.
    They will also need to navigate around turrets on the way to their destination.
</p>

<p>
    This tutorial goes over how to move enemies on the grid we have created and how to use A* pathfinding to avoid obstacles.
    Pathfinding of this nature is something we have already implemented in a previous game (<a href="/category/nauticus.html">Nauticus Act III</a>), so we''re just going to reuse the component.
    If you are actually looking to implement pathfinding from scratch, we cover this in depth in a <a href="/a-star-pathfinding-tutorial.html">previous tutorial</a>.
</p>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/Q7ef6wLDfrE?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

<p>
    With enemies, we now really have the essence of a tower defense game in place.
    There are some obvious next steps here however... turrets still aren''t attacking and having a single enemy doesn''t make for a very interesting game.
    Our upcoming tutorials will show how to address these challenges.
</p>

<p>
    You can keep up with the latest as we progress by subscribing to our channel or following us on twitter.  
    <a href="https://www.youtube.com/channel/UCHcxGunEdEPlgq5JulJ2fYQ"><img src="/static/images/icons/youtube.png" /></a>
    <a href="https://twitter.com/Final_Parsec"><img src="/static/images/icons/twitter.png" /></a>    
</p>', 'Tower Defense Tutorials Part 3', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('pathfinding');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('td-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-no-gameobject-grid','2014-09-28', 'The first video tutorial of a series which takes you through the process of building a tower defense game.', '
<p>
    Over the next couple months, Final Parsec will be creating a tower defense style game.
    Follow along as we build from the ground up to a game intended for the web and Android devices.
</p>

<h3>Building a Grid Environment without GameObjects</h3>

<p>
    This tutorial will demonstrate how to create a grid without using Unity GameObjects.
    By eliminating the overhead of multiple GameObjects, we can increase performance.
    The grid we''re building here will be a vital piece of infrastructure as enemies will walk across it, turrets will be placed on it, and it will handle user interaction in various ways.
</p>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/auCv_U7Wd8Y?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Announcing the Tower Defense Tutorial Video Series!', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('map-generation');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('td-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('parallax-for-dummies','2015-03-15', 'An enlightening guide on how to create a simple parallax effect in Unity. Using parallax is a really cool way to breathe life into your games.', '
<p>
    Welcome to the enlightening guide on how to create a simple parallax effect in the Unity editor.
    A parallax effect is an apparent change in the direction of an object caused by a change in observational position that provides a new line of sight.
    In Unity, we''ll try and create this effect using the camera as the point of perspective that is changing.
    Basically, as the camera moves around our scene, we will make multiple images appear to be moving at different speeds.
    Luckily, this is an incredibly easy and impressive effect to implement in the Unity editor.
</p>

<p>
    <img src="/static/images/parallax_demo.gif" style="width: 90%;">
    <span class="caption"><a href="http://i.imgur.com/pxVijIt.gifv">imgur</a></span>
</p>

<p>
    First things first, we''re going to need a sweet environment to bring to life with our Unity skills.
    Being the thrifty game designers we are, let''s head to the internet.
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
	If the images don''t come in order, you will have to figure out which order they go yourself.
	open up each picture in windows photo viewer(or be hardcore and do it in unity) and piece together which one goes where, then name them accordingly with 01 being the closest.
	Take picture 01 and apply it to your plane 01.
	Set the plane''s position in your inspector at 0,0,0.
	Then adjust your camera to get a good view of it.
</p>

<img src="/static/images/parallax_planes.jpg" style="max-width: 90%;">

<p>
	Using parallax is a really cool way to breathe life into your games.
	It''s been used in hundreds of places.
	League of Legends and Guild Wars 2, for example, use parallax in their videos as a low cost way to animate cutscenes.
</p>

<h4>See It in Action in Aurora Tower Defense</h4>
<img src="/static/images/parallax_aurora_menu.gif" style="width: 90%;">

<p>
    For the source, check out the project on <a href="https://github.com/Final-Parsec/AuroraTD">Github</a>.
</p>', 'Parallax for Dummies', 0, 3);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-passing-data-and-menus','2014-11-30', 'The fifth video tutorial of a series which takes you through the process of building a tower defense game.', '
<p>
    This tutorial goes over how to pass data between scenes using the singleton pattern, something especially useful when a user is picking map types and difficulty in a separate menu scene.
    We also give an overview of building a menu system with Prezi-style transitions (panning and zooming camera with parallax effects).
</p>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/KYADPkNTEHM?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

<p>
    In addition to building the menu and passing state data around, learn how to display a loading screen between scenes.
    Without this, the game may appear to hang when a player starts from the main menu.
</p>', 'Tower Defense Tutorials Part 5', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('td-video-series');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('tower-defense-release','2014-12-22', 'Aurora Tower Defense has just been released for PC, Mac, and Android devices. Play for free in your browser now!', '
<p>
    Aurora Tower Defense has just been released for PC, Mac, and Android devices.
</p>

<p style=''font-weight: bold;''>
    Aurora TD costs $2.49 on Android, but you can play the full featured game for free online.
</p>
<p style=''font-weight: bold;''>
    Just head over to <a href="/category/tower-defense.html">the Aurora TD category</a> and play right in your web browser!
</p>

<p>
    You are an Inuit shaman sworn to protect Tomkin, the home of the spirits.
    Tonrar, the evil spirit, is attempting to bring darkness to the ice caps.
    You must repel his forces by building totems, magical defenses which are empowered by the elements.
    As the evil forces grow in strength and numbers, darkness will overtake the northern lights.
    Fight back by strategically placing totem poles with magical abilities!
    Invoke the power of the spirits!
    Salaksartok! 
</p>

<h3>Aurora TD is an isometric tower defense game involving strategy and quick wit.</h3>

<p>
    Watch our trailer below to get an idea of how the game works.
</p>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/Mq6VLoGR-gY?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Aurora TD Released on Web and Android Devices!', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('android');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('unity-animator-state-machine-tutorial','2014-08-17', 'Technical talk from Matt Bauer about Unity animator state machines in Nauticus Act III. Simplify Unity state machines into manageable sub-components.', '
I was having trouble finding examples on the internet on how to create complex animator state machines using Unity, so I came up with my own solution and made a tutorial on how I implemented it.

If you have any questions about this issue or others I have posted, leave us a comment on the Youtube video or check out our Sunday afternoon podcasts at <a href="http://twitch.tv/finalparsec">twitch.tv/finalparsec</a>.

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/xPw9bknBOwI?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'Unity Animator State Machine Tutorial', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('nauticus');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('unity-deploying-to-android','2014-09-21', 'Learn how to deploy an existing Unity game to your android device.', '
<p>
    In this tutorial, learn how to deploy your Unity game to an Android device.    
</p>


<h3>Install the Java Development Kit</h3>

<p>
    <a href="http://www.oracle.com/technetwork/java/javase/downloads/" target="_blank">Download the JDK from Oracle</a>
    <br>
    Install the JDK. Grab the <span style="font-weight: bold;">32-bit version</span>; I wasn''t able to get Unity to work with the 64-bit alternative.        
</p>

<p>    
    Include java''s <code>bin</code> directory in your PATH variable. 
    On my 64-bit Win8 install, the path was <code>"C:\Program Files (x86)\Java\jdk1.8.0_20\bin"</code>.
    Yours will likely be something similar.     
</p>

<p>
    <span class="caption">You should now be able to run "java" at the command line.</span>
    <img src="/static/images/unity_deploying_with_android_java_command_prompt.png">
</p>

<h3>Install the Android SDK</h3>

<p>
    <a href="http://developer.android.com/sdk" target="_blank">Download the Android SDK</a>
    <br>
    Unpack the SDK. 
    Some of the names in this bundle can be quite long. 
    So if you''re on Windows, be careful about limitations on total path lengths.
    I got around this by unpacking to <code>"C:\A\"</code>, a shorter than usual path.
</p>

<p>
    Navigate to that directory, run the <span style="font-weight: bold;">SDK Manager</span> and make sure you''ve got the following installed:
    
    <ul>
        <li>An Android platform (2.3 or newer)</li>
        <li>Platform tools</li>
        <li>USB drivers</li>
    </ul>
</p>


<p>
    <img src="/static/images/unity_deploying_with_android_android_sdk_manager.png">
    <span class="caption">Here''s what I''ve got installed.</span>
</p>

<h3>Setup the Device</h3>

<p>
    To allow unsigned Android application packages (APKs) on your device, you''ll need to modify some settings. 
    Go to <code>Settings -> Developer options</code>.
    On Android 4.2 (Jelly Bean) and higher, these options have been hidden and adding them to the menu requires extra steps:
     
     <ol>
        <li>Go to <code>Settings -> About Phone</code>.</li>
        <li>Find <code>Build Number</code> and tap it 7 times.</li>
        <li>You should see a message confirming you as a developer.</li>
     </ol>
</p>

<p>
     Once you get into the developer options, enable <code>USB Debugging</code> and <code>Allow Mock Locations</code>.
     <img src="/static/images/unity_deploying_with_android_developer_options.png">
</p>

<p>
    Plug in your device over USB, and you should see a message like "USB debugging connected".
</p>

<p style="font-size: smaller;">
    <span style="font:smaller;"><span style="font-weight: bold;">Heads up:</span>
    some devices will need additional manufacturer specific drivers. 
    As an example, I needed <a href="http://developer.android.com/sdk/win-usb.html" target="_blank">these</a> for my Nexus 5. 
</p>

<h3>Build and Run from Unity</h3>

<p>
    Start Unity. Go to <code>Edit -> Preferences -> External Tools</code>.
    Point the <code>Android SDK Location</code> to the appropriate location (<code>"C:\A\adt-bundle-windows-x86_64-20140702\sdk"</code> in my case). 
</p>

<p>
    Go to <code>File -> Build Settings</code>.
    Select <code>Android</code> and click the <code>Player Settings</code> button.
    Set everything up the way you''d like. The <span style="font-weight: bold;">Bundle Identifer</span> setting is required and should follow <a href="http://en.wikipedia.org/wiki/Java_package#Package_naming_conventions" target="_blank">conventions</a> (<code>com.finalparsec.towerdefense</code> for example).
</p>

<p>
    Select <code>Build And Run</code>, select a location for your .apk, and the game should start up on your device.
</p>

<p>
    Continue the discussion with us: <a href="https://twitter.com/Final_Parsec" target="_blank">@Final_Parsec</a>
</p>', 'Deploying Unity Games to Android', 0, 1);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('tower-defense');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('android');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('unity-health-bars-with-gui-textures','2014-09-14', 'Technical talk from Matt Bauer about Unity creating scaling health bars in Nauticus Act III, the RTS style conclusion to Nauticus.', '
In this tutorial, I take you through the steps to create health bars in Unity. They scale in size based on the camera''s position, and they will also change color from green to red. 

We will build them using Unity''s GUI textures which are ideal for this type of application. While we''re applying them in an RTS style game with an overhead camera, you should be able to implement something similar in your game no matter the genre.

If you have any questions about this tutorial or others I have posted, leave us a comment on the Youtube video.

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/qJ_NgSdkfQ0?rel=0" frameborder="0" allowfullscreen></iframe>
</div>
', 'Creating Health Bars using Unity GUI Textures', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('nauticus');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert into post (slug, publish_date, summary, content, title, is_draft, author_id) values('a-star-visualization','2015-01-13', 'See A* pathfinding visualized in your browser.', '
Here is a small program that I made for a parallel class project during my first semester of graduate school. At the end of the class project, I decided to continue work on it in order to improve path quality, be more user friendly, and introduce a tracing option.

The program visualizes Sequential A\* and Parallel New Bidirectional A\* (PNBA\*).<br>
The biggest achievement of this program is the implementation of the PNBA\* algorithm as described in <a href="http://homepages.dcc.ufmg.br/~chaimo/public/ENIA11.pdf">PNBA*: A Parallel Bidirectional Heuristic Search Algorithm</a>.

[See the live demo in your browser here!](/category/unity-masters.html)

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/kln3dZ9WcCg?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/CgUIVrIIaPY?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

<div class="video-container">
    <iframe width="560" height="315" src="//www.youtube-nocookie.com/embed/Gf6W26AQG-o?rel=0" frameborder="0" allowfullscreen></iframe>
</div>', 'A* Pathfinding Visualization', 0, 2);

set @last_post_id  = LAST_INSERT_ID();

insert ignore into tag(name) values('unity');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('unity-masters');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('map-generation');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('pathfinding');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

insert ignore into tag(name) values('tutorial');
set @tag_id  = LAST_INSERT_ID();
insert ignore into post_tag(post_id, tag_id) values(@last_post_id, @tag_id);

