include <./config/commonConfig.scad>

//include <./config/hexImperial-Config.scad>
//include <./config/hexImperialTall-Config.scad>
//include <./config/hexMetric-Config.scad>
//include <./config/hexMetricTall-Config.scad>
//include <./config/starImperial-Config.scad>
include <./config/starMetric-Config.scad>
//include <./config/starBigMixed-Config.scad>
//include <./config/miscTall-Config.scad>

PART = "socketHolder";
//For printing separate labels, only needed to render labels if you set includeLabels = false 
//Render the socket holder, then uncomment this line to render the lables
//PART = "labels"; 

include <./includes/comprehensions.scad>
include <./includes/functions.scad>
include <./includes/calculatedValues.scad>
include <./includes/debug.scad>
include <./includes/modules.scad>
include <./includes/main.scad> //This include kicks off the rendering