# WEB Task

## Description
User has a 3x3 field. 

User might get the permissions to click on these cells after connecting to the server.

Server set the permissions to change cells state for only one user - CLICKERMAN (other users can see changes only - VIEWERs).

If CLICKERMAN is disconnected his permmissions are moved to the next user or if nobody else is connected the state of cells are wiped.

Cell colors meaning:
- orange - unchecked,
- green - checked
- gray - disabled

Actions also duplicated in the server and browsers consoles.

## Install and using
- Type ```npm install``` in terminal to install node modules.
- Use ```npm  start``` to run the server. 
- Open index.html to run a client part.