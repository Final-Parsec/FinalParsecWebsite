#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals


AUTHOR = u'Final Parsec'
PLUGIN_PATHS = ['plugins']
PLUGINS = ['related_posts']
SITENAME = u'Final Parsec'
SITEURL = ''
THEME = 'themes/final_parsec_the_reckoning'

READERS = {'html': None}

TIMEZONE = 'America/Chicago'

DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None

TEMPLATE_PAGES = {
    'static_pages/about.html': 'static_pages/about.html'
}

# Blogroll
# LINKS =  (('Pelican', 'http://getpelican.com/'),
#           ('Python.org', 'http://python.org/'),
#           ('Jinja2', 'http://jinja.pocoo.org/'),
#           ('You can modify those links in your config file', '#'),)

# Social widget
SOCIAL = (('@Final_Parsec', 'https://twitter.com/Final_Parsec'),
          ('Tutorials & Streams', 'https://www.youtube.com/channel/UCHcxGunEdEPlgq5JulJ2fYQ'))

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

MENUITEMS = [
    ('About', '/static_pages/about.html')
]