PImage mapImage;
Table locationTable;
int rowCount;
int noc = 4;                      //No. of columns in datatable
Table dataTable;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

void setup() 
{
  size(1459, 562);
  mapImage = loadImage("map.png");
  locationTable = new Table("locations.tsv");
  rowCount = locationTable.getRowCount( );
  // Read the data table.
  dataTable = new Table("moods.tsv");
  // Find the minimum and maximum values from all columns of data table
  for (int row = 0; row < rowCount; row++) 
  {
    for(int col = 1; col <= noc; col++)
    {
      float value = dataTable.getFloat(row, col);
      if (value > dataMax) 
      {
        dataMax = value;
      }
      if (value < dataMin) 
      {
        dataMin = value;
      }
    }  
  }
}
 
void draw( ) 
{
  background(255);
  image(mapImage, 0, 0);
  smooth( );
  noStroke( );
  
  //Specifies x and y positions of circles relative to original big circle
  float[] xshift = {0,80,0,-80};                                            
  float[] yshift = {-80,0,80,0};
  //Specifies colours for each circle [Colour Change]
  float[][] cc = { {0,0,255}, {255,255,0}, {0,255,0}, {255,0,0} };
  //Specifies transparency of circles [Value between 0 and 255]
  float alpha = 150;
  
  for (int row = 0; row < rowCount; row++) 
  {
    for(int col = 0;col <noc;col++)
    {
      fill(cc[col][0],cc[col][1],cc[col][2], alpha);
      String abbrev = dataTable.getRowName(row);
      float x = locationTable.getFloat(abbrev, 1);
      float y = locationTable.getFloat(abbrev, 2);
      drawData(x + xshift[col], y + yshift[col], abbrev, col+1);
    }
  }
  
  
  //Mouseover stuff
  //cursor x,y
  //textSize(10);
  //text( "x: " + mouseX + " y: " + mouseY, mouseX, mouseY );
  
  //Country mouseover
  if(get(mouseX,mouseY)==color(240,133,61))
  {
    textSize(40);
    fill(255, 60, 160);
    if(mouseX<=880)
      text("USA",350,50);
    else
      text("India",1200,100);
  }
  
  //Contacts mouseover
  for(int i=0;i<rowCount;i++)
  {
    String ab = dataTable.getRowName(i);
    float x = locationTable.getFloat(ab, 1);
    float y = locationTable.getFloat(ab, 2);
    if(dist(mouseX,mouseY,x,y) <= 80)
    {
      textSize(25);
      fill(90, 167, 0);
      if(i==0)
        text("Professor",780,200);
      else if(i==1)
        text("Colleague",780,200);
      else if(i==2)
        text("Fiance",780,200);
      else if(i==3)
        text("Family",780,200);
      else if(i==4)
        text("US Friends",780,200);
      else if(i==5)
        text("India Friends",780,200);
      else if(i==6)
        text("Employer",780,200);
      else if(i==7)
        text("Best Friend",780,200);
    }
  }
  
  //Feelings mouseover
  color c = get(mouseX,mouseY);
  textSize(35);
  fill (152, 85, 212);
 
  if(c != color(240,133,61) && c!= color(255,255,255))
  {
    if(red(c) > 150 && green(c) > 150 && blue(c)<150)
    {
      if(mouseX<=880)
        text("Happy",500,500);
        
       
      else
        text("Happy",1180,450);
   
    }
    else if(blue(c) > 150 && green(c)<150 && red(c)<150)
    {
      if(mouseX<=880)
        text("Tired",500,500); 
       else
        text("Tired",1180,450);
    }
    else if(green(c) > 150 && blue(c)<150 && red(c)<150)
    {
      if(mouseX<=880)
        text("Focused",500,500);
      else
        text("Focused",1180,450);
    }
    else if(red(c) > 150 && green(c)<150 && blue(c)<150)
    {
      if(mouseX<=880)
        text("Loving",500,500);
      else
        text("Loving",1180,450);
    }
  }
}

//usa feelings 500,500
//india feelings 1180,450

// Map the size of the ellipse to the data value
void drawData(float x, float y, String abbrev, int col) 
{
  // Get data value for state
  float value = dataTable.getFloat(abbrev, col);
  // Re-map the value to a number between given range:
  float minRemap = 10;
  float maxRemap = 40;
  float mapped = map(value, dataMin, dataMax, minRemap, maxRemap);
  // Draw an ellipse for this item
  ellipse(x, y, mapped, mapped);
}
