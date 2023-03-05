% Define the URL of the web page to capture
url = 'https://www.mathworks.com/';

% Set the output file name
filename = 'mathworks_screenshot.png';

% Set the size of the browser window to capture
width = 1280;
height = 800;

% Capture the screenshot
webcapture(url, filename, 'width', width, 'height', height);

% Read the screenshot into MATLAB as an image
screenshot = imread(filename);

% Define the text to search for
search_text = 'MATLAB';

% Convert the screenshot to grayscale
screenshot_gray = rgb2gray(screenshot);

% Use the OCR function to find the text in the screenshot
results = ocr(screenshot_gray, 'TextLayout', 'Block', 'CharacterSet', 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');

% Loop through the results and find the text we're looking for
found_text = false;
for i = 1:length(results)
    if contains(results(i).Text, search_text)
        fprintf('Found "%s" at location (%d, %d)\n', search_text, results(i).WordBoundingBoxes(1), results(i).WordBoundingBoxes(2));
        found_text = true;
        break;
    end
end

% If the text wasn't found, display a message
if ~found_text
    fprintf('Text "%s" not found in screenshot\n', search_text);
end

% Display the screenshot
imshow(screenshot);
