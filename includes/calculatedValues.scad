$fn = $preview ? 30 : 100;
angle = chamfer == 0 ? 90 : 45;
labelSize = chamfer == 0 ? 8 : chamfer;
chamferLength = sqrt(chamfer * chamfer * 2);
chamferHeight = chamferLength == 0 ? 0 : chamfer * chamfer / chamferLength;