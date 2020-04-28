# Quake3 Dreamcast Server Docker
A docker image that creates a Ready-to-Use Quake 3 Arena server for Dreamcast (or 1.16n users with the Dreamcast Mappack)

### Why this docker ?

The Dreamcast still lives, and Quake 3 Arena is definitely the easiest game to revive for online play. However, creating a server with the existing, and outdated tutorials are quite painful. Besides, one pack I've noticed featured way too many junk that wasted space. I decided to make a Docker image based on his creation that simplifies everything, for a very quick and painless online experience.

### Features
* Creates a Quake 3 Arena Server for Dreamcast online services.
* Doesn't need any optional file to run it.
* Includes Presets for all gamemodes (FFA, TDM, Duel, CTF).
* Includes some security fixes.

### Quick installation
1) Download the image provided by Docker HUB. **By default, it will run FFA on DC_MAP02** :
> docker run -it --rm -d --name q3dc-ffa -p 27960:27960 -p 27960:27960/udp ch0ww/q3dc

### Manual installation
1) Download or git clone the project.

2) Build locally the image :
> docker build -t q3dc . 

3) Run the image. **By default, it will run FFA on DC_MAP02** :
> docker run -it --rm -d --name q3dc-ffa -p 27960:27960 -p 27960:27960/udp q3dc

### Customisation
  
**YOU WILL NEED TO ADD A PRESET BEFORE ADDING OTHER COMMANDS**

**Presets :**
* +exec "ffa.cfg" 
* +exec "tdm.cfg"
* +exec "ctf.cfg"
* +exec "duel.cfg"

Any command or CVar ou would use originally needs to be placed **AFTER** the image name. Do not forget to do it that way :
> +set [cvar] [value]

**Commands :**
* sv_hostname "Dreamcast Server"
* fraglimit "10"
* timelimit "0"
* pointlimit "5"

Example : I want to run a TDM server called "Best DC Server" with a timelimit of 20 minutes and a fraglimit of 50 :
> docker run -it --rm -d --name q3dc-tdm -p 27960:27960 -p 27960:27960/udp ch0ww/q3dc +exec tdm.cfg +set sv_hostname "Best DC Server" +set fraglimit 50 +set timelimit 20