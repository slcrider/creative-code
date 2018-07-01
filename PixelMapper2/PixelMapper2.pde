import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;

final color[] COLORS = {color(0,0,0),
                        color(147,57,0),
                        color(0,212,90),
                        color(59,0,195)};
ArrayList<Integer> color_index = new ArrayList<Integer>();
ArrayList<Pixel> pixel_map = new ArrayList<Pixel>();

MidiBus myBus;

int midiDevice = 0;

void setup() {
    size(600,600);
    int pixel_size = width / 4; 
    blendMode(ADD);
    noStroke();
    background(0);
    int counter = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            pixel_map.add(new Pixel(pixel_size, i * (width / 4), j * (height / 4)));
            color_index.add(int(random(0, COLORS.length)));
            pixel_map.get(counter).setColor(COLORS[color_index.get(counter)]);
            counter++;
        }
    }
    
    
    MidiBus.list();
    myBus = new MidiBus(this, midiDevice, 1);
}

void draw() {
 
    background(0);
    stroke(255);
    fill(255);

    for (int i = 0; i < pixel_map.size(); i++) {
        try {
            pixel_map.get(i).render();
        } catch(Exception e) {
            println(i + " " + e.toString());
        }
    }
    //for (int i = 0; i < width; i += width/4) {
    //    line(i, 0, i, height);
    //}
    //stroke(255, 0, 0);
    //for (int i = 0; i < height; i += height/4) {
    //    line(0, i, width, i);
    //}
    //fill(255, 0, 0);
    //rect(0,0,250,600);
    //fill(0, 255, 0);
    //rect(200,0,250,600);
    //fill(0, 0, 255);
    //rect(400,0,250,600);
    //fill(COLORS[color_index]);
    //rect(100, 100, 400, 400);
    //fill(COLORS[color_index[0]]);
    //rect(0,0,400,400);
    //fill(COLORS[color_index[1]]);
    //rect(0,200,400,400);
    //fill(COLORS[color_index[2]]);
    //rect(200,0,400,400);
    //fill(COLORS[color_index[3]]);
    //rect(200,200,400,400);
}

//void keyPressed() {
//    //if (key == ' ') {
//    //    color_index++;
//    //    color_index %= COLORS.length;
//    //}
//    if (keyCode == LEFT) {
//        color_index[0]++;
//        color_index[0] %= COLORS.length;
//    }
//    if (keyCode == UP) {
//        color_index[1]++;
//        color_index[1] %= COLORS.length;
//    }
//    if (keyCode == RIGHT) {
//        color_index[2]++;
//        color_index[2] %= COLORS.length;
//    }
//    if (keyCode == DOWN) {
//        color_index[3]++;
//        color_index[3] %= COLORS.length;
//    }
//}

void midiMessage(MidiMessage message, long timestamp, String bus_name) {
    int note = (int)(message.getMessage()[1] & 0xFF);
    println("Bus " + bus_name + ": Note "+ note);
    if (note == 48) {
        updateColor(0);
    } else if (note == 49) {
        updateColor(1);
    } else if (note == 50) {
        updateColor(2);
    } else if (note == 51) {
        updateColor(3);
    } else if (note == 44) {
        updateColor(4);
    } else if (note == 45) {
        updateColor(5);
    } else if (note == 46) {
        updateColor(6);
    } else if (note == 47) {
        updateColor(7);
    } else if (note == 40) {
        updateColor(8);
    } else if (note == 41) {
        updateColor(9);
    } else if (note == 42) {
        updateColor(10);
    } else if (note == 43) {
        updateColor(11);
    } else if (note == 36) {
        updateColor(12);
    } else if (note == 37) {
        updateColor(13);
    } else if (note == 38) {
        updateColor(14);
    } else if (note == 39) {
        updateColor(15);
    }
}

void updateColor(int index) {
    color_index.set(index, color_index.get(index) + 1);
    color_index.set(index, color_index.get(index) % COLORS.length);
    pixel_map.get(index).setColor(COLORS[color_index.get(index)]);
}