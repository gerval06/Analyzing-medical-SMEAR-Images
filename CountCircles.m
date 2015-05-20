function [CircleCenter, CircleRad] = CountCircles(Image, RadMin, RadMax)
if verLessThan('matlab','8.3.0.532')
    [accum, CircleCenter, CircleRad] = CircularHough_Grd(Image,[RadMin,RadMax]);
    %circ_h = viscircles(circen,cirrad,'EdgeColor','b');
    %title(['Number of detected cells: ' num2str(max(size(circen)))])
else
    % Find cells with |imfindcircles| parameter where chossen by testing [10,25]
    [CircleCenter, CircleRad] = imfindcircles(Image,[RadMin,RadMax],'ObjectPolarity','bright','Sensitivity',0.8);
    %circ_h = viscircles(centers, radii,'EdgeColor','b');
    %title(['Number of detected cells: ' num2str(max(size(centers)))])
end
end