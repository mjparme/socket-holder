//socketDiameters, socketHeight, and socketLabels are generally in the config file for each specific socket holder, they are 
//here just to document that they are needed, nothing will render until these 3 vectors have values

//A vector of socket diameters. Diameter of the holes will be these values + holeClearance
socketDiameters = [ 
        [ ]  
    ];

//A vector of how tall each socket is. This is used to calculate socket hole depth which is socketHeight / 2
socketHeights = [
    [ ]
    ];
 
//A vector of the labels for each socket, if the labels overlap increase distanceBetweenHoles 
socketLabels = [ 
    [ ] 
    ] ;

//How much space there is between each hole. The less distance between holes the less material it takes to print. This 
//value may need to be increased if the labels overlap (generally only a problem with two double digit fractions in a row on 
//imperial sockets)
distanceBetweenHoles = 4;

//How much space there is between the left/right/bottom/top edges and the holes, it adds 2 * stepMargin to the length of 
//and width of the holder
stepMargin = 2;

//true if you want labels that extrudes from the face, false to have labels that are subtracted
raisedText = true;

//true to include the labels on the model, false to print the labels separately
includeLabels = false; 

//How far the labels are extruded from the face, or embedded into it 
fontExtrude = 2;

//The mininum height increase to the next step, actual height increase may be more if the next step has sockets much deeper 
//than previous step
minimumStepDelta = 10; 

//Height of Chamfer. 0 for no chamfer
chamfer = 8;

//The diameter of the magents you intend to use, actual diameter is magnetDiamter + holeClearance
magnetDiameter = 10; 

//How deep to make the hole for the magnet, this is a minimum, will be deeper if there are deep and short sockets on the
//same step
magnetThickness = 5;

//How far to offset the magnet from the centre of the socket, this lets the magnet grab the edge of the socket, especially
//useful for sockets whose connector hole has a bigger diameter than the diameter of the magnets
magnetOffset = 4; 

//How much clearance to add to each socket and magnet hole. In the case of the magnet hole this clearance is applied to both the
//diameter and depth of the hole
holeClearance = 1.25;