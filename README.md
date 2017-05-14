# to.sh

More details coming soon. For now, see the scripts help page:

```
  to.sh
  =====

  DESCRIPTION
    Change to your favorite and most visited directories quickly and easily. This project was
    created to help expedite moving between directories (via any bash enabled CLI).

  USAGE
    to [<tag> | <options>]
      'cd' into a directory that you want add to the route list and run the 'to --add' command.
      Once added, run 'to <tag>' to 'cd' into that directory from wherever you are. The 'tag'
      param matches the directory name you added to the route list (with spaces converted to
      underscores). To update the tag name or see available routes, see use the options below.

      Example 1: cd path/to/myapp; to --add; cd ~; to myapp;
      Example 2: cd "path/to/my app"; to --add; cd ~; to my_app;

  OPTIONS
    --add [<-v>]
      Adds your current working directory to the route list (with a tag matching your directory
      name). Use the optional '-v' parameter for a more verbose message.

    --remove [<-v>]
      Removes your current working directory from the route list (if it exists). Use the
      optional '-v' parameter for a more verbose message.

    --list [<-v>]
      Lists your available routes. Use the optional '-v' parameter for a more verbose message.

    --retag <tag>
      Updates your tag name.

    --help
      Opens the help page.

    --version
      Outputs the version you're currently using.

  INFO
    Project home
      http://github.com/Grafluxe/to.sh
      Additional docs can be found in the README.

    Author
      Leandro Silva

    Copyright
      (c) 2017 Leandro Silva (http://grafluxe.com)

    License
      MIT
```

## License

Copyright (c) 2017 Leandro Silva (http://grafluxe.com)

Released under the MIT License.

See LICENSE.md for entire terms.
