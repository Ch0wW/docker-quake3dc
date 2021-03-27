# Quake3 Dreamcast Server Docker
A docker image that creates a Ready-to-Use Quake 3 Arena server for Dreamcast (or 1.16n users with the Dreamcast Mappack)

### Why this docker ?

The Dreamcast still lives, and Quake 3 Arena is definitely one of the easiest game to replay online. 
However, creating a server on modern systems have been known as being really problematic, and tutorials aren't updated for that purpose. 

Besides, the only server package that is helpful has been made by Fallout, but featured junk that is unnecessary for a server. I decided to make a Docker image based on his creation that greatly simplifies it.

### Features
* Creates a Quake 3 Arena Server for Dreamcast online services.
* Doesn't need any optional file to run it.
* Includes Presets for all gamemodes (FFA, TDM, Duel, CTF).
* Includes some security fixes.
* Includes a Docker-Compose file.

### Quick installation
1) Download the image provided by Docker HUB. **By default, it will run FFA on DC_MAP01** :
```docker
docker run -it --rm -d --name q3dc-ffa -p 27960:27960 -p 27960:27960/udp ch0ww/q3dc
```
**DO NOT FORGET TO OPEN PORT 27960 (UDP) IN ORDER TO BE JOINABLE !**

### Manual installation
1) Download or git clone the project.

2) Build locally the image :
```docker
 docker build -t q3dc . 
```` 
3) Run the image. **By default, it will run FFA on DC_MAP02** :
```docker
docker run -it --rm -d \
 --name q3dc-ffa \
 -p 27960:27960 \
 -p 27960:27960/udp \
 q3dc
```
### Customisation
  
**IT IS PREFERABLE TO ADD A PRESET BEFORE ADDING OTHER COMMANDS.**

**Presets :**
* +exec "config/ffa.cfg" for Free-For-All
* +exec "config/tdm.cfg" for Team Deathmatch
* +exec "config/ctf.cfg" for Capture the Flag
* +exec "config/duel.cfg" for Tourney (1 vs 1)

Any command or CVar ou would use originally needs to be placed **AFTER** the image name. Do not forget to do it that way :
> +set [cvar] [value]

**Commands :**
* sv_hostname "Dreamcast Server"
* fraglimit "10"
* timelimit "0"
* pointlimit "5"

If you desire to change the port, add
```+set net_port <PORT>``` in the commandline parameter, and modify the Docker inbound/outbound port **in order to be recognized on the Masterserver**.

Example : I'll put the same TDM server above but using port 27961 instead:
```sh
docker run -it --rm -d \
    --name q3dc-tdm \
    -p 27961:27961 \
    -p 27961:27961/udp \
    ch0ww/q3dc \
    +set net_port 27961 \
    +exec config/tdm.cfg \
    +map dc_map02
    +set sv_hostname "Best DC Server" \
    +set fraglimit 50 \
    +set timelimit 20
 ```

 ### Additional infos
 * The Quake 3 packages that are used can be found [here](http://dl.baseq.fr/quake/q3dc/).
 * The **18 first characters of the server hostname are visible** on your Dreamcast.
 * We **highly** recommend you using Docker-compose to run this package, if you want to modify the config files.