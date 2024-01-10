# linux-dotfiles

This repos is here to back up dotfiles.

## Add new files

To add new files to the backup, edit the dotfiles.yml file and add your file in the same style that the other files were added.

The folders are organized such that they describe the directory in which the dotfiles are stored (e.g. home, ssh, config)

## Deploy files

By running `ansible-playbook dotfiles.yml` symlinks are established (while backing up the existing dotfiles) from the repos to the respective directories.
