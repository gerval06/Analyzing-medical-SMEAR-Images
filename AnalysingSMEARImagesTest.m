%% Test 1: With RadMin 20 RadMax 35 
cd .\Testing
img = imread('TestImg_CHT_a2.bmp');
cd ..\

RadMin = 20;
RadMax = 35;
[CircleCenter, CircleRad] = CountCircles(img, RadMin, RadMax);

assert(max(size(CircleRad)) == 5,'Right count !')

%% Test 2: With RadMin 20 RadMax 50

cd .\Testing
img = imread('TestImg_CHT_a2.bmp');
cd ..\

RadMin = 20;
RadMax = 50;
[CircleCenter, CircleRad] = CountCircles(img, RadMin, RadMax);

assert(max(size(CircleRad)) == 7,'Right count !')