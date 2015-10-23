package pr5.vector;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.StreamTokenizer;
import java.io.Writer;

import pr5.vector.impl.ArrayVector;

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

	// записи вектора в байтовый поток
	static void outputVector(Vector v, OutputStream out) {
		try {
			for (int i = 0; i < v.getSize(); i++) {
				((DataOutputStream) out).writeDouble(v.getElement(i));
			}

		} catch (IOException e) {
			System.out.println("Some error occurred!");
		}
	}

	// чтения вектора из байтового потока
	Vector inputVector(InputStream in) {

		return null;
	}

	// записи вектора в символьный поток
	static void writeVector(Vector v, Writer out) throws IOException {
		((PrintWriter) out).print(v.getSize() + " ");
		for (int i = 0; i < v.getSize(); i++) {
			((PrintWriter) out).print(v.getElement(i) + " ");
		}

	}

	// чтения вектора из символьного потока
	static Vector readVector(Reader in) {
		try {
			StreamTokenizer st = new StreamTokenizer(in);
			st.nextToken();
			int size = (int) st.nval;
			System.out.println(size);
			Vector v = new ArrayVector(size);
			for (int i = 0; i < size; i++) {
				st.nextToken();
				v.setElement(i, (double) st.nval);
			}
			return v;

		} catch (IOException e) {
			System.out.println("Some error occurred!");
		}
		return null;
	}

	
	
	
	
	
	
	
	
	
	
	
	public static void main(String[] args) throws pr5.vector.IncompatibleVectorSizesException, IOException {
		// TODO Auto-generated method stub
		double[] cats = { 2, 5, 7, 8, 3, 1 };
		double[] dogs = { 2, 5, 7, 8, 3 };
		ArrayVector v = new ArrayVector(cats.length);
		v.fillFromMass(cats);
		ArrayVector v2 = new ArrayVector(dogs.length);

		v2.fillFromMass(dogs);
		System.out.println(v2.toString());
		DataOutputStream out = new DataOutputStream(new FileOutputStream("dogs.bin"));
		outputVector(v2, out);
		out.close();

		PrintWriter out2 = new PrintWriter(new BufferedWriter(new FileWriter("out.txt")));
		writeVector(v2, out2);
		out2.close();

		BufferedReader in = new BufferedReader(new FileReader("out.txt")); // InputStreamReader(System.in));

		System.out.println(readVector(in).toString());

	}

}
