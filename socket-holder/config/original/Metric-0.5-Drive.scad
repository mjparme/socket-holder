//
// Socket details are a Matrix. Each step is Vector 
//
// If its too big for your printer. Add a socket with no depth or text to create a gap for splitting the model printing 
// 

// What are the Socket hole diameters?
socketDiameters = [ [ 22, 22, 22, 22, 21.7 , 23.2, 23.2, 24.1, 26 ], [ 26, 26.1, 26.1, 30, 36.1, 38.3 ] ];

// What are the Socket hole depths?
socketDepths = [ [ 14, 14, 14, 14, 14, 14, 14, 14, 14] , [ 14, 16, 16, 16, 16, 16 ] ];

// What are the Socket hole labels?
socketLabels = [ ["10", "12", "13" , "14", "15" , "16", "17", "18", "20"] , ["21", "23", "24", "27", "32","34" ]];

 // 1 = raised text, anything else = sunken text
raisedText = 1;
fontExtrude = 4;
textscale = 0.3;

// Height of each step
step1Height = 20; // First Step
stepnheight = 10; // Following Steps

// Height of Chamfer. 0 for no chamfer
chamfer = 10;

// Magnets
MagnetDiameter = 15 + 1; // 15mm  Magnet
MagnetHeight = 0; // 0 - place under socket , else depth from base
MagnetOffset = 4; // Offset the magnet from the centre of the socket

// How much spacing to add for each hole
add = 1;

// How much wider than the widest hole should the step be?
scaling = 1.25;

// Joiners for split model
joinerdepth = 5;
joinerindent = 10;
joinertolerance = 0.25;