# Cheatsheet

run these commands from inside the folder that contains the .flake

## update packages 

```
nix flake update
```

## Apply flake to system (after updates or changing config)

```
sudo nixos-rebuild switch --impure --flake .
```

### if the host name of the machine doesn't match the host name defined in the flake then you can run it this way to explicitly use a hostname

```
sudo nixos-rebuild switch --impure --flake .#HOST_NAME
```

#### Example

```
sudo nixos-rebuild switch --impure --flake .#neo
```

## Install tips

### flag to disable root when installing
```
--no-root-passwd
```

### disable root password and login 
```
passwd -dl root
```

## Cleanup Old Packages

### Remove ALL Old Generations
```
sudo nix-collect-garbage -d
```
### Remove packages older than 30 days
```
sudo nix-collect-garbage --delete-older-than {{30d}}
```

### List Old Generations
```
nix-env --list-generations
```
