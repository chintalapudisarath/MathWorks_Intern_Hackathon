# MathWorks_Intern_Hackathon
This project was built as part of My Summer Internship 2018 at MathWorks

OIL PAINTING CONVERTER
----------------------

Idea behind Algorithm:
---------------------
We have taken you key features of an Oil Painted picture into consideration while designing this Algorithm.
1. Reduce the Number of colors in the given Image
2. Pick the most frequent/dominant color in the given window
==================================================================

Implemented By:
--------------
Sarath Chintalapudi
==================================================================

Software Specifications:
-----------------------
1. Trail version of Matlab should be fine, No need to have any tool box installed.
2. Incase if you want to use real time, You need to have 'Webcam' and corresponding 'Add on' installed (which is free)

==================================================================

Steps to execute the code:
-------------------------
1. Paste all the attached '.m' files in the folder
2. Extract all the input zip files and place them in the same folder where you placed '.m' files.
3. Now, If you want to convert a particular video from normal MP4 format into Oil painter video in AVI, please follow below steps
		1. You have to use "videoOilPainting.m" file. Firstly open the file and
		2. Give the path of the INPUT VIDEO FILE in LINE 2 in the file
		3. If you want more number of colors increase the "noOfBins" parameter in LINE 3 in file. More the value you can find more number of reduced colors
		4. If you increase the parameter "windowN" in LINE 4 in the file you can find more oil painting effect in the output AVI file.
4. If you want to have oil painting effect real time, you have to run in "realTimeOilPainting.m" using below command.
		while true
			realTimeOilPainting(5,5)
		end
	The first Parameter is noOfBins, More the value you can find more number of reduced colors and vice versa
	The Second parameter is windowN, More the value you can find more oil painting effect and vice versa
==================================================================
