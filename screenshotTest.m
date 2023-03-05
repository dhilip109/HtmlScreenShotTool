
function screenshotTest()
% Define the path to the local HTML file to capture
html_path = 'C:/Work/1/MBD/chat_gpt/Screenshot_function/index.html';

% Set the output file name
filename = 'local_file_screenshot.png';

% Set the size of the browser window to capture
width = 1280;
height = 800;
% 
% Create a web browser object
% browser = webbrowser(html_path, '-browser');
% browser = webbrowser('https://www.mathworks.com/', 'ShowToolbar', 'on');

% Navigate to the local HTML file
% web(browser, ['file://', html_path]);
a = web(['file://', html_path]);

% Wait for the page to load
% waitfor(a);
pause(5);

% Capture the screenshot
webcapture('C:/Work/1/MBD/chat_gpt/Screenshot_function/index.html', filename, 'width', width, 'height', height);

% Close the web browser object
close(browser);

% Read the screenshot into MATLAB as an image
screenshot = imread(filename);

% Define the text to search for
search_text = 'Sean';

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
end
