/* [General] */


// Part to print
part="team2"; // [pawn2:Pawn,rook2:Rook,knight:Knight,bishop2:Bishop,queen2:Queen,king2:King,oneEach:One of each,pawns:8 Pawns,specials:2of Each Special,royals:Royals,team2:Whole Team,all:Whole Shabang,pillars:only Pillars,neck:only Neck]
// Pillar Type
pillar_type="twisty"; // [twisty:Twisty,teepee:Tee-pee Style,full:FullCone]
knight_style="knight2"; // [knight2:org.Knight,knight_maf:smallerFace,both_knight:show both]
figure_style="both"; // [both:Pillar and Head,pillar:Only Pillar,Head:Only Head]
// rods number
rods =4; // [0:1:12]
// how many twists-factor do you want
twister =5; // [0:0.2:50]
// Square Size in Inches
square_size=2; // [1.5:1-1/2",1.75:1-3/4",2:2" (No. 4),2.25:2-1/4" (No. 5),2.5:2-1/2" (No. 6)]
// Base Height (needs to be higher than magnet height)
base_height=10;
// Base Fragment resolution
bfn=5; // [5:1:80]

/* [Magnet] */
// Add hole for magnet
domag=1; // [1:Yes,0:No]
// Magnet form
round=0; // [1:round,0:square]
// Magnet Hole Size (remember to oversize by 0.2 or so for clearance)
magw=9.5; // [0:0.2:50]
// Magnet Height
magh=4; // [0:.2:20]
// Magnet Length
maglegth= 8; // [0:.2:20]

/* [Hidden] */

mag=(domag*magw);
square=square_size*25.4;
white=[0.9,0.9,0.9];
black=[0.3,0.3,0.3];

*rook2();
*translate([square,0]) knight2();
*translate([square*2,0]) bishop2();



if(part=="pillars") pillars();
else if(part=="neck") neck();
else if(part=="pawn2") pawn2();
else if(part=="rook2") rook2();
else if(part=="knight") knight_switch();
else if(part=="bishop2") bishop2();
else if(part=="queen2") queen2();
else if(part=="king2") king2();
else if(part=="board") board();
else if(part=="oneEach") {
  translate([square*0,square*0]) queen2();
  translate([square*0,square*1]) king2();
  translate([square*1,square*0]) knight_switch();
  translate([square*1,square*1]) rook2();
  translate([square*0,square*2]) bishop2();
  translate([square*1,square*2]) pawn2();
  //translate([square*2,square*2]) pillars();
}
else if(part=="pawns") pawns();
else if(part=="royals") royals();
else if(part=="specials") specials();
    
else if(part=="team2") {
  royals();
  specials();
    pawns();

    
  //translate([square*2,square*2]) pillars();
}
else if(part=="all") {
  board();
  for(y=[0,square*7]) {
    color(y==0?white:black) team(y);
  }
}

module royals(){
      translate([square*0,square*3]) queen2();
  translate([square*1,square*3]) king2();
    }
module specials(){
    for(x=[0:1]){
      translate([square*x,square*0]) rook2();
      translate([square*x,square*1]) knight_switch();
      translate([square*x,square*2]) bishop2();
    }    
}
module pawns(){
          for(x=[2:3]) {
    for(y=[0:3]) {
        translate([square*x,square*y]) pawn2();
        }
    }
}

module board() {
  for(x=[0:7]) {
    for(y=[0:7]) {
      translate([(x-4)*square-square/2,y*square-square/2,-10]) color(x%2==y%2?black:white) cube([square,square,10]);
    }
  }
}
module team(y=0) {
  for(p=[-4:3])
      translate([p*square,y==0?square:square*6]) pawn2();
  translate([square*-4,y]) rook2();
  translate([square*-3,y]) rotate([0,0,y==0?90:-90]) knight_switch();
  translate([square*-2,y]) rotate([0,0,y==0?90:-90])bishop2();
  translate([square*-1,y]) queen2();
  translate([0,y]) king2();
  translate([square,y])rotate([0,0,y==0?90:-90]) bishop2();
  translate([square*2,y]) rotate([0,0,y==0?90:-90]) knight_switch();
  translate([square*3,y]) rook2();
}

module knight_switch(){
    if (knight_style=="knight_maf")
        knight_maf();
    else if (knight_style=="both_knight"){
        translate([0,square*0.25]) knight_maf();
    translate([0,square*-0.25]) knight2();}
    else knight2();
    }

module pawn2(bd=square*.5,th=square*.9,mag=mag) {
  *base(d=bd*1.1,mag=mag);
  pillars(d=bd-2,midh=th-20,t=bd*.2,baseD=bd*1.1);
  if((figure_style=="both")||(figure_style=="Head"))translate([0,0,th-10-(10-base_height)]) {
    neck(d=bd*.8);
    translate([0,0,bd*.35]) sphere(d=bd*.7,$fn=bfn*2);
  }
}
module bishop2(bd=square*.65,th=square*1.25,mag=mag) {
  echo(str("Bishop BD: ",bd," TH: ",th)); // 33.02 63.5
  *base(d=bd,mag=mag);
  // sloppy!
  poff=(square_size==2.5?0:
      (square_size==2.25?2.1:
      (square_size==2?4.5:
      (square_size==1.75?6.8:
      (square_size==1.5?9:0)))));
  pillars(d=bd*.88,midh=th*.7-poff,t=bd*.182,baseD=bd);
  if((figure_style=="both")||(figure_style=="Head"))translate([0,0,th-14-(10-base_height)]) {
    neck(d=bd*(23/33));
    translate([0,0,th*.1574]) scale(bd/33) intersection() {
      translate([0,0,-10]) cylinder(d=30,h=34);
      difference(){
        scale([.8,.8,1.4]) sphere(12,$fn=bfn*1.2);
        translate([2,12,2]) rotate([0,10]) rotate([90,0]) linear_extrude(30) polygon([[0,0],[3,20],[8,20],[2,1]]);
        translate([7,-5,9]) cube(10);
      }
    }
    translate([0,0,bd*(28/33)]) sphere(bd*(4/33),$fn=bfn);
  }
}
module knight_maf(bd=square*.68,th=square*1.2,mag=mag) {
  *base(d=bd,mag=mag);
  echo(str("Knight BD: ",bd," TH: ",th));
  // 34.54 60.96
  pillars(d=bd*.94,midh=th*.639,t=bd*.2,baseD=bd);
  if((figure_style=="both")||(figure_style=="Head"))
  translate([0,0,base_height]) //scale([1,0.75,1])
  {
    translate([0,0,th*.672]) {
      translate([0,0,th*-.04]) neck(d=bd*.77);
      translate([0,0,th*-.197]) scale(bd*.0246) intersection() {
        //translate([0,0,10]) cylinder(d=50,h=50,$fn=30);
        translate([-17,7]) rotate([90,0]) linear_extrude(14,convexity=10) horse_profile_maf(0.25);
translate([-2.5, -8, 5])
            rotate([122.1, 0, 90])
      linear_extrude(height = 65, convexity = 20, center = true)
        horse_face_maf(0.20);
      }
      if(version()[0]>=2016)
      {
        translate([bd*-.0434,(bd*.032),th*.1642]) rotate([90,0]) rotate([0,0,70]) scale(bd*.02895) {
          rotate_extrude(angle=180) translate([12,1]) scale([1.2,0.5]) circle(d=5,$fn=bfn);
        }
      }
    }
  }
  *knight();
}

module horse_face_maf(scale=0.1) {
  half=[[0,0],[12,28],[12,36],[12,56],[12,70],[22,92],
  [22,93],[22,96],[12,106],[11,112],[11,132],[14,141],[16,145],[20.3,151.8],
  [19.8,156],[20,160],[20.5,163.3],[21.7,164.7],[23.7,164.2],[26,162],[27,160.5],[28.1,159],[31.8,152.55],
  [35.3,152.3],[34.9,155],[34.8,160],[35.2,162],[36,164.2],[37,166.2],[39.4,168.2],[41,169]];
full=concat(half,[for(i=[len(half)-2:-1:0])[82-half[i][0],half[i][1]]]);
  scale(scale)
  polygon(full);
}
module horse_profile_maf(scale=0.1)
{
  scale(scale)
polygon([
 //[15,0],[25,20],[29,36],[20,55],
  [15,40],
  [18,58],
  [18,90],[10,120],[10,135],[20,150],[40,162],
  [66,168],[71,158],[74,155],[80,150],[84,147],[100,127],[110,110],
  [120,102],[118,90],[108,83],//[98,90],
  [100,80],[70,96],[60,93],[73,90],[80,88],
  [102,80],//[108,70],
  [110,60],[120,40],[15,40]
  //[125,0]
  ],[concat([for(i=[0:15])i],[for(i=[22:30])i]),[17,18,19,20]]);
}
module knight2(bd=square*.68,th=square*1.2,mag=mag) {
  *base(d=bd,mag=mag);
  echo(str("Knight BD: ",bd," TH: ",th));
  // 34.54 60.96
  pillars(d=bd*.94,midh=th*.639,t=bd*.2,baseD=bd);
  if((figure_style=="both")||(figure_style=="Head"))translate([0,0,base_height]) //scale([1,0.75,1])
  {    
    translate([0,0,th*.672]) {
      translate([0,0,th*-.04]) neck(d=bd*.77);
      translate([0,0,th*-.197]) scale(bd*.0246) intersection() {
        //translate([0,0,10]) cylinder(d=50,h=50,$fn=30);
        translate([-17,7]) rotate([90,0]) linear_extrude(14,convexity=10) horse_profile(0.25);
        translate([0, 0, 14])
        rotate([0, 12, 0])
          translate([0, 0, -9.5])
        rotate([110, 0, 90])
    translate([-8, 0, 0])
      linear_extrude(height = 65, convexity = 20, center = true)
        horse_face(0.20);
      }
      if(version()[0]>=2016)
      {
        translate([bd*-.0434,bd*.0434,th*.1642]) rotate([90,0]) rotate([0,0,70]) scale(bd*.02895) {
          rotate_extrude(angle=180) translate([12,1]) scale([1.2,0.5]) circle(d=5,$fn=bfn);
        }
      }
    }
  }
  *knight();
}
module horse_face(scale=0.1) {
  half=[[0,0],[1,28],[2,36],[6,56],[10,70],[18,92],
  [17,93],[15,96],[12,106],[11,112],[11,132],[14,141],[16,145],[20.3,151.8],
  [19.8,156],[20,160],[20.5,163.3],[21.7,164.7],[23.7,164.2],[26,162],[27,160.5],[28.1,159],[31.8,152.55],
  [35.3,152.3],[34.9,155],[34.8,160],[35.2,162],[36,164.2],[37,166.2],[39.4,168.2],[41,169]];
full=concat(half,[for(i=[len(half)-2:-1:0])[82-half[i][0],half[i][1]]]);
  scale(scale)
  polygon(full);
}
module horse_profile(scale=0.1)
{
  scale(scale)
polygon([
 //[15,0],[25,20],[29,36],[20,55],
  [15,40],
  [18,58],
  [1,100],[2,120],[8,135],[20,150],[40,162],
  [66,168],[71,158],[74,155],[80,150],[84,147],[100,127],[110,110],
  [120,102],[118,90],[108,83],//[98,90],
  [100,80],[70,96],[60,93],[73,90],[80,88],
  [102,80],//[108,70],
  [110,60],[120,40],[15,40]
  //[125,0]
  ],[concat([for(i=[0:15])i],[for(i=[22:30])i]),[17,18,19,20]]);
}
module queen2(bd=square*.725,th=square*1.65,mag=mag) {
  points=6;
  pd=360/points;
  *base(d=bd*1.1,mag=mag);
  hh=bd*.6;
  echo(str("Queen BD: ",bd," TH: ",th));
  pillars(d=bd-2,midh=th-31,t=8,baseD=bd*1.1);
  if((figure_style=="both")||(figure_style=="Head"))translate([0,0,th-21-(10-base_height)]) {
    neck(d=bd*.8);
    difference(){
      cylinder(d1=bd*.43,d2=bd*.73,h=hh,$fn=bfn*1.5);
      translate([0,0,hh-(bd*.2)]) cylinder(d1=10,d2=bd*.62,h=bd*.2+.01,$fn=bfn);
      translate([0,0,hh]) for(r=[0:points-1])
        rotate([0,0,r*pd+pd/2]) translate([bd*.29,0]) sphere(bd*.12,$fn=bfn);
    }
    *translate([0,0,20]) for(r=[0:points-1])
      rotate([0,0,r*pd]) translate([bd/2-7,0]) sphere(2.5,$fn=bfn);
    //translate([0,0,hh-6]) cylinder(d1=bd*.457,d2=bd*.125,h=6,$fn=bfn);

    
    for(r=[0:points-1])rotate([0,0,r*pd])translate([0,bd*.1,hh-(bd*.125)/2])rotate([60,0,0]) sphere(r=bd*.125,$fn=bfn);
    translate([0,0,hh+(bd*.125)]) sphere(bd*.125,$fn=bfn);

  }
}

module king2(bd=square*.76,th=square*1.75,mag=mag) {
  *base(d=46,mag=mag);
  echo(str("King BD: ",bd," TH: ",th));
  pillars(d=bd-2,midh=th-31,t=9,baseD=46);
  if((figure_style=="both")||(figure_style=="Head"))translate([0,0,th-21-(10-base_height)]) {
    neck(d=bd-8);
    difference(){
      cylinder(d1=bd-20,d2=bd-10,h=20,$fn=bfn*1.5);
      translate([0,0,16]) cylinder(d1=10,d2=bd-14,h=4.01);
    }
    translate([0,0,16]) cylinder(d1=bd-14,d2=2,h=8);
    rotate([0,0,90])translate([bd*-.2,-3,22]) minkowski()
    {
      sphere(1,$fn=bfn);
      difference() {
      cube([bd*.42,bd*.155,bd*.42]);
      for(r=[45:90:360])
        translate([bd*.21,bd*.2,bd*.2]) rotate([0,r,0]) translate([bd*-.259,0,0]) rotate([90,0]) {
          if(r<=180)
            cylinder(d=10,h=10,$fn=bfn);
          else
            translate([-1.4,0,5]) cube(10,center=true);
        }
    }
  }
  }
}
module rook2(bd=square*.7,th=square*1.2,mag=mag) {
  bdf=35.6;
  thf=60.96;
  // sloppy!
  poff=(square_size==2.5?-2.2:
      (square_size==2.25?-1.1:
      (square_size==2?0:
      (square_size==1.75?1.1:
      (square_size==1.5?2.2:0)))));
  echo(str("Rook BD: ",bd," TH: ",th," Poff: ",poff)); // 35.56 60.96
  *cylinder(d=bd,h=10,$fn=bfn);
  *base(d=bd);
  pillars(d=bd*.972,midh=th*.71-poff,t=bd*(7/bdf),baseD=bd);
  if((figure_style=="both")||(figure_style=="Head"))translate([0,0,th*.8686+(base_height-10)]) {
    difference(){
      union(){
        neck(d=bd*.775);
        cylinder(d=bd*.775,h=th/10,$fn=bfn*2);
        left=((bd*.775)/2)-((bd*.5)/2)-1.9;
        // SLOW:
        *rotate_extrude($fn=bfn*2) minkowski() {
          circle(1,$fn=20);
          translate([10,0]) square([((bd-8)/2)-11,6]);
        }
        if(version()[0]>=2016) {
          for(r=[0:60:360]) rotate([0,0,r]) 
            translate([0,0,th/10.2]) {
              rotate_extrude(angle=30,$fn=bfn) {
                translate([bd*.247,0,0]) minkowski()
                {
                  circle(1,$fn=bfn);
                  translate([1,0]) square([left,th*(4/thf)]);
                }
              }
            }
         } else {
           difference() {
              translate([0,0,th/10.2]) rotate_extrude($fn=50) {
                translate([((bd-18)/2),0,0]) minkowski() {
                  circle(1,$fn=20);
                  translate([1,0]) square([3,4]);
                }
              }
              translate([0,0,th/10.2]) for(r=[0:60:180-1]) rotate([0,0,r]) translate([bd*-.1,bd*-.8,0]) cube([bd*.2,bd*1.5,th]);
           }
        }
        //rotate_extrude(angle=10) polygon([[0,1],[0,3],[1,4]]]);
      }
      translate([0,0,th*(4/thf)]) cylinder(d=bd*.5,h=th*(4/thf),$fn=bfn);
    }
  }
  *#cylinder(d=35,h=60,$fn=50);
  *#rook(0);
}
module base(d=40,h=base_height,r=2,mag=mag) {
    h = h+.3; //to make base get into pillar2
  difference(){
    rotate_extrude($fn=bfn*2.2) union(){
    polygon([[0,h+3],[d/2-r+.2,h],[d/2+.017,h-r],[d/2,r],[d/2-r,0],[0,0]]);
    translate([d/2-r,h-r]) circle(r=r+.017,$fn=bfn*2.2);
    translate([d/2-r,r]) circle(r=r,$fn=bfn*2.2);
    };
    if((mag) && (round))
    {
        translate([0,0,-0.01]) cylinder(d=mag,h=magh,$fn=bfn);
    } else if(mag)
    {
        translate([0,0,(magh/2)-.01]) cube([magw,maglegth,magh],center = true);
    }

  }

}
module neck(d=26,h=12,r=2) {
  
rotate_extrude($fn=bfn*1.5)
union(){
  polygon([[0,h/2],[1,h/2-.1],[d/2-r,r+.05],[d/2-.5,0.88],[d/2,0],[d/2-.5,-0.88],[d/2-r,-1*r-.05],[4,h*-.199],[0,h*-.2]]);
  translate([d/2-r,0]) circle(d=r*2,$fn=bfn);
}
}

module pillars(d=38,rods = rods,midh=48,t=8,baseD=square*.65)
{
  if(pillar_type=="twisty")
    pillars3(d,rods,midh,t,baseD);
  else if(pillar_type=="full")
    pillars3(d,rods,midh,t,baseD);  
  else if(pillar_type=="teepee") {
  od=d*.75;
//  cylinder(d=5,h=midh,$fn=20);
  translate([0,0,(midh-10)]) cylinder(d1=5,d2=od,h=8,$fn=50);
  ry=d/2-4;
  rdeg=atan(ry/midh);
  rz=sqrt(pow(ry,2)+pow(midh,2));
  for(r=[1:rods])
    rotate([0,0,r*(360/rods)])
      translate([0,ry,0]) rotate([rdeg,0]) cylinder(d=5,h=rz,$fn=20);
  }
}
module pillars3(d=38,rods=8,midh=48,t=8,baseD=square*.65)
{
   if((figure_style=="both")||(figure_style=="Head")){
  difference()
  {
  base(baseD,mag=mag);
      translate([0,0,base_height]) pillars2(d,rods,midh,t);
}
  
  translate([0,0,base_height]) 
  difference()
    {
      translate([0,0,midh])cone(d);
      pillars2(d,rods,midh,t);
    }
}

//figure_style="both"; // [both:Pillar and Head,pillar:Only Pillar,Head:Only Head]


if((figure_style=="both")||(figure_style=="pillar")){
    linear_extrude(.01)circle(.01);
  color("red",1.0)translate([0,0,base_height]) 
    pillars2(d,rods,midh,t);
}
}
module pillars2(d=38,rods=8,midh=48,t=8)
{
      if(pillar_type=="full")translate([0,0,0])cylinder(d1=d*.95,d2=d*.5,h=midh,$fn=bfn);
  twist=midh*twister;
  //twist = twister;
  echo(str("Building Pillars D:",d," H:",midh," T:",t));
  deg=360/rods;
  intersection(){
    cylinder(d=d,h=midh-4);
    for(r=[1:rods])
      rotate([0,0,r*deg]) linear_extrude(height = midh*2, twist = twist, $fn=200, scale=0)
         translate([d/2-t, 0, 0])
           rotate(10) gustav(t-3);
    //circle(d=t,$fn=20);
    //circle(d=t,$fn=bfn/2);
  }
  supx=d/4;
  supz=midh-supx-1;
  *for(r=[1:rods])
  { // t = 5, ex = 12
    rotate([0,0,r*deg+25])
    translate([1,0,supz]) rotate([10,0])
      rotate([90,0,0]) linear_extrude(t*.6) polygon([[0,supx],[supx,supx],[supx,0]]);
  }
  
}
module gustav(t=8){
    r = 1.1;
    minkowski(){square(t-r+1);circle(r,$fn=bfn);}
}

module cone(dCone=38) {
  difference() {
  translate([0,0,-6]) cylinder(d1=dCone*.5,d2=dCone*.75,h=4,$fn=bfn);
  translate([0,0,-6.01]) cylinder(d1=14,d2=4,h=3);
  }
}