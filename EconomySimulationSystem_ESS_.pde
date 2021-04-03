import java.util.Random; 
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
int count = 0;
Merchant[] cells;
int[] ruleset;
int w = 10;
String[][] datrix = new String[7][3];
private static void swap(char[] arr, int i, int j) {
  char tmp = arr[i];
  arr[i] = arr[j];
  arr[j] = tmp;
}

private static void permutations(char[] arr, int loc, int len, ArrayList<String> result) {
  if (loc == len) {
    result.add(new String(arr));
    return;
  }

  // Pick the element to put at arr[loc]
  permutations(arr, loc + 1, len, result);
  for (int i = loc + 1; i < len; i++) {
    // Swap the current arr[loc] to position i
    swap(arr, loc, i);
    permutations(arr, loc + 1, len, result);
    // Restore the status of arr to perform the next pick
    swap(arr, loc, i);
  }
}

public static ArrayList<String> permutations(String str) {
  ArrayList<String> result = new ArrayList<String>();
  if (str.length() == 0) { 
    return result;
  }
  permutations(str.toCharArray(), 0, str.length(), result);
  return result;
}


double G(int nb, int nr) {
  return ((double)nb/((double)(nr + 1)));
}
double F(int na, double g) {
  return na * g;
}



void CA() {




  Merchant a = new Merchant();
  Merchant b = new Merchant();
  Merchant c = new Merchant();
  a.R = 25;
  a.C = 10;
  a.S2 = 0;
  a.D = 10;
  a.lvr = 5;
  a.lvs = 6;
  a.lvs2 = 4;
  b.R = 15;
  b.C = 20;
  b.S2 = 10;
  b.D = 10;
  b.lvr = 3;
  b.lvs = 6;
  b.lvs2 = 5;
  c.R = 10;
  c.C = 20;
  c.S2 = 0;
  c.D = 10;
  c.lvr = 7;
  c.lvs = 4;
  c.lvs2 = 3;


  cells = new Merchant[3];
  cells[0] = a;
  cells[1] = b;
  cells[2] = c;
}

void generate() {
  Merchant[] nextgen = new Merchant[cells.length];

  ArrayList<List<String>> setc = new ArrayList<List<String>>();
  for (int j = 0; j < permutations("012").size(); j++) {
    String[] a = permutations("012").get(j).split("");
    List<String> al = new ArrayList<String>();
    al = Arrays.asList(a);
    setc.add(al);
  }

  for (int i = 0; i < 6; i++) {



    ArrayList<String> set = new ArrayList<String>();

    set.add("A");
    set.add("B");
    set.add("C");

    Merchant defaul = new Merchant();


    defaul.R = 0;
    defaul.C = 0;
    defaul.S = 0;
    defaul.S2 = 0;



    Merchant me;
    Merchant a1 = defaul;
    Merchant a2 = defaul;
    int mein = Integer.parseInt(setc.get(i).get(0));
    int a1in = Integer.parseInt(setc.get(i).get(1));
    int a2in = Integer.parseInt(setc.get(i).get(2));
    //*MEDIDAS DE ACTIVACION ECONOMICA
    for (int b = 0; b < cells.length; b++) {
      if (cells[b].id == 0) {
        if (cells[b].R >= 2) {
          cells[b].R -= 2;
          cells[b].S += 2;
        }

        if (cells[b].S2 >= 2) {
          cells[b].S2 -= 2;
        }
      } else if (cells[b].id == 1) {
        if (cells[b].R >= 2) {
          cells[b].R -= 2;
          cells[b].S2 += 2;
        }
        if (cells[b].S >= 2) {
          cells[b].S -= 2;
        }
      } else if (cells[b].id == 2) {
        cells[b].R += 2;
        if (cells[b].S >= 2) {
          cells[b].S -= 2;
        }
        if (cells[b].S2 >= 2) {
          cells[b].S2 -= 2;
        }
      }
    }


    me = cells[mein];


    a1 = cells[a1in];
    a2 = cells[a2in];

    me.id = mein;
    a1.id = a1in;
    a2.id = a2in;


    StoreMerch mer = rules(me, a1, a2);

    nextgen[mein] = mer.Buyer;
    nextgen[a1in] = mer.Seller;
    nextgen[a2in] = mer.Patient;

    String actor1c = Double.toString(nextgen[mein].C);
    String actor1r = Integer.toString(nextgen[mein].R);
    String actor1s = Integer.toString(nextgen[mein].S);
    String actor1s2 = Integer.toString(nextgen[mein].S2);
    String actor1d = Integer.toString(nextgen[mein].D);


    String actor2c = Double.toString(nextgen[a1in].C);
    String actor2r = Integer.toString(nextgen[a1in].R);
    String actor2s = Integer.toString(nextgen[a1in].S);
    String actor2s2 = Integer.toString(nextgen[a1in].S2);
    String actor2d = Integer.toString(nextgen[a1in].D);


    String actor3c = Double.toString(nextgen[a2in].C);
    String actor3r = Integer.toString(nextgen[a2in].R);
    String actor3s = Integer.toString(nextgen[a2in].S);
    String actor3s2 = Integer.toString(nextgen[a2in].S2);
    String actor3d = Integer.toString(nextgen[a2in].D);



    datrix[0][0] =  "Buyer" + " " + set.get(mein);
    datrix[1][0] = "Capital" + " " + actor1c;
    datrix[2][0] = "Resources" + " " + actor1r;
    datrix[3][0] = " " + "Services" + " " + actor1s  ;
    datrix[4][0] = " " + "Services2" + " " + actor1s2 ;
    datrix[5][0] = " " + "Demand" + " " + actor1d;
    datrix[6][0] = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
    datrix[0][1] = " " + "Seller" + " " + set.get(a1in);
    datrix[1][1] = " " + "Capital" + " " + actor2c;
    datrix[2][1] = " " + "Resources" + " " + actor2r;
    datrix[3][1] = " " + "Services" + " " + actor2s ;
    datrix[4][1] = " " + "Services2" + " " + actor2s2 ;
    datrix[5][1] = " " + "Demand" + " " + actor2d;
    datrix[6][1] = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
    datrix[0][2] = " " + "Patient" + " " + set.get(a2in);
    datrix[1][2] = " " + "Capital" + " " + actor3c;
    datrix[2][2] = " " + "Resources" + " " + actor3r;
    datrix[3][2] = " " + "Services" + " " + actor3s ;  
    datrix[4][2] = " " + "Services2" + " " + actor3s2 ;
    datrix[5][2] = " " + "Demand" + " " + actor3d;
    datrix[6][2] = "!!!!!!!!!!!!!!!!!!!!!!!!";
    printx(datrix);


    fill(0);
    textSize(20);
    textAlign(CENTER, CENTER); 

    cells = nextgen;
  }
}


StoreMerch rules(Merchant a, Merchant b, Merchant c) {


  if (a.R < 1) {
    a.R = 0;
  }
  if (b.R < 1) {
    b.R = 0;
  }
  if (c.R < 1) {
    c.R = 0;
  }
  double to = 0;
  if (b.id == 2 && b.R > 0) {
    to = (double)(a.R + b.R + c.R)/(double)(a.C + b.C + c.C);

    println("Price" + " = " + to);
  }


  if (b.R < 1) {
    to = 0;
  }
  if (b.S > 0 && b.id == 0) {
    to = (((double)(a.S + b.S + c.S)/(double)(a.C + b.C + c.C))*2 + 1) ;

    println("Price" + " = " + to);
  }


  if (b.S2 > 0 && b.id == 1) {
    to = (((double)(a.S2 + b.S2 + c.S2)/(double)(a.C + b.C + c.C))*2 + 2);

    println("Price" + " = " + to);
  }
  if (a.id == 0 && a.S == 0 && b.id == 1 || a.id == 1 && a.S2 == 0 && b.id == 0) {
    to = 0;
  }
  double LOVE = 0;
  double DEMAND = 0;
  switch(b.id) {
  case 0:
    LOVE = G(b.lvs, b.S) ;
    DEMAND = F(a.lvs, LOVE);
    break;
  case 1:
    LOVE = G(b.lvs2, b.S2) ;
    DEMAND = F(a.lvs2, LOVE);

    break;
  case 2:
    LOVE = G(b.lvr, b.R) ;
    DEMAND = F(a.lvr, LOVE);

    break;
  }
  to = to * DEMAND;
  if (a.C < to) {
    if (DEMAND < 1) {
      DEMAND = 1;
    }
    
    to = a.C - (a.C/DEMAND);
    
  }
  boolean succes = (to == 0) ? false : true;

  double newcapital = 0;
  double newcapitalSeller = 0;
  int MaxS = 0;
  int MaxS2 = 0;
  int MaxR = 0;

  if (succes) {

    if (b.S > 0 && b.id == 0) {
      MaxS = (to == 0) ? 0 : (int)(a.C/(to));
      if (MaxS > b.S) {
        MaxS = b.S;
      }

      newcapital = (double)(a.C - MaxS*to);

      newcapitalSeller = (double)(b.C + MaxS*to);
    } else if (b.R > 0 && b.id == 2) {
      MaxR = (to == 0) ? 0 : (int)(a.C/(to));
      if (MaxR > b.R) {
        MaxR = b.R;
      }
      newcapital = (double)(a.C - MaxR*to);

      newcapitalSeller = (double)(b.C + MaxR*to);
    } else if (b.S2 > 0 && b.id == 1) {
      MaxS2 = (to == 0) ? 0 : (int)(a.C/(to));
      if (MaxS2 > b.S2) {
        MaxS2 = b.S2;
      }
      newcapital = (double)(a.C - MaxS2*to);
      newcapitalSeller = (double)(b.C + MaxS2*to);
    }
  }
  if (!(MaxR > 0 || MaxS > 0 || MaxS2 > 0)) {
    b.D = (b.D >= 1) ? b.D - 1 : b.D;
  } else {   
    println("Trade!!!");
    b.D = (b.D <= 10) ? b.D + 1 : b.D;
  }


  Merchant Buyer = new Merchant();
  Merchant Seller = new Merchant();
  Merchant Patient = new Merchant();

  Buyer.C = (succes) ? newcapital : a.C;
  Buyer.R = MaxR + a.R;
  Buyer.S = a.S + MaxS;
  Buyer.S2 = a.S2 + MaxS2;
  Buyer.id = a.id;
  Buyer.D = a.D;
  Buyer.lvr = a.lvr;
  Buyer.lvs = a.lvs;
  Buyer.lvs2 = a.lvs2;
  Seller.C = (succes) ? newcapitalSeller : b.C;
  Seller.R = b.R - MaxR;
  Seller.S = b.S - MaxS;
  Seller.S2 = b.S2 - MaxS2;
  Seller.id = b.id;
  Seller.lvr = b.lvr;
  Seller.lvs = b.lvs;
  Seller.lvs2 = b.lvs2;
  Seller.D = b.D;
  Patient.C = c.C;
  Patient.R = c.R;
  Patient.S = c.S;
  Patient.S2 = c.S2;
  Patient.id = c.id;
  Patient.lvr = c.lvr;
  Patient.lvs = c.lvs;
  Patient.lvs2 = c.lvs2;
  Patient.D = c.D;

  StoreMerch Actor = new StoreMerch();
  Actor.Buyer = Buyer;
  Actor.Seller = Seller;
  Actor.Patient = Patient;


  return Actor;
}
void setup()
{

  size(1600, 1600);
  frameRate(43);
  background(255);
  CA();
}
void draw()
{
  background(64);

  generate();
  for (int i = 0; i < cells.length; i++) {
    if (cells[i].C > 0) fill(0);
    else               fill(255);

    rect(i*w*20, w*2, w*10, w*10);
  }
}
class Merchant
{
  int  R, S, S2, id, D;
  int lvr, lvs, lvs2;
  double C;
}

class StoreMerch {
  Merchant Buyer, Seller, Patient;
}
void printx(String[][] arr) {
  for (int row = 0; row < arr.length; row++)//Cycles through rows
  {
    for (int col = 0; col < arr[row].length; col++)//Cycles through columns
    {
      System.out.printf("%5s", arr[row][col]); //change the %5d to however much space you want
    }
    System.out.println(); //Makes a new row
  }
}


class LevelsOfCost {
  int nb, ns;
}
