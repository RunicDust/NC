package pr3;

public class ArrayVector implements Vector  {
	protected double vector[];

	// constructor
	public ArrayVector(int length) {
		this.vector = new double[length];
	}

	@Override
	public int getSize() {
		return vector.length;
	}

	// get vector element in spec position
	public double getElement(int num)  {
		if (num < 0 || num >= vector.length) {
			throw new VectorIndexOutOfBoundsException("Bad index!");
			
		}
			return vector[num];
	}

	// get vector element in spec position
	public void setElement(int num, double value) {
		if (num < 0 || num >= vector.length) {
			throw new VectorIndexOutOfBoundsException("Bad index!");
		}
		vector[num] = value;
	}

	@Override
	public void fillFromMass(double[] mass) {
		if (vector.length != mass.length) {
			double[] v_aux = new double[mass.length];
			for (int i = 0; i < mass.length; i++) {
				v_aux[i] = mass[i];
			}
			vector = v_aux;
		} else {
			for (int i = 0; i < mass.length; i++) {
				vector[i] = mass[i];
			}
		}

	}

	@Override
	public void fillFromVector(Vector v) {

		if (vector.length != v.getSize()) {
			double[] v_aux = new double[v.getSize()];
			for (int i = 0; i < v.getSize(); i++) {
				v_aux[i] = v.getElement(i);
			}
			vector = v_aux;
		} else {
			for (int i = 0; i < vector.length; i++) {
				vector[i] = v.getElement(i);
			}
		}

	}

	@Override
	public void mult(double num) {
		for (int i = 0; i < vector.length; i++) {
			vector[i] = vector[i] * num;
		}
	}

	@Override
	public void sum(Vector v)throws IncompatibleVectorSizesException {
		if (vector.length != v.getSize()) {
			throw new IncompatibleVectorSizesException("Incompatible vector sizes!");
		} else {
			for (int i = 0; i < vector.length; i++) {
				vector[i] = vector[i] + v.getElement(i);
			}
		}

	}

	@Override
	public boolean equal(Vector v) {
		if (vector.length != v.getSize()) {
			return false;
		} else

		{
			for (int i = 0; i < vector.length; i++) {
				if (vector[i] != (v.getElement(i))) {
					return false;

				}
			}
		}

		return true;
	}

//	// get min value in vector
//	public double getMin() {
//		double[] vectorCopy = vector.clone();
//		Vectors.sort(vectorCopy);
//		return vectorCopy[0];
//	}
//
//	// get max value in vector
//	public double getMax() {
//		double[] vectorCopy = vector.clone();
//		Vectors.sort(vectorCopy);
//		return vectorCopy[vector.length - 1];
//	}

//	// sort vector in asc
//	public void sortVector(Vector v) {
//		Vectors.sort(v);
//	}

//	// print vector content
//	private static void show(ArrayVector vector) {
//		for (int i = 0; i < vector.getSize(); i++) {
//			System.out.print(vector.getElement(i) + " ");
//
//		}
//		System.out.println();
//	}



//	public static void main(String[] args) throws IncompatibleVectorSizesException {
//	 // TODO Auto-generated method stub
//	 double[] cats = { 2, 5, 7, 8, 3, 1 };
//	 double[] dogs = { 2, 5, 7, 8, 3 };
//	 ArrayVector v = new ArrayVector(cats.length);
//	 v.fillFromMass(cats);
//	 
//	 ArrayVector v2= new ArrayVector(dogs.length);
//	 v2.fillFromMass(dogs);
//	 v.sortVector(v2);
////	 v.sum(v2);
//show(v2);
//	 System.out.println();
//
//	 }
	
	
}
