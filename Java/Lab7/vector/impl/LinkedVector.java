package vector.impl;

import vector.Vector;
import vector.exception.IncompatibleVectorSizesException;
import vector.exception.VectorIndexOutOfBoundsException;

public class LinkedVector implements Vector, Cloneable, java.io.Serializable{
	
	protected Nod head;
	protected int size;
	
	 public LinkedVector() { 
	    }



	// Inner Class for Nodes
	public class Nod implements java.io.Serializable {
		public double element;
		public Nod next;
		public Nod prev;

		public Nod(double element) {
			this.element = element;
		}
	}

	protected Nod goToElement(int index) {
		Nod result = head;
		int i = 0;
		while (i != index) {
			result = result.next;
			i++;
		}
		return result;
	}

	protected void insertElementBefore(Nod current, Nod newNod) {
		newNod.next = current;
		newNod.prev = current.prev;
		current.prev.next = newNod;
		current.prev = newNod;
		size++;
	}

	protected void deleteElement(Nod current) {
		if (size == 1) {
			head = null;
		} else {
			current.prev.next = current.next;
			current.next.prev = current.prev;
			if (current == head) {
				head = current.next;
			}
		}
		size--;

	}
	// ======================================+++++++++++================

	public void addElement(double d) {
		if (head == null) {
			head = new Nod(d);
			head.prev = head;
			head.next = head;
			size = 1;
		} else {
			insertElementBefore(head, new Nod(d));
		}
	}

	@Override
	public double getElement(int num) {
		if (num >= size || num < 0) {
			throw new VectorIndexOutOfBoundsException("Bad index!");
		}
		return goToElement(num).element;
	}

	@Override
	public void setElement(int num, double value) {
		if (num >= size || num < 0) {
			throw new VectorIndexOutOfBoundsException("Bad index!");
		}
		goToElement(num).element = value;
	}

	@Override
	public int getSize() {
		return size;
	}

	@Override
	public void fillFromMass(double[] mass) {
		head = null;
		size = 0;
		for (int i = 0; i < mass.length; i++) {
			addElement(mass[i]);
		}
	}

	@Override
	public void fillFromVector(Vector v) {
		head = null;
		size = 0;
		for (int i = 0; i < v.getSize(); i++) {
			addElement(v.getElement(i));
		}
	}

	@Override
	public void mult(double num) {
		Nod current = head;
		for (int i = 0; i < getSize(); i++) {
			current.element = num * current.element;
			current = current.next;
		}
	}

	@Override
	public void sum(Vector v) throws IncompatibleVectorSizesException {
		if (getSize() != v.getSize()) {
			throw new IncompatibleVectorSizesException();
		} else {
			for (int i = 0; i < getSize(); i++) {
				setElement(i, getElement(i) + v.getElement(i));
			}
		}
	}

	@Override
	public void insertElement(int num, double value) {
		if (num < 0 || num > size + 1) {
			throw new VectorIndexOutOfBoundsException("Bad index!");
		}
		if (num == size) {
			addElement(value);
			return;
		}
		Nod newNod = new Nod(value);
		insertElementBefore(goToElement(num), newNod);
	}

	@Override
	public void deleteElement(int num) {
		if (num < 0 || num >= size) {
			throw new VectorIndexOutOfBoundsException("Bad index!");
		}
		deleteElement(goToElement(num));
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < getSize(); i++) {
			sb.append(getElement(i)).append(" ");
		}
		return sb.toString();
	}

	@Override
	public LinkedVector clone() throws CloneNotSupportedException {
		LinkedVector LVClone = (LinkedVector) super.clone();
		LVClone.fillFromVector(this);
		return LVClone;
	}

	public static void main(String[] args) throws IncompatibleVectorSizesException {
		// Mult test
		double[] mass = { 5.0, -2.9, 0.0, -50000, 9 };
		double[] resultMass = { 10.0, -5.8, 0.0, -100000, 18 };
		Vector instance = new LinkedVector();
		instance.fillFromMass(mass);
		// for (int j = 0; j < mass.length; j++) {
		// System.out.print(instance.getElement(j)+" ");
		// }
		// System.out.println();
		// instance.mult(2);
		// for (int j = 0; j < mass.length; j++) {
		// System.out.print(instance.getElement(j)+" ");
		// }
		// =============================================================
		// SumVectorTest
		// Vector instance2 = new LinkedVector();
		// instance2.fillFromMass(resultMass);
		// instance.sum(instance2);
		// for (int j = 0; j < mass.length; j++) {
		// System.out.print(instance.getElement(j)+" ");
		// }

		// =============================================================
		// Insert element
		instance.insertElement(2, 10);
		//
		// for (int j = 0; j < instance.getSize(); j++) {
		// System.out.print(instance.getElement(j)+" ");
		// }
		System.out.println(instance.getSize());
		System.out.println(instance.toString());

	}

		
}
