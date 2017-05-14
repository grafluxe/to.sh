# to.sh

Change to your favorite and most visited directories quickly and easily. This project was created to help expedite moving between directories (via any Bash CLI).

Once [installed](#install), a new command will be available in your CLI. This new command, defined as `to`, allows you to tag directories for easy access.

## Definitions

- Path: The directory path to change directories too.
- Tag: The name assigned to represent to path.
- Route: The combination of a tag + path.

## Usage

```
to [<tag> | <options>]
  Enter (cd) into a directory that you want add to the route list and run the 'to --add'
  command. Once added, run 'to <tag>' to 'cd' into that directory from wherever you are.
  The 'tag' param matches the directory name you added to the route list (with spaces
  converted to underscores). To update the tag name or see available routes, see the
  options below.
```

## Options

```
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
```

## Examples

Add a path:

```
cd path/to/myapp  #change directories to a path I visit often
to --add          #add a new route
cd ~              #visit some other directory
to --list         #see all available routes
to myapp          #easily go to the 'myapp' directory
```

Remove a path:

```
cd path/to/myapp  #change directories to a path that has been tagged
to --remove -v    #remove the route (with the optional verbose output)
```

Rename a path:

```
cd path/to/myapp  #change directories to a path that has been tagged
to --retag app    #rename the tag from 'myapp' to 'app'
cd ~              #visit some other directory
to app            #easily go to the 'myapp' directory
```

## Notes

- Bash's *tab to autocomplete* feature is supported across all options and tags.
  - Adding a tag will trigger an update to include your new tag in the completion index.
- Retagging a route (updating its tag name) does not alter your directory. It only updates the tag name used by this tool.
- While this project has been tested using Bash, it should work on similar shells (e.g. sh, zsh).
- I save to `~/.profile` in order to allow this script to work across other shells. If you have a `~/.bash_profile` loading, you can source `~/.profile` from there (or move the newly added to.sh condition from `~/.profile` to your profile).

## Install

This project installs to your $HOME directory.

### Via CURL

```
curl -Lko to-sh.zip https://github.com/Grafluxe/to.sh/archive/v1.0.0.zip && \
unzip to-sh.zip && \
sh to.sh-1.0.0/to-setup.sh && \
source ~/.profile && \
echo Cleaning up... && \
rm -fr to.sh-1.0.0 && \
rm to-sh.zip && \
echo Done!
```

### Via zip file

- Download the [zip file](https://github.com/Grafluxe/to.sh/archive/v1.0.0.zip).
- Unzip it.
- Run `sh to-setup.sh`.
- Delete the zip and project files.
  - Since the setup script copies all the needed files to your $HOME directory, every file you unzipped can be deleted.

### Via Git

You can clone this project, run `sh to-setup.sh`, and then delete everything you cloned since all the needed files are moved to your $HOME directory. If you'd like to add to this project, fork it and send over a PR.

## Uninstall

You can simply uninstall this tool by running the following command:

```
rm -rf ~/.to && unset -f to && complete -r to
```

Doing so will delete all files associated with to.sh along with your tags.

To be thorough, open your `~/.profile` and delete the following:

```
if [ -f "/user/path/.to/to.sh" ]; then
  source "/user/path/.to/to.sh";
  source "/user/path/.to/to-completion.sh";
fi
```

## License

Copyright (c) 2017 Leandro Silva (http://grafluxe.com)

Released under the MIT License.

See LICENSE.md for entire terms.
