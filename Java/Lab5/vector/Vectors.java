package pr5.vector;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StreamTokenizer;
import java.io.Writer;

import pr5.vector.impl.ArrayVector;
import pr5.vector.impl.LinkedVector;

public class Vectors {
	// merge
	private static void merge(double[] a, double[] aux, int lo, int mid, int hi) {

		// copy to aux array
		for (int k = lo; k <= hi; k++) {
			aux[k] = a[k];
		}

		// merge back to a[]
		int i = lo, j = mid + 1;
		for (int k = lo; k <= hi; k++) {
			if (i > mid)
				a[k] = aux[j++];
			else if (j > hi)
				a[k] = aux[i++];
			else if (aux[j] < aux[i])
				a[k] = aux[j++];
			else
				a[k] = aux[i++];
		}
	}

	// sorting method
	private static void sort(double[] a, double[] aux, int lo, int hi) {
		if (hi <= lo)
			return;
		int mid = lo + (hi - lo) / 2;
		sort(a, aux, lo, mid);
		sort(a, aux, mid + 1, hi);
		merge(a, aux, lo, mid, hi);
	}

	// method call
	public static void sort(Vector v) {
		double[] a = new double[v.getSize()];
		for (int i = 0; i < v.getSize(); i++) {
			a[i] = v.getElement(i);
		}
		double[] aux = new double[a.length];
		sort(a, aux, 0, a.length - 1);
		for (int i = 0; i < v.getSize(); i++) {
			v.setElement(i, a[i]);
		}
	}

	//
	static void outputVector(Vector v, OutputStream out) throws IOException {
		DataOutputStream dOut = new DataOutputStream(out);
		dOut.writeInt(v.getSize());
		for (int i = 0; i < v.getSize(); i++) {
			dOut.writeDouble(v.getElement(i));
		}
	}

	//
	static Vector inputVector(InputStream in) throws IOException {
		DataInputStream dIn = new DataInputStream(in);
		int size = dIn.readInt();
		Vector v = new ArrayVector(size);
		for (int i = 0; i < size; i++) {
			v.setElement(i, dIn.readDouble());
		}
		return v;
	}

	//
	static void writeVector(Vector v, Writer out) throws IOException {
		PrintWriter pW = new PrintWriter(out);
		pW.print(v.getSize());
		for (int i = 0; i < v.getSize(); i++) {
			pW.print(" " + v.getElement(i));
		}
		pW.append("\n");
		
	}

	//
	static Vector readVector(Reader in) throws IOException {
		StreamTokenizer st = new StreamTokenizer(in);
		st.nextToken();
		int size = (int) st.nval;
		Vector v = new ArrayVector(size);
		for (int i = 0; i < size; i++) {
			st.nextToken();
			v.setElement(i, (double) st.nval);
		}
		return v;
	}

	public static void main(String[] args)
			throws pr5.vector.IncompatibleVectorSizesException, IOException, ClassNotFoundException {
		// TODO Auto-generated method stub
		double[] cats = { 2, 5, 7, 8, 3, 1 };
		double[] dogs = { 2, 5, 7, 8, 3 };
		ArrayVector v = new ArrayVector(cats.length);
		v.fillFromMass(cats);
		ArrayVector v2 = new ArrayVector(dogs.length);
		v2.fillFromMass(dogs);
		
//		System.out.println(v2.toString());
		DataOutputStream out = new DataOutputStream(new FileOutputStream("dogs.bin"));
		outputVector(v2, out);
		out.close();

		PrintWriter out2 = new PrintWriter(new BufferedWriter(new FileWriter("out.txt")));
		writeVector(v2, out2);
		writeVector(v, out2);
		out2.close();
		
		BufferedReader in = new BufferedReader(new FileReader("out.txt"));
		System.out.println(readVector(in));
		System.out.println(readVector(in));
		

//		BufferedReader in = new BufferedReader(new FileReader("out.txt")); // InputStreamReader(System.in));
//
//		LinkedVector lv = new LinkedVector();
//		lv.fillFromMass(dogs);
		
		
		
//		// Serialization
//		ObjectOutputStream out1 = new ObjectOutputStream(new FileOutputStream("out.bin"));
//		out1.writeObject(v);
//		out1.close();
		
//		// Deserialization array vector
//		ObjectInputStream in1 = new ObjectInputStream(new FileInputStream("out.bin"));
//		lv = (LinkedVector) in1.readObject();
//		in1.close();
//		System.out.println(lv.toString());
		// Deserialization array vector
//		ObjectInputStream in1 = new ObjectInputStream(new FileInputStream("out.bin"));
//		v = (ArrayVector) in1.readObject();
//		in1.close();
//
//		System.out.println(v.toString());
	}

}
