
BufferedReader reader;
PrintWriter fileOutput;

//String [] gameName="None";
//String [] north_america="-";
//String [] europe="-";
//String [] japan="-";

String [][] gameData= new String[10][4];
int numGames = 0;

int upperMargin = 75;
int leftMargin = 100;
int lowerMargin = 75;
int rightMargin = 100;

int col2;

FloatTable data;

float minNorth, maxNorth, minEurope, maxEurope, minJapan, maxJapan;

void setup(){
  size(600, 600);
  /*
  readAndParseURL("http://www.vgchartz.com/game/73107/the-order-1886/");
  readAndParseURL("http://www.vgchartz.com/game/85055/the-legend-of-zelda-majoras-mask-3d/");
  readAndParseURL("http://www.vgchartz.com/game/51765/minecraft/");
  readAndParseURL("http://www.vgchartz.com/game/84734/monster-hunter-4-ultimate/");
  readAndParseURL("http://www.vgchartz.com/game/73239/super-smash-bros-for-wii-u-and-3ds/");
  readAndParseURL("http://www.vgchartz.com/game/83196/grand-theft-auto-v/");
  readAndParseURL("http://www.vgchartz.com/game/81797/call-of-duty-advanced-warfare/");
  readAndParseURL("http://www.vgchartz.com/game/85041/dead-or-alive-5/");
  readAndParseURL("http://www.vgchartz.com/game/80324/far-cry-4/");
  readAndParseURL("http://www.vgchartz.com/game/81906/pokemon-omega-rubypokemon-alpha-sapphire/");
  outputFile("gameData.tsv");
  */
  numGames = 0;
  fill(0);
  col2 = 0;
  data = new FloatTable("gameData.tsv");
  minNorth = data.getColumnMin(0) * .9;
  maxNorth = data.getColumnMax(0) * 1.1;
  minEurope = data.getColumnMin(1) * .9;
  maxEurope = data.getColumnMax(1) * 1.1;
  minJapan = data.getColumnMin(2) * .9;
  maxJapan = data.getColumnMax(2) * 1.1;
}

void draw(){
  background(255, 183, 214);
  strokeWeight(3);
  stroke(10, 20, 50);
  
  //draw lines
  line(leftMargin, upperMargin, leftMargin, height-lowerMargin);
  line(width-rightMargin, upperMargin, width-rightMargin, height-lowerMargin);
  
  //textSize(12);
  if(col2 == 0){
    for(int i=0; i<data.getRowCount(); i++){
      float y = map(data.getFloat(i, 0), minNorth, maxNorth, 0, height-upperMargin-lowerMargin);
      ellipse(leftMargin, height-lowerMargin-y, 5, 5);
      textSize(10);
      
      text(data.getRowName(i), leftMargin + 5, height-lowerMargin-y);
      
      float y2 = map(data.getFloat(i, 2), minEurope, maxEurope, 0, height-upperMargin-lowerMargin);
      ellipse(width-rightMargin, height-lowerMargin-y2, 5, 5);
      strokeWeight(2);
      
      line(leftMargin, height-lowerMargin-y, width-rightMargin, height-lowerMargin-y2);
    }
    textAlign(CENTER);
    textSize(20);
    fill(150, 100, 100);
    text("North America", leftMargin, upperMargin-20);
    text("Europe", width-rightMargin, upperMargin-20);
    
    textSize(12);
    text(int(maxNorth)+"", leftMargin-40, upperMargin);
    text(int(minNorth)+"", leftMargin-40, height-lowerMargin+12);
    text(int(maxEurope)+"", width-rightMargin, upperMargin);
    text(int(minEurope)+"", width-rightMargin, height-lowerMargin+12);
  }
  
  


  if(col2 == 1){
    for(int i=0; i<data.getRowCount(); i++){
      float y = map(data.getFloat(i, 0), minNorth, maxNorth, 0, height-upperMargin-lowerMargin);
      ellipse(leftMargin, height-lowerMargin-y, 5, 5);
      textSize(10);
      
      text(data.getRowName(i), leftMargin + 5, height-lowerMargin-y);
      
      float y2 = map(data.getFloat(i, 1), minJapan, maxJapan, 0, height-upperMargin-lowerMargin);
      ellipse(width-rightMargin, height-lowerMargin-y2, 5, 5);
      strokeWeight(2);
      
      line(leftMargin, height-lowerMargin-y, width-rightMargin, height-lowerMargin-y2);
    }
    textAlign(CENTER);
    textSize(20);
    fill(150, 100, 100);
    text("North America", leftMargin, upperMargin-20);
    text("Japan", width-rightMargin, upperMargin-20);
    
    textSize(12);
    text(int(maxNorth)+"", leftMargin-40, upperMargin);
    text(int(minNorth)+"", leftMargin-40, height-lowerMargin+12);
    text(int(maxJapan)+"", width-rightMargin, upperMargin);
    text(int(minJapan)+"", width-rightMargin, height-lowerMargin+12);
  }
  
  
}


void mouseClicked(){
  if (col2 == 0){
    col2 = 1;
  } else {
    col2 = 0;
  }
}

void readAndParseURL(String url){
  reader = createReader(url);
  
  String html="";
  try{
    String line = reader.readLine();
    while(line != null){
      html += line;
      line = reader.readLine();
    }
  }
  catch(Exception e){
    println("Error parsing file: " + e.toString());
  }
  
  int idx = html.indexOf("<title>");
  println(idx);
  String t = html.substring(idx);
  int i2 = html.indexOf("</title>");
  String n = html.substring(idx+7, i2-75).trim();
  println(n);
  gameData[numGames][0] = n;
  
  idx = html.indexOf("<td>+ North America:");
  String a = html.substring(idx+42,idx+47).trim();
  println("North America" + a);
  gameData[numGames][1] = a;
  
  
  idx = html.indexOf("<td>+ Europe:");
  String r = html.substring(idx+37,idx+42).trim();
  println("Europe" + r);
  gameData[numGames][2] = r;
  
  idx = html.indexOf("<td>+ Japan:");
  String p = html.substring(idx+36,idx+41).trim();
  println("Japan" + p);
  gameData[numGames][3] = p;
  
  numGames++;
}

void outputFile(String fname){
  fileOutput = createWriter(fname);
  fileOutput.println("Game Name\t North America \t Europe \t Japan \n");
  for(int i=0; i<gameData.length; i++){
    for(int j=0; j<gameData[i].length; j++){
      if (j == 0){
        fileOutput.print(gameData[i][j]);
      }
      else{
        String newNumber = "";
        newNumber = gameData[i][j];
        fileOutput.print(newNumber);
      }
      if(j<gameData[i].length-1){
        fileOutput.print("\t");
      }
      else{
        fileOutput.print("\n");
      }
    }
  }
  fileOutput.flush();
  fileOutput.close();
}
