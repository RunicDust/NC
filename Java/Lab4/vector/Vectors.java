package pr4.vector;

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
		double[] a=new double[v.getSize()];
		for (int i = 0; i < v.getSize(); i++) {
			a[i]=v.getElement(i);
		}		
		double[] aux = new double[a.length];
		sort(a, aux, 0, a.length - 1);
		for (int i = 0; i < v.getSize(); i++) {
			v.setElement(i, a[i]);
		}	
	}
}

