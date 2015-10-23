package pr2;

import static org.junit.Assert.*;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

public class VectorTest {

    public VectorTest() {
        
    }
      
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }

    /**
     * Test of setElement method, of class Vector.
     */
    @Test
    public void testSetElement() {
        System.out.println("setElement");
        int index = 3;
        double value = 0.7;
        Vector instance = new Vector(5);
        instance.setElement(index, value);
        assertEquals(value, instance.vector[index], 0.0);
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of getElement method, of class Vector.
     */
    @Test
    public void testGetElement() {
        System.out.println("getElement");
        int index = 3;
        Vector instance = new Vector(5);
        double expResult = 0.7;
        instance.vector[index] = expResult;
        double result = instance.getElement(index);
        assertEquals(expResult, result, 0.0);
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of fillFromMass method, of class Vector.
     */
    @Test
    public void fillVectorWithArray() {
        System.out.println("fillVectorWithArray");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] oldMass = {0.0, 0.9, -6.4, 8, -0.4};
        Vector instance = new Vector(5);
        instance.vector = oldMass;
        instance.fillVectorWithArray(mass);
        for (int i = 0; i < 5; i++) {
            assertEquals(mass[i], instance.vector[i], 0.0);
        }
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of fillVectorWithVector method, of class Vector.
     */
    @Test
    public void testFillFromVector() {
        System.out.println("fillVectorWithVector");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] oldMass = {0.0, 0.9, -6.4, 8, -0.4};
        Vector instance = new Vector(5);
        instance.vector = oldMass;
        Vector vector = new Vector(5);
        vector.vector = mass;
        instance.fillVectorWithVector(vector);
        for (int i = 0; i < 5; i++) {
            assertEquals(mass[i], instance.vector[i], 0.0);
        }
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of compareTo method, of class Vector.
     */
    @Test
    public void testCompareTo() {
        System.out.println("compareTo");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] newMass = {0.0, 0.9, -6.4, 8, -0.4};
        double[] newOldMass = {5.0, -2.9, 0.0, -50000, 9};
        Vector instance = new Vector(5);
        instance.vector = mass;
        Vector vector = new Vector(5);
        vector.vector = newMass;
        boolean expResult = false;
        boolean result = instance.compareTo(vector);
        assertEquals(expResult, result);
        
        vector.vector = newOldMass;
        expResult = true;
        result = instance.compareTo(vector);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of getSize method, of class Vector.
     */
    @Test
    public void vectorLength() {
        System.out.println("vectorLength");
        int expResult = 5;
        Vector instance = new Vector(expResult);
        int result = instance.vectorLength();
        assertEquals(expResult, result);
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of getMax method, of class Vector.
     */
    @Test
    public void testGetMax() {
        System.out.println("getMax");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        Vector instance = new Vector(5);
        instance.vector = mass;
        double expResult = 9;
        double result = instance.getMax();
        assertEquals(expResult, result, 0.0);        
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of getMin method, of class Vector.
     */
    @Test
    public void testGetMin() {
        System.out.println("getMin");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        Vector instance = new Vector(5);
        instance.vector = mass;
        double expResult = -50000;
        double result = instance.getMin();
        assertEquals(expResult, result, 0.0);
        //fail("The test case is a prototype.");
    }

    /**
     * Test of sortVector method, of class Vector.
     */
    @Test
    public void testSortVector() {
        System.out.println("sortVector");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] sortedMass = {-50000, -2.9, 0.0, 5.0, 9};
        Vector instance = new Vector(5);
        instance.vector = mass;        
        instance.sortVector();
        for (int i = 0; i < 5; i++) {
            assertEquals(sortedMass[i], instance.vector[i], 0.0);
        }

        //fail("The test case is a prototype.");
    }
    
    
    /**
     * Test of multiplyPerNumber method, of class Vector.
     */
    @Test
    public void multiplyPerNumber() {
        System.out.println("multiplyPerNumber");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] resultMass = {10.0, -5.8, 0.0, -100000, 18};
        Vector instance = new Vector(5);
        instance.vector = mass;
        double number = 2;
        instance.multiplyPerNumber(number);
        for (int i = 0; i < 5; i++) {
            assertEquals(resultMass[i], instance.vector[i],  0.00000000001);
        }
        //fail("The test case is a prototype.");
    }
    
    /**
     * Test of sumWithVector method, of class Vector.
     */
    @Test
    public void testSumWithVector() {
        System.out.println("sumWithVector");
        double[] mass = {5.0, -2.9, 0.0, -50000, 9};
        double[] newMass = {1.1, 0.9, -6.4, 100, -9.4};
        double[] resultMass = {6.1, -2.0, -6.4, -49900, -0.4};
        Vector instance = new Vector(5);
        instance.vector = mass;
        Vector vector = new Vector(5);
        vector.vector = newMass;
        instance.sumWithVector(vector);
        for (int i = 0; i < 5; i++) {
            assertEquals(resultMass[i], instance.vector[i], 0.00000000001);
        }
        //fail("The test case is a prototype.");
    }


}
