#!markdown vim: ft=markdown:nowrap:sw=2:ts=2:cc=90
`CONFLICTS`
if you actually find one, email me at osirisgothra@hotmail.com!

`ABOUT`
This file covers the possibly out-of-date sx- files

`TEMPLATE HEADER THAT APPLIES TO ALL`
>>>
>>>	ABOUT
>>>
>>>    sx-*
>>>    Simple Shim for xmlstarlet(1) subcommands
>>>    mini/eso/ubin-local
>>>    Esoteric Project Files , Etc
>>>	   Includes all xmlstarlets:
>>>		sx-c14n  sx-el	 sx-fo	sx-p2x	sx-sel	sx-unesc
>>>		sx-ed	 sx-esc  sx-ls	sx-pyx	sx-tr	sx-val
>>>
>>>    Copyright (C) 1995-2018 Gabriel Thomas Sharp
>>>
>>>    Written by Gabriel T. Sharp <21shariria@gmail.com>
>>>    Latest versions of this and all of my projects can be
>>>    obtained by visiting the repository: 
>>>
>>>    <https://github.com/osirisgothra>
>>>
>>>    Because of the global availability of github at this point, hosting
>>>    any additional servers for public use no longer serves a purpose. All
>>>    content is available 24/7 through github. (Thanks to GITHUB!).
>>>
>>>    This program is free software; you can redistribute it and/or modify
>>>    it under the terms of the GNU General Public License as published by
>>>    the Free Software Foundation; either version 2 of the License, or
>>>    (at your option) any later version.
>>>
>>>    This program is distributed in the hope that it will be useful,
>>>    but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>    GNU General Public License for more details.
>>>
>>>    You should have received a copy of the GNU General Public License along
>>>    with this program; if not, write to the Free Software Foundation, Inc.,
>>>    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>>
>>> HISTORY
>>>
>>>	 Fri Nov 15 12:45:57 EST 2019
>>>            osirisgothra@ initially created this file
>>>            with the original name, sx-val
>>>
>>> FAQ
>>> 	WHAT IS IT FOR?
>>>			provides seamless command line usage (for your hands' sake) of the
>>>			awfully long xmlstarlet + command prefix. In all, most are saved by at
>>>			least, the first 9 characters. Working class shell users will appriciate
>>>			this script, I hope. 
>>>		WHY DO WE NEED IT
>>>			To save wear and tear on shell admins' hands
>>>		THE NAME IS SHORT BUT COULDNT IT HAVE BEEN SHORTER
>>>			You could be right but the command had to be at least the subcommand of xmlstarlet
>>>			and since many unix programs already have those names, they had to be prefixxed
>>>			with sx- (instead of xs, which is taken as well!). The two character+dash guarentees
>>>			up to 98% that there will be no conflicts -- report them if they are.
>>>			Right away, we can see that subcommands like 'ls' and 'ed' would definitely fail.
>>>			The beauty of the shim miracle file is, that you can simply rename the files to
>>>			something else and all will be well, you should rename plus change the hard reference
>>>			inside*
>>>    *HARD REFERENCE, but why not automatic?
>>>			True renaming would be easier if it was not hardcoded. But this is to deter from 
>>>			renaming that could soon become a security nightmare. People will have to actually
>>>			have a good reason to rename them and will think twice before having to also change
>>>			the internal constant as well. (Plus it ensures that if any updates happen, they will
>>>			be going to the right place instead of hunting them down, at least until you rename them!).
>>>	WHY THIS FILE?
>>>			This is the only file header that is updated every time. So please read this one for any
>>>			Updates. I used markdown to make it stand out in the esoteric collection, thats the only reason.
>>> 
