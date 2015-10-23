package pr4.vector.impl;

import static org.junit.Assert.assertArrayEquals;

public class VectorImpl extends ArrayVector {

    public VectorImpl(int size) {
        super(size);
    }
    
    public double[] getData() {
        return super.vector;
    }
    
    public void setData(double[] data) {
        super.vector = data;
    }
public static void main(String[] args){
	
    double[] mass = {5.0, -2.9, 0.0, -50000, 9};
    double[] mass1 = {5.0, -2.9, 0.0, -50000, 9, 7.7};
    double[] mass2 = {5.0, -2.9, 7.7, 0.0, -50000, 9};
    double[] mass3 = {7.7, 5.0, -2.9, 0.0, -50000, 9};
    double element = 7.7;
    int index1 = 5;
    int index2 = 2;
    int index3 = 0;
    VectorImpl instance1 = new VectorImpl(5);
    instance1.setData(mass);
    VectorImpl instance2 = new VectorImpl(5);
    instance2.setData(mass);
    VectorImpl instance3 = new VectorImpl(5);
    instance3.setData(mass);
    // Act
    instance1.insertElement(index1, element);
    instance2.insertElement(index2, element);
    instance3.insertElement(index3,element);
    show(instance1);
    // Assert
    assertArrayEquals(mass1, instance1.getData(), 0.0);
    assertArrayEquals(mass2, instance2.getData(), 0.0);
    assertArrayEquals(mass3, instance3.getData(), 0.0);
	
	

    // Assert
//    assertArrayEquals(newMass, instance.getData(), 0.0);
}
}

