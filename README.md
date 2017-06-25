# less-file
Emac command to run less in an ansi-term on a pathname, including tramp pathnames.

We rearly need or want's a pager in Emacs.  But, I do because I often need to look into vast log files that
are easily accesible via tramp on some remote server.

So given a file name (tramp or not) this will create a ansi-term window running less on the remote machine.

To kill the ansi term window try: C-x k, just like other buffers.

Lots of improvements are possible, but who knows what the future holds.

My init file loads this as so:

```
(use-package less-file
   :ensure
   :commands less-file
   :quelpa (less-file :fetcher github :repo "bhyde/less-file"))
```

