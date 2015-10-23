package pr2;

public class Vector {
	protected double vector[];

	// constructor
	public Vector(int length) {
		this.vector = new double[length];
	}

	// size of vector (N of elements)
	public int vectorLength() {
		return vector.length;
	}

	// get vector element in spec position
	public double getElement(int num) {
		return vector[num];
	}

	// get vector element in spec position
	public void setElement(int num, double value) {
		vector[num] = value;
	}

	// fill vector with values from given array
	public void fillVectorWithArray(double[] array) {
		if (vector.length != array.length) {
			System.err.println("Must be the same size!");
		} else {
			for (int i = 0; i < array.length; i++) {
				vector[i] = array[i];
			}
		}
	}

	// fill vector from another vector object
	public void fillVectorWithVector(Vector v) {
		if (vector.length != v.vectorLength()) {
			System.err.println("Must be the same size!");
		} else {
			for (int i = 0; i < vector.length; i++) {
				vector[i] = v.getElement(i);
			}
		}
	}

	// comparator with another vector
	public boolean compareTo(Vector v1) {
		if (vector.length != v1.vectorLength()) {
			return false;
		} else

		{
			for (int i = 0; i < vector.length; i++) {
				if (vector[i] != (v1.getElement(i))) {
					return false;

				}
			}
		}

		return true;
	}

	//get min value in vector
	public double getMin(){
		double[] vectorCopy = vector.clone();
		Sort.sort(vectorCopy);
		return vectorCopy[0];
	}
	
	//get max value in vector
	public double getMax(){
		double[] vectorCopy = vector.clone();
		Sort.sort(vectorCopy);
		return vectorCopy[vectorLength()-1];
	}
	
	//sort vector in asc
	public void sortVector(){
		Sort.sort(vector);
	}
	
	//multiply per number
	public void multiplyPerNumber(double num){
		for (int i = 0; i < vector.length; i++) {
			vector[i] = vector[i]*num;
		}
	}
	
	// sum two vectors
	public void sumWithVector(Vector v) {
		if (vector.length != v.vectorLength()) {
			System.err.println("Must be the same size!");
		} else {
			for (int i = 0; i < vector.length; i++) {
				vector[i] = vector[i]+v.getElement(i);
			}
		}

	}
	
	
	//print vector content
	private static void show(Vector vector) {
		for (int i = 0; i < vector.vectorLength(); i++) {
			System.out.print(vector.getElement(i)+" ");
			
		}
		System.out.println();
	}
	
	
//	public static void main(String[] args) {
//		// TODO Auto-generated method stub
//		double[] cats = { 2, 5, 7, 8, 3, 1 };
//		Vector v = new Vector(cats.length);
//		v.fillVectorWithArray(cats);
//		show(v);
//		Vector v2 = new Vector(cats.length);
//		v2.fillVectorWithVector(v);
//
//		System.out.println();
//		v2.setElement(2, 5);
//
//
//		System.out.println();
//		System.out.println(v.compareTo(v2));
//		System.out.println(v.getMin());
//		System.out.println(v.getMax());
//		v.sortVector();
//		show(v);
//		v.sumWithVector(v2);
//		show(v);
//		
//	}

}
