import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons;//2d array of minesweeper buttons
private ArrayList <MSButton> bombs =new ArrayList  <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int r = 0; r<NUM_ROWS; r++) {
    for (int c = 0; c <NUM_ROWS; c++) {
      buttons[r][c]=new MSButton(r, c);
    }
  }
  setBombs();
}
public void setBombs()
{
  for (int hehexd = 0; hehexd <3; ) {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if (bombs.contains((buttons[r][c]))==false) {
      bombs.add(buttons[r][c]);
      hehexd ++;
      System.out.println(r+", "+c);
    }
  }
}

public void draw ()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  int isW = 0;
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int b = 0; b < NUM_COLS; b++) {
      if (buttons[i][b].isClicked()==true) {
        isW++;
      }
    }
  }
  if (isW==(NUM_ROWS*NUM_COLS)) {
    return true;
  }
  return false;
}
public void displayLosingMessage()
{
  for(int i = 0; i < 20;i++){
  buttons[0][i].setLabel("Y");
  buttons[1][i].setLabel("O");
  buttons[2][i].setLabel("U");
  buttons[3][i].setLabel(" ");
  buttons[4][i].setLabel("L");
  buttons[5][i].setLabel("O");
  buttons[6][i].setLabel("S");
  buttons[7][i].setLabel("E");
  }
}
public void displayWinningMessage()
{
  
  for(int i = 0; i < 20;i++){
  buttons[0][i].setLabel("Y");
  buttons[1][i].setLabel("O");
  buttons[2][i].setLabel("U");
  buttons[3][i].setLabel(" ");
  buttons[4][i].setLabel("W");
  buttons[5][i].setLabel("I");
  buttons[6][i].setLabel("N");
  }
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;


  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    ////your code here
    if (mouseButton == RIGHT) {
      marked = !marked;
      if (marked == false) {
        clicked = false;
      }
    } else if (bombs.contains(this)) {
      displayLosingMessage();
    } else if (countBombs(r, c)>0) {
      label = "" + countBombs(r, c);
    } else {
      for (int i = r-1; i <= r+ 1; i++) {
        for (int b = c -1; b <= c + 1; b++) {
          if (isValid(i, b)&&buttons[i][b].isClicked()==false) {
            buttons[i][b].mousePressed();
          }
        }
      }
    }
  }




  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if (r < NUM_ROWS && c < NUM_COLS && r >=0 && c >= 0) {
      return true;
    }
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    for (int i = row-1; i<= row+1; i++) {
      for (int b = col -1; b <= col+1; b++) {

        if (isValid(i, b) &&bombs.contains(buttons[i][b]) == true) {
          numBombs++;
        }
      }
    }
    return numBombs;
  }
}
