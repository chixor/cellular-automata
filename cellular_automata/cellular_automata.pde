// Based on the Cellular Automata Processing script written by fabz https://github.com/fabz
// I removed the dependency on a gif library and added the ability to wrap the rules around
// (wrapping the rules adds logevity to the generations)

int[] rule110 = { 0, 1, 1, 0, 1, 1, 1, 0 };
int[] rule30  = { 0, 0, 0, 1, 1, 1, 1, 0 };
int[] rule22  = { 0, 0, 0, 1, 0, 1, 1, 0 };
int[] rule45  = { 0, 0, 1, 0, 1, 1, 0, 1 };
int[] rule150 = { 1, 0, 0, 1, 0, 1, 1, 0 };
int[] rule225 = { 1, 1, 1, 0, 0, 0, 0, 1 };
int[] rules = rule150;
color on = color(255);
color off = color(0);
int wrap = 1; // Should we wrap the rules at first and last cell?
 
void setup() {
  size(61, 680); //width and length of the gif
  background(0);
  set(width-1, 0, on); //set the next to last pixel to white
  set(42, 0, on);
  set(20, 0, on);
}
 
// For each pixel, determine new state by examining current
// state and neighbor states
void draw() {
  for (int y = 1; y < height; y++) {
    for (int i = 0; i < width; i++) {
      int left = get(i - 1, y - 1); // Left neighbor
      int right = get(i + 1, y - 1); // Right neighbor
      if(wrap == 1 && i == 0) {
        left = get(width-1, y - 1);
        right = get(i + 1, y - 1);
      }
      else if(wrap == 1 && i == width-1) {
        left = get(i - 1, y - 1);
        right = get(0, y - 1);
      }
      int me = get(i, y - 1); // Current pixel
  
      if (rules(left, me, right) == 1) {
        set(i, y, on);
      }
    }
  }
}

// Implement the rules
int rules(color a, color b, color c) {
  if ((a == on)  && (b == on)  && (c == on))  return rules[0];
  if ((a == on)  && (b == on)  && (c == off)) return rules[1];
  if ((a == on)  && (b == off) && (c == on))  return rules[2];
  if ((a == on)  && (b == off) && (c == off)) return rules[3];
  if ((a == off) && (b == on)  && (c == on))  return rules[4];
  if ((a == off) && (b == on)  && (c == off)) return rules[5];
  if ((a == off) && (b == off) && (c == on))  return rules[6];
  if ((a == off) && (b == off) && (c == off)) return rules[7];
  return 0;
}
