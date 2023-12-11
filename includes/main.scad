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