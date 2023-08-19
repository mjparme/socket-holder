include <./config/commonConfig.scad>

//include <./config/hexImperial-Config.scad>
//include <./config/hexImperialTall-Config.scad>
//include <./config/hexMetric-Config.scad>
//include <./config/hexMetricTall-Config.scad>
//include <./config/starImperial-Config.scad>
//include <./config/starMetric-Config.scad>
//include <./config/starBigMixed-Config.scad>
include <./config/miscTall-Config.scad>

$fn = $preview ? 30 : 100;

PART = "socketHolder";
PART = "labels"; //for printing separate labels, ignore if you set includeLabels = true (i.e. integrated labels)

numOfSteps = len(socketDiameters);

socketHoleDepths = [
     for (i = [0 : numOfSteps - 1]) [
            for (j = [0 : len(socketDiameters[i]) - 1]) socketHeights[i][j] / 2
        ]
];

// Max socket Diameter for each step - determines step width.
maxSocketDiameter = [for (i = [0 : numOfSteps - 1]) max(socketDiameters[i]) + holeClearance];

//This is a vector of vectors that holds the distance from the start of one socket hole to the start of the next socket hole
//Used to calculate the location of each hole
socketSpacing = [
        for (i = [0 : numOfSteps - 1]) [
            for (j = [0 : len(socketDiameters[i]) - 1]) distanceBetweenHoles + socketDiameters[i][j]
        ]
    ];

// Coordinates of each socket so we know where to place the socket
socketCoords = [ for (b = 0, i = [0 : numOfSteps - 1])
                    [ for (j = [0 : len(socketDiameters[i]) - 1]) j == 0
                                                  ? socketSpacing[i][j] / 2 + stepMargin
                                                  : socketSpacing[i][j] / 2 + stepMargin + addList(socketSpacing[i], j - 1)
                    ]
               ];

//The minimum height a step has to be to fit the socket, magnets, and some extra for clearance
minimumStepHeights = [for (i = [0 : numOfSteps - 1]) max(socketHoleDepths[i]) + magnetThickness + holeClearance];

//The height of each step over the previous one, make sure the next height is at least minimumStepDelta
stepHeightDeltas = [
    for (i = [0 : numOfSteps - 1]) i == 0 ? minimumStepHeights[i] 
                                  : (minimumStepHeights[i] - minimumStepHeights[i - 1] > minimumStepDelta) 
                                    ? minimumStepHeights[i] - minimumStepHeights[i - 1]
                                    : minimumStepDelta
    ];

// The height of each step so we know where to put the socket holes
stepHeights = [for (a = 0, b = stepHeightDeltas[0]; a < len(stepHeightDeltas); a = a + 1, b = b + (stepHeightDeltas[a] == undef ? 0 : stepHeightDeltas[a])) b];

// Cordinates of step Height - so we know where to put text
stepHeightCords = concat(0, stepHeights);

// Width of each step - for buiding steps and to center holes
stepWidth = [
        for (i = [0 : numOfSteps - 1]) chamfer + maxSocketDiameter[i] + 2 * stepMargin
    ];

// Accumlated step width
stepWidthAccum = [
        for (a = 0, b = stepWidth[0]; a < len(stepWidth); a = a + 1, b = b + (stepWidth[a] == undef ? 0 : stepWidth[a])) b
    ];

// Cordinates of step width - for creating steps
stepWidthCords = concat(0, stepWidthAccum);

// Length of the step - take the largest of the socket steps
stepLength = max([for (i = [0:numOfSteps - 1]) addArray(socketSpacing[i])]) + 2 * stepMargin;

// Sum N elements of an array
function addList(list, l, c = 0) = c < l ? list[c] + addList(list, l, c + 1) : list[c];

// Sum All elments of Array
function addArray(v) = [for (p = v) 1] * v;

angle = chamfer == 0 ? 90 : 45;
labelSize = chamfer == 0 ? 8 : chamfer;
chamferLength = sqrt(chamfer * chamfer * 2);
chamferHeight = chamferLength == 0 ? 0 : chamfer * chamfer / chamferLength;

echo("numOfSteps: ", numOfSteps);
echo("socketSpacing: ", socketSpacing);
echo("maxSocketDiameter: ", maxSocketDiameter);
echo("stepWidthAccum: ", stepWidthAccum);
echo("socketCoords: ", socketCoords);
echo("stepLength: ", stepLength);
echo("stepWidth: ", stepWidth);
echo("stepWidthCords: ", stepWidthCords);
echo("minimumStepHeights: ", minimumStepHeights);
echo("stepHeightDeltas: ", stepHeightDeltas);
echo("stepHeights: ", stepHeights);
echo("stepHeightCords: ", stepHeightCords);
echo("socketHoleDepths: ", socketHoleDepths);
echo("angle: ", angle);
echo("includeLabels: ", includeLabels);
echo("fontExtrude: ", fontExtrude);
echo("labelSize: ", labelSize);
echo("magnetThickness: ", magnetThickness);

if (PART == undef || PART == "socketHolder") {
    socketHolder(); 
} else {
    //This is for creating separate labels 
    for (step = [0 : numOfSteps - 1]) {
        labelY = step * 1.5 * labelSize;
        labelZ = 0;
        //X position is taken care of inside the stepLabels module
        translate([0, labelY, labelZ]) stepLabels(step, angle = 0, includeConnector = true);
    }
}

module socketHolder() {
    difference() {
        steps();
        holes();
        if (!raisedText && includeLabels) {
            integratedLabels();
        }
    }

    if (raisedText && includeLabels) {
        integratedLabels();
    }
}

module steps() {
    for (i = [0 : numOfSteps - 1]) {
        stepY = stepWidthCords[i];
        translate([0, stepY, 0]) step(stepLength, stepWidth[i], stepHeights[i], chamfer);
    }

    module step(sizeX, sizeY, sizeZ, chamferHeighteight) {
        chamferLengthength = sqrt(chamferHeighteight * chamferHeighteight * 2);
        difference() {
            cube([ sizeX, sizeY, sizeZ ]); 
            translate([ -0.1, 0, -chamferHeighteight + sizeZ ]) rotate([ 45, 0, 0 ]) cube([ sizeX + 0.2, chamferLengthength, chamferLengthength ]);
        }
    }
}

module holes() {
    for (step = [0 : numOfSteps - 1]) {
        for (socket = [0:len(socketDiameters[step]) - 1]) {
            // Create holes for the sockets
            posY = 0.5 * (stepWidth[step] + chamfer) + stepWidthCords[step];
            posZ = stepHeights[step] - socketHoleDepths[step][socket];

            // Skip a zero depth socket - zero length sockets used to create gaps
            if (socketHoleDepths[step][socket] != 0) {
                translate([ socketCoords[step][socket], posY, posZ ])
                    cylinder(d = socketDiameters[step][socket] + holeClearance, h = socketHoleDepths[step][socket] + 0.01);
            }

            // Create holes for the magnets
            if (socketHoleDepths[step][socket] != 0) {
                magnetHoleHeight = stepHeights[step] - socketHoleDepths[step][socket] - 1;
                translate([socketCoords[step][socket], posY + magnetOffset, -0.01]) cylinder(d = magnetDiameter + holeClearance, h = magnetHoleHeight);
            }
        }
    }
}

module integratedLabels() {
    for (step = [0 : numOfSteps - 1]) {
        stepY = stepWidthCords[step] + chamferHeight - (chamfer == 0 ? 0 : 1);
        stepZ = chamfer == 0 ? stepHeightCords[step] + 0.5 * stepHeightDeltas[step] : stepHeights[step] - chamferHeight;
        translate([0, stepY, stepZ]) stepLabels(step, angle);
    }
}

module stepLabels(step, angle = 0, includeConnector = false) {
    lastIndex = len(socketDiameters[step]) - 1;
    for (socket = [0 : lastIndex]) {
        letter = socketLabels[step][socket]; 
        if (letter != " ") {
            letterX = socketCoords[step][socket];
            translate([letterX, 0, 0]) rotate([angle, 0, 0]) 
            linear_extrude(height = fontExtrude) 
                text(text = letter, font = "Liberation Sans:style=Bold", size = labelSize, halign = "center", valign = "center");
        }
    }

    if (includeConnector) {
        connectorWidth = chamfer + 1;
        connectorHeight = 1;
        translate([0, -connectorWidth / 2, -connectorHeight]) cube([stepLength, connectorWidth, connectorHeight]);
    }
}