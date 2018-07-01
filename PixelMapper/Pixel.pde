public class Pixel {
    private PShape mesh;
    private PShape[] meshComponents;
    private int size;
    private PVector origin;
    
    public Pixel() {
        this.size = 100;
        origin = new PVector(0,0);
        createMesh();
    }
    
    public Pixel(int size, int x, int y) {
        this.size = size;
        this.origin = new PVector(x, y);
        createMesh();
    }
    
    public void setColor(color c) {
        mesh.setFill(c);
        for (int i = 0; i < meshComponents.length; i++) {
            meshComponents[i].setFill(c);
        }
    }

    
    private void createMesh() {
        mesh = createShape(GROUP);
        meshComponents = new PShape[5];
        meshComponents[0] = createShape(RECT, origin.x, origin.y, size, size);
        meshComponents[1] = createShape(RECT, origin.x - size, origin.y, size, size);
        meshComponents[2] = createShape(RECT, origin.x, origin.y - size, size, size);
        meshComponents[3] = createShape(RECT, origin.x + size, origin.y, size, size);
        meshComponents[4] = createShape(RECT, origin.x, origin.y + size, size, size);
        for (int i = 0; i < meshComponents.length; i++) {
            mesh.addChild(meshComponents[i]);
        }
    }
    
    public void render() {
        shape(mesh);
    }
}