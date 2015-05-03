status: draft
title: Building a Leaderboard System 
Date: 2015-03-29
Category: Tower Defense
Tags: web-dev, tutorial, apache, mysql, tower-defense, unity
Slug: building-a-leaderboard-system
Author: Baer
Summary: In this post, we discuss building an online application capable of tracking score boards (leaderboards) for a number of games and categories. 

Our ultimate goal is to create a system which can track a variety of leaderboards for our games here at Final Parsec.
The general idea is that after a player wins a game, they'll be given a numeric score which can be used to rank all players globally.
We target a variety of platforms with our games and almost every single one will need to submit and view scores.
It's likely we will want to display the leaderboards on our website too at some point.
Pretty much everything is going to be doing this same thing.
Maybe we should build an API to handle it.

### Designing the API

There's not much to this. The system tracks a collection of **scores**.
 
Each score has the following attributes:
* Player's Name
* A Numeric Score
* Assignment to a Leaderboard




<pre class='apply-line-numbers'><code class='hljs apache'>create table if not exists scores
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
We do this despite the fact that our site has a large amount of somewhat dynamic content (for instance, the blog you're reading right now).
This is accomplished by using a static site generator ([Pelican](http://docs.getpelican.com/)) and letting Apache serve the output straight off the file system.
The primary benefits include:
<ul class=default>
    <li>Tracking changes and entire history of the site is as easy as keeping it under version control.</li> 
    <li>No server side scripting or processing to speak of.</li>
    <li>We don't need to query a database.</li>
</ul>
These last two help cut down on the response time when a user requests content which is vitally important.

One side effect of taking this approach is that browsers can pretty aggressively cache the resources that compose your site.
This can either be a really good or really bad thing depending on the nature of your site.
Browsers caching your content can result in very quick render times, but users may be looking at stale content.
As I mention earlier in the article, our site changes frequently as we update it with new posts and such.
This means a user seeing stale content is a problem for us.

There are several ways you can tell a browser to avoid caching (or at least check for an updated version) primarily through the use of HTTP headers.
The header we're going to be interested in is the **cache-control** header.
A few others headers exist to manipulate caching behavior. If you want to dive into more information, [take a look at this blog post](http://www.mobify.com/blog/beginners-guide-to-http-cache-headers/).

We can use the Apache module [mod_expires](http://httpd.apache.org/docs/2.2/mod/mod_expires.html) to manipulate this header.

Prior to enabling this module, you'll want to add rules to your virtual host file (you can also put this configuration information in **.htaccess**).
Our rules allow clients to cache content for 1 month with the exception of **html** files.
These expire immediately requiring the browser to check with our server before using a cached version of the content.
Using this strategy, we get the benefits of caching where it matters (larger files like images and frequently requested files like CSS) while getting the guarantee users will always see fresh content.

<pre class='apply-line-numbers'><code class='hljs apache'>&lt;IfModule mod_expires.c&gt;
    ExpiresActive on
    ExpiresDefault          "access plus 1 month"

    ExpiresByType text/html "access plus 0 seconds"
&lt;/IfModule&gt;
</code></pre>

Once you've modified your configuration, enable the mod_expires module.
<pre class='apply-line-numbers'><code class='hljs bash'></code>sudo a2enmod expires</pre>

Then restart apache to ensure your changes take effect.
<pre class='apply-line-numbers'><code class='hljs bash'></code>sudo service apache2 restart</pre>