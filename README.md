# Quake3 Dreamcast Server Docker

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P27UZHV)

This project generates a Docker image that automates setting up a Quake 3 Arena server, made specifically for the Sega Dreamcast. This also is compatible with the Quake 3 Arena 1.16n clients, as long as you own the Quake 3 DC Mappack project.  

---------------------

# Requirements
- docker
- docker-compose

### Why this docker ?

The Dreamcast still lives, and Quake 3 Arena is definitely one of the easiest game to replay online. 
However, creating a server on modern systems have been known as being really problematic, and tutorials aren't updated for that purpose. 

I decided to make a Docker image that greatly simplifies it, as well as making it as clean and modulable as possible.

### Features
* Creates a Quake 3 Arena Server for Sega Dreamcast (and Quake 1.16n) in no time.
* Includes Presets for all gamemodes (FFA, TDM, Duel, CTF).
* Includes a Docker-Compose file.

### Installation/Usage

Simply edit the `docker-compose.yml` to add or modify anything you require.

If you need to change the port of your server, change all occurences of `27960` (= in `ports` and in the `command` sections) to the desired port of your choice.

```yml
version: '3.5'

services:
  quake3dc:
    build:
      context: .
      dockerfile: Dockerfile
    user: "1000:1000" # <- Change this to your UID:GID
    restart: always
    ports: 
      - 27960:27960
      - 27960:27960/udp
    volumes:
      - ./config/baseq3:/server/q3a/baseq3
      - ./.q3a://.q3a
    command: 
      - +set net_port 27960 +exec presets/ffa.cfg +map dc_map02 +set sv_hostname "Q3A DC - FFA SERVER" +set fraglimit 30 +set timelimit 10
    security_opt:
      - no-new-privileges:true
```

Once done, just execute `docker-compose up` to make sure everything works as intended, and you should be good to go. Change also the `user` token so that it is checking with the user and group running the container, to avoid upload issues or potential permission problems.

If you need to rebuild the image (for instance for testing or to add a few additional things), just type `docker-compose build` and you should be good to go.

### Modifying your server configuration

Simply go to the `config/baseq3` folder, and modify the required data you wish.

#### Presets
Server presets are located in the `presets` subfolder of `config/baseq3`.
* `+exec "presets/ffa.cfg"` for Free-For-All
* `+exec "presets/tdm.cfg"` for Team Deathmatch
* `+exec "presets/ctf.cfg"` for Capture the Flag
* `+exec "presets/duel.cfg"` for Tourney (1 vs 1)

**IT IS PREFERABLE TO ADD THE SERVER PRESET BEFORE ADDING OTHER COMMANDS.**

#### CVARs
Any command or CVar ou would use originally needs to be placed **AFTER** the preset config. Its syntax is the following :
> +set [cvar] [value]

Common commands are the following:
* `+set sv_hostname "Dreamcast Server"` to change the server's hostname (*the 18 first characters are only visible on your Dreamcast*)
* `+set fraglimit "10"` to change the frag limit.
* `+set timelimit "0"` to change the time limit before the next map loads.
* `+set pointlimit "5"` to change the capture limit (for Capture the Flag only)

#### BOTs 

This repository contains optional botfiles, in form of PK3s. By default, they are not enabled.

Simply move all of the pk3 files from `install/bots` to `config/baseq3`, and enable them with `+set bot_enable 1`. See `config/baseq3/presets/common.cfg` to see all bot commands.

#### Custom mappacks
Be aware that support for custom mappacks requires pk3 overwrites that is outside the scope of the project! More info later, once the files from the Quake 3 DC Mappack are available.

#### Quake 1.16n only support
Since this project is primarly made for Quake 3 Arena Dreamcast users, support for Quake 1.16n exists. All you need to do is replace the entirety of the pk3 with the ones from your Quake 3 installation. Add volumes to the modfolder if you plan to use some.