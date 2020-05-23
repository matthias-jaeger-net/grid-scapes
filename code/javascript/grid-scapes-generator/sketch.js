/**
 * gridscape-generator-colab
 * Author: Matthias Jäger
 * Date: 2020-04-27
 */

/** VARIABLES */
// ---------------------------------------------------------------------- //

// Settings
let resolution;
let thickness;
let linelength;
let angleshift;

// Options
let colorful;

// Handle file
let uploadButton;
let loadedImage;
let bufferImage;

// Sliders
let resolution_slider;
let thickness_slider;
let linelength_slider;
let angleshift_slider;

let controls;


/** IMAGE CREATION */
// ---------------------------------------------------------------------- //

function createGridscape(img) {

  // First update all the values from the UI
  resolution = resolution_slider.value();
  thickness = thickness_slider.value();
  linelength = linelength_slider.value();
  angleshift = angleshift_slider.value();
  styleoption = style_option.value();
  
  let d = frame_slider.value();
    
  // Ground the canvas with white 
  background(255);

  // Set a detection grid to trace the image
  for (let x = d; x < width - d; x += resolution) {
    for (let y = d; y < height - d; y += resolution) {

      // Get the color at the location
      let c = img.get(x, y);

      
      if (styleoption == "black") stroke(0);
      if (styleoption == "color") stroke(c);

      // Render the graphic
      push();
      translate(x + resolution * 0.5, y  + resolution * 0.5);
      strokeWeight(map(blue(c), 0, 255, thickness, 1));
      rotate(map(red(c), 0, 255, -angleshift, angleshift));
      line(0, 0, (map(green(c), 0, 255, linelength, 1)), 0);
      pop();
    }
  }
}


/** FILE HANDLING */
// ---------------------------------------------------------------------- //

//** Callback: An image has been selected */
function bufferImageCallback() {
  
  // Resize the imgage to match the screen
  bufferImage.resize(width, height);

  // Update the graphics
  createGridscape(bufferImage);
}


//** Callback: Populate the reference window */
function referenceImageCallback() {
  
  // Remove any previously added images 
  select("#refimage").html("");
  
  // Add the loaded image in the div
  loadedImage.parent(select("#refimage"));
}


//** Callback: Is called when a file was selected */
function handleFileCallback(file) {

  // Expecting a p5 file object
  if (file.type === "image") {
    // Copy the data from the image in a graphics buffer
    bufferImage = loadImage(file.data, bufferImageCallback);

    // Send the loaded image to the dom reference window
    loadedImage = createImg(file.data, "refimg", "", referenceImageCallback);

    // Show the editor UI
    select("#controls").show();
  } else {
    alert("Please try it with an image");
  }
}


/** USER INTERFACE */
// ---------------------------------------------------------------------- //

//** Creates all dom elements and assigns the parent divs */
function connectUserInterface() {

  // File input 
  uploadButton = createFileInput(handleFileCallback);
  uploadButton.parent(select("#refselect"));

  
  // Changes the cellsize of the detection grid
  resolution_slider = createSlider(1, 20, 10, 0.5);
  resolution_slider.parent(select("#slider-resolution"));
  resolution_slider.changed(function() {
    createGridscape(bufferImage);
  });

  // Changes the weight of the line
  thickness_slider = createSlider(1, 10, 3, 0.1);
  thickness_slider.parent(select("#slider-thickness"));
  thickness_slider.changed(function() {
    createGridscape(bufferImage);
  });

  // Sets the length of the line 
  linelength_slider = createSlider(3, 50, 12, 1);
  linelength_slider.parent(select("#slider-linelength"));
  linelength_slider.changed(function() {
    createGridscape(bufferImage);
  });

  // Crazy mapping of the angle of rotation
  angleshift_slider = createSlider(0, 2* TAU, TAU * 0.5, 0.1);
  angleshift_slider.parent(select("#slider-angleshift"));
  angleshift_slider.changed(function() {
    createGridscape(bufferImage);
  });
  
  // A radio menu to turn colors on or off
  style_option = createRadio();
  style_option.option('black');
  style_option.option('color');
  style_option.parent(select("#option-colors"));
  style_option.changed(function() {
    createGridscape(bufferImage);
  });
  
  // Crazy mapping of the angle of rotation
  frame_slider = createSlider(0, 180, 0, 1);
  frame_slider.parent(select("#slider-frame"));
  frame_slider.changed(function() {
    createGridscape(bufferImage);
  });
}

/** MAIN */
// ---------------------------------------------------------------------- //

//** p5 function that executes first and once */
function setup() {

  // Create the canvas and move it to the workspace div
  createCanvas(600, 600).parent(select("#workspace"));

  // Creates all missing DOM elements for the user interface
  // Adds all change event listeners
  connectUserInterface();
  
  // Only shows the browse button
  select("#controls").hide();
    
  // Show splash screen
  background(220);
  textAlign(CENTER, CENTER);
  fill(0);
  text("No image selected", width * 0.5, height * 0.5);
}