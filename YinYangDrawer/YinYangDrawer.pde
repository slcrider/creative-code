import themidibus.*;

MidiBus myBus;

int frames = 180;

final color BLACK = color(0);
final color WHITE = color(0);

color colorYin = BLACK;
color colorYang = WHITE;
color innerYin = BLACK;
color innerYang = WHITE;
color midYin = BLACK;
color midYang = WHITE;

float red = 0;
float green = 0;
float blue = 0;
float theta = 0;

YinYang bigBoy;
YinYang yinBoy;
YinYang yangBoy;

void setup() {
    //size(540, 540, P2D);
    fullScreen(P2D);
    MidiBus.list();
    myBus = new MidiBus(this, 0, 1);
    smooth(8);
    noStroke();
    bigBoy = new YinYang(width/2, width/2, height/2);
    yinBoy = new YinYang(bigBoy.getSmallDiam(), width/2 + bigBoy.getXAdj(), height/2 - bigBoy.getYAdj());
    yangBoy = new YinYang(bigBoy.getSmallDiam(), width/2 + bigBoy.getXAdj(), height/2 + bigBoy.getYAdj());
}

void draw() {
    background(#35465c);
    //translate(width/2, height/2);
    colorMode(RGB);
    stroke(255);
    //rotate(theta);

    noStroke();
    //background(red, green, blue);
    bigBoy.render();
    colorMode(HSB);

    yinBoy.setXTrans(width/2 + bigBoy.getXAdj());
    yinBoy.setYTrans(height/2 - bigBoy.getYAdj());
    yinBoy.render();
    yinBoy.update();

    yangBoy.setXTrans(width/2 - bigBoy.getXAdj());
    yangBoy.setYTrans(height/2 + bigBoy.getYAdj());
    yangBoy.render();
    yangBoy.update();

    bigBoy.update();
    bigBoy.updateFill();
    //theta--;
    //theta %= 360;
}

void controllerChange(int channel, int number, int value) {
    println("Chan: " + channel);
    println("Num: " + number);
    println("Val: " + value);
    if (number == 3) {
        red = map(value, 0, 127, 0, 255);
    } else if (number == 9) {
        green = map(value, 0, 127, 0, 255);
    } else if (number == 12) {
        blue = map(value, 0, 127, 0, 255);
    }
    println("RGB: " + red, ", " + green + ", " + blue);
}
