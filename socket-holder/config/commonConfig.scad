distanceBetweenHoles = 4;
stepMargin = 2;

raisedText = true;
includeLabels = false; //false if going to print the labels separately
fontExtrude = 2;

//The mininum height increase to the next step, actual height increase may be more if the next step has sockets much deeper 
//than previous step
minimumStepDelta = 10; 

//Height of Chamfer. 0 for no chamfer
chamfer = 8;

//Magnets
magnetDiameter = 10; 

//How deep to make the hole for the magnet, this is a minimum, will be deeper if there are deep and short sockets on the
//same step
magnetThickness = 5;

//How far to offset the magnet from the centre of the socket, this lets the magnet grab the edge of the socket, especially
//useful for sockets whose connector hole has a bigger diameter than the diameter of the magnets
magnetOffset = 4; 

//How much clearance to add to each socket and magnet hole
holeClearance = 1.25;