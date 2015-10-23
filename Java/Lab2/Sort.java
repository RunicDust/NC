package pr2;

//implementation of merge sort for array of doubles
public class Sort {

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
	
	//recursive call
	public static void sort(double[] a) {
		double[] aux = new double[a.length];
		sort(a, aux, 0, a.length - 1);
	}
	
}
