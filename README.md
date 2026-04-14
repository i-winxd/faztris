# Faztris

## Technical description

This repository holds the modified code
that is used to implement Faztris.

https://gamebanana.com/mods/667034

## Repository Format

Only store components that were modified.
This helps log diffs, and works well with **SOME** importing scripts.

Use the scripts in `_scripts` to export
objects, sounds, and sprites, since they
are too specific to make outside of UTMT.

For code, when you modify or add any
code files, please put the entire modified
file inside `./Code`. This helps me track
which files are modified, and work perfectly
when you use that script that imports all
GML files from a folder. Note how UTMT strips
comments and arg variable names after you
click away - here's the chance to keep the comments!

For sprites and objects, look at what's in
there to understand the format.

## TODOs

Make this thing work in the extras menu

## Non-technical description

Use the gamebanana link for the data.win download. I might add a release later.

Quite the familiar stacker but in Frickbear's 3

**FAZTRIS in Frickbear's 3**  
  
You know the drill. Stack blocks, clear lines, get tokens. Get bonus tokens for performing T-spins. And so on. **Yes, we have T-spins.** I had a pretty long tetrio brainrot episode and that's why this mod is here, and I've put in every effort possible to make sure it plays exactly how you think it will play. The rotation system is (hopefully) exactly as guidelines say it should be, including kicks, and spin detections should work.  
  
**Installation**  
  
THIS IS A MODIFICATION TO VERSION 1.1.4  
  
If you have a different version, I still think this will work but probably just unpack something at this version.  
  
If the base game updates, I may have to update this mod.  
  
If you have an existing Frickbear 3’s installation, replace the data.win file, which is in the same folder as your executable, with the one I have here.  
Sorry, I don’t have an xdelta file.  
Back the existing data.winup, and your save data as well! Anything could happen! At least your save file is human readable, so you’ll probably know how to fix it if it gets corrupted, but it really shouldn’t.  
Your save files are located here: C:\\Users\\%USERNAME%\\AppData\\Local\\Frickbears3  
  
**Controlscheme**  
  
You can change this in the game settings. They update immediately, even if you are in game. Avoid choosing controls that conflict with the camera or doors.  
  
IJKL, J=move left, L=move right, I=hard drop, K=soft drop. B to hold. If you've played that battle royale game on the Nintendo Switch, the control scheme should reflect that. LEFT ARROW / RIGHT ARROW to rotate CCW or CW, UP ARROW to rotate 180.  
  
**Handling and rotation system**  

*   SRS, All-mini (Bonuses for T-spins, spins that don't involve T pieces don't award bonus tokens itself but contribute to B2B).
*   The combo bonus works like tetr.io.
*   Handling options are set to the default of Tetr.io (DAS, ARR, etc.).
*   ARE is 0. No delay when clearing a line.
*   7-bag

  
  
**Known issues**  
  

*   You cannot pause this minigame.
*   The ghost pieces seem to be flickering. It seems like reducing the alpha somehow blends Mangle's camera sprite. I have no idea what is going on and I have no idea how to fix this, whoops.
*   UX thing, but your current piece clips on the top of the screen when it spawns. Sorry, limitation. I could highlight the current piece in the next queue as "THIS PIECE" instead.
*   Switching minigames resets your progress. This is intended. I blame you, Helpy.
*   Camera minigame selection looks weird.
*   Does not appear in the “extras” menu.
*   Definitely not compatible with other mods that add minigames.
*   The Quad/T-Spin sound effect should really be the level up sound effect, but I don’t know what to replace it with.

  
  
Token balancing  
  
Ah, this is difficult. For this game, I equate the Tetrio S rank to be equivalent to being able to complete minesweeper with an average of 10 seconds. If you're good at the game, well, you deserve the skill.  
  
At base, you get about twice your APM, per minute, as tokens per minute. This means that if your APM is 45, you get about 90 tokens per minute. This is less than the 180 tokens per minute very good minesweeper players are at.  
  
Each level requires 8 lines cleared (this is down from 10, for pacing reasons). At level 7, you get tokens 2x as fast, and at level 14, you get tokens 3x as fast. However, to reach level 7, you need to clear 56 lines. You'll have to have grinded 40L a ton if you even want that when you have to balance animatronics at once. Trust me, it gets really, really hard when you have to balance this game and fend of animatronics at the same time. At the same time, I don't want to sideline beginners too much.  
  
**Token Yield**  
  
Level up every 8 line clears  
  
Token multiplier increases by 1/7 each level you advance past 1.  
  
**Disclaimer**
  
I made this for fun. If motivation permits, I can maintain and attempt to fix any bug that gets reported, but no guarantees. I am not responsible for anything that happens regarding your usage of this modification.  
  
If you’re recording gameplay that primarily focuses on this mod, please credit. Making forks of this is fine, just also acknowledge (and know that this might result in diverging branches!).