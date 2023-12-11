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