color[] COLORS = { 
  #3f9e99, 
  #df3b3f, 
  #444760, 
  #e18846, 
  #fcbf3d, 
  #cf3648,
  // New colors  
  #8dff1c,
  #ffba1c,
  #1cff1f
};

color randomColor() {
  return COLORS[floor(random(COLORS.length))];
}
