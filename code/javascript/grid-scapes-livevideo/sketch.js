/**
 * gridScapes – Video Capture Edition
 * Author: Matthias Jäger
 * Date: 2020-04-19
 */

/** VIDEO VARIABLES */
// ---------------------------------------------------------------------- //
const sketchWidth = (window.innerWidth * 0.1)*5;
const sketchHeight = (window.innerHeight * 0.1)*5;

const captureTileSize = 6;
const captureTileHalf = captureTileSize * 0.5;
let canvas, capture, buffer;


/** MAIN FUNCTIONS */
// ---------------------------------------------------------------------- //

/** Setup runs first */
function setup() {
  
  canvas = createCanvas(sketchWidth, sketchHeight);

  // Create the capture object
  capture = createCapture(VIDEO);
  
  // Set a very small size 
  capture.size(sketchHeight*0.1, sketchHeight*0.1);
  
  // Hide the <video> inside of the DOM
  capture.hide();
}

/** Draw loops until the browser is closed */
function draw() {
  
  // Clear the Background with white
  background(255);
  
  // Open an empty graphics buffer to draw into
  // needed to later use buffer.get(x, y) 
  buffer = createGraphics(width, height);
  // Place an image with the current frame in the buffer
  buffer.image(capture, 0, 0, width, height);
  
  // Subdevide the screen in a grid of squares
  const rows = width / captureTileSize;
  const cols = height / captureTileSize;
  
  // Draw the squares to the screen
  for (let i = 0; i < rows; i++) {
    for (let j = 0; j < cols; j++) {
      // Get the current position in the grid
      const x = i * captureTileSize + captureTileHalf;
      const y = j * captureTileSize + captureTileHalf;
      // Copy the color from the position
      const c = buffer.get(x, y);
      
      // Actual design
      push();
      translate(x, y);
      strokeWeight(map(blue(c), 0, 255, 3, 0));
      rotate(map(red(c), 0, 255, 0, TAU));
      line(0, 0, (map(green(c), 0, 255, captureTileSize, 0)), 0);
      pop();
    }
  }
}