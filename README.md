# Quake3 Dreamcast Server Docker
A docker image that creates a Ready-to-Use Quake 3 Arena server for Dreamcast (or 1.16n users with the Dreamcast Mappack)

### Why this docker ?

The Dreamcast still lives, and Quake 3 Arena is definitely the easiest game to replay online. However, creating a server with the existing, and outdated tutorials around the web isn't, and lead to problems too since it uses an outdated version of the game. Besides, the server package made by Fallout, despite good, featured junk that is unnecessary for a server. I decided to make a Docker image based on his creation that simplifies everything instead.

### Features
* Creates a Quake 3 Arena Server for Dreamcast online services.
* Doesn't need any optional file to run it.
* Includes Presets for all gamemodes (FFA, TDM, Duel, CTF).
* Includes some security fixes.

### Quick installation
1) Download the image provided by Docker HUB. **By default, it will run FFA on DC_MAP02** :
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
docker run -it --rm -d --name q3dc-ffa -p 27960:27960 -p 27960:27960/udp q3dc
```
### Customisation
  
**IT IS PREFERABLE TO ADD A PRESET BEFORE ADDING OTHER COMMANDS.**

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
```docker
 docker run -it --rm -d --name q3dc-tdm -p 27960:27960 -p 27960:27960/udp ch0ww/q3dc +exec tdm.cfg +set sv_hostname "Best DC Server" +set fraglimit 50 +set timelimit 20
 ```

### Running several servers

You'll need to add 
```+set net_port <PORT>``` aswell as modifying the Docker inbound/outbound port in order to be seen to the Masterserver.

Example : I'll put the same TDM server above but using port 27961 instead:
```docker
 docker run -it --rm -d --name q3dc-tdm -p 27961:27961 -p 27961:27961/udp ch0ww/q3dc +exec tdm.cfg +set net_port 27961 +set sv_hostname "Best DC Server" +set fraglimit 50 +set timelimit 20
 ```


 ### Additional infos
 * The Quake 3 packages that is used can be found [here](http://dl.baseq.fr/quake/q3dc/).
 * The **18 first characters of the server hostname are visible** on your Dreamcast.
 * If you want to modify the maplist, you will need to compile the docker manually, or to create a docker symlink to 
 ```/server/q3a/baseq3/config``` , aswell as execing the file in 
 ```config/**configfile.cfg**```.