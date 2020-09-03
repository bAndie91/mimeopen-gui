> Author: myrdd <dev@256k.de>
> Date: Apr 27, 2018

I've been trying to create a shell script which conditionally opens a file with a specific program and open a selection dialog else, like this:

```bash
#/usr/bin/env bash
{ : put the condition here; true } && some-program "$1" || mimeopen-gui "$1"
```

In my case I wanted to define **default programs depending on the invoker**. I've been testing something like this:

```bash
{ ps j "$$" | grep -Eo "^invoker-program-name" } && ... || ...
```

Sadly, this did not work in my case. I've been using LibreOffice as the invoker (using Writer's «_Edit with external tool_» option). The parent process of the shell script (i.e., `$$`) was `kdeinit5`, which does not help. (I'm using KDE Plasma 5.)

(the discussion started [here](https://github.com/bAndie91/mimeopen-gui/commit/6f30a8962ee4ce73c9870a3baa0961e46b2e6f33#commitcomment-28044312) :wink:)

citing @bAndie91:

> "default program depending on the invoker" – […] indeed it'd be a non-standard way, since Freedesktop standards define the "opener" mechanism taken only the file's name and mime-type - which is about to be opened - as input.

yes, that's why I tried to work around the standard ;)

---

> Author: bAndie91 (Owner)
> Date: Mar 10, 2020

hi @myrdd , getting back to your query, I can suggest 2 ways to implement your logic in a more-or-less modular way, by not building in custom logic in mimeopen-gui:

1. environment of the program which performs "mime open" logic (ie. invoking mimeopen-gui) should make mime libs find the desired config files with the desired config about the assigned command. in practice it'd look like you start your program (liberoffice) from a wrapper (script) which copies your existing mime config files (`~/.local/share/applications/defaults.list`) to an app-specific path and sets `$XDG_DATA_HOME` to it. and sylink everything back to the original xdg data home path. you also have to pay attention on possibly newly created folders in the app-specific path: a virtual filesystem (fuse) would do the job, but even I (as a fuse-advocat) consider it a bit over-kill. one may leverage the `$XDG_DATA_DIRS` specs which prescribes multiple dirs, however I'm not sure about the application support on its regard and what happens when an app is not about to find its config files but to create them: does it take the first path in the list? then we can not separate the xdg data dir which is first in preference order and the xdg data dir which we want the new files to be placed in. or maybe it takes the first writable one? IDK

2. the more viable option. add a mime application which does nothing else but looks up it's ancestor processes and makes decision about the appropriate opener application based on one or more ancestor processes. and of course assign this lookup app to the desired mime types.

you may close this issue if you're satisfied.

