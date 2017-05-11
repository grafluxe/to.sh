# to.sh

**STILL IN BETA**

More details coming soon. For now, see the scripts help page:

```
    to.sh
    =====

    DESCRIPTION
      Change to your favorite and most visited directories quickly and easily. This project was
      created to help expedite moving between directories (via any bash enabled CLI).

    USAGE
      to [<route-name> | <options>]
        'cd' into a directory that you want add to the route list and run the 'to --add' command.
        Once added, run 'to <name>' to 'cd' into that directory from wherever you are. The 'name'
        param matches the directory name you added to the route list. To see all availabe routes,
        run the 'to --list' command.

        Sample: cd my/path/myapp; to --add; cd ~; to myapp

    OPTIONS
      --add [<-v>]
        Adds your current working directory to the route list (with a name matching your directory
        name). Use the optional '-v' parameter for a more verbose message.

      --rm [<-v>]
        Removes your current working directory from the route list (if it exists). Use the
        optional '-v' parameter for a more verbose message.

      --list [<-v>]
        Lists your available routes. Use the optional '-v' parameter for a more verbose message.

      --help
        Opens the help page.

      --version
        Outputs the version you're currently using.

    INFO
      Project home
        http://github.com/Grafluxe/to.sh
        Additional docs can be in the README.

      Author
        Leandro Silva

      Copywrite
        (c) 2017 Leandro Silva (http://grafluxe.com)

      License
        MIT
```

## License

Copyright (c) 2017 Leandro Silva (http://grafluxe.com)

Released under the MIT License.

See LICENSE.md for entire terms.
