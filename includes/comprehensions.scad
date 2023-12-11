//A calculated value many of the comprehensions depend on
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