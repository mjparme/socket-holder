//
// Socket details are a Matrix. Each step is Vector 
//
// If its too big for your printer. Add a socket with no depth or text to create a gap for splitting the model printing 
// 

// What are the Socket hole diameters?
socketDiameters = [ [ 21.5, 23, 23, 26, 17, 17, ] ];

// What are the Socket hole depths?
socketDepths = [ [ 13, 16, 17, 16, 12, 12 ] ];

// What are the Socket hole labels?
socketLabels = [ ["16", "19" , "21" , "21" , " " , " " ]];

// 1 = raised text, anything else = sunken text
raisedText = 1;
fontExtrude = 4;
textscale = 0.5;

// Height of each step
step1Height = 25; // First Step
stepnheight = 10; // Following Steps

// Height of Chamfer. 0 for no chamfer
chamfer = 10;

// Magnets
MagnetDiameter = 20 + 1; // 20mm 
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