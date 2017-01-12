function [CircleCenter, CircleRad] = CountCircles(Image, RadMin, RadMax)
    [accum, CircleCenter, CircleRad] = CircularHough_Grd(Image,[RadMin,RadMax]);
    circ_h = viscircles(CircleCenter,CircleRad,'EdgeColor','b');
    title(['Number of detected cells: ' num2str(max(size(CircleCenter)))])
end