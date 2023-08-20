//
// Socket details are a Matrix. Each step is Vector 
//
// If its too big for your printer. Add a socket with no depth or text to create a gap for splitting the model printing 
// 

// What are the Socket hole diameters?
socketDiameters = [ [  12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 14 ] , [ 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 ]   ];

// What are the Socket hole depths?
socketDepths = [ [ 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14 ] , [ 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14 , 14 ]  ];
 
// What are the Socket hole labels?
socketLabels = [ [ "T8", "T10", "T15", "T20" , "T25" , "T27", "T30",  "T40", "4", "5.5", "7" , " " ] , [ "PZ1", "PZ2" , "PZ3" , "PH1", "PH2",  "PH3", "PH4", "3", "4", "5", "6" , "8", "10" ] ] ;

 // 1 = raised text, anything else = sunken text
raisedText = 1;
fontExtrude = 4;
textscale = 0.25;

// Height of each step
step1Height = 20; // First Step
stepnheight = 10; // Following Steps

// Height of Chamfer. 0 for no chamfer
chamfer = 10;

// Magnets
MagnetDiameter = 10 + 1; // 10mm Magnet
MagnetHeight = 0; // 0 - place under socket , else depth from base
MagnetOffset = 0; // Offset the magnet from the centre of the socket

// How much spacing to add for each hole
add = 1;

// How much wider than the widest hole should the step be?
scaling = 1.25;

// Joiners for split model
joinerdepth = 3;
joinerindent = 10;
joinertolerance = 0.25;


include <../parametricsocket.scad>


joinlocation = step_length / 2 + 9  ;

CreateSocketHolder(); // Create the socket holder
//CreateBase( 1.5 ); // Create the base
//SplitLeftJoiner( joinlocation ); // Split the model, create the left section
//SplitRightJoiner( joinlocation ); // Split the model, create the right section




