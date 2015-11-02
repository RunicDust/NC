package pr4.vector;

public interface Vector {
	public double getElement(int num);

	public void setElement(int num, double value);

	public int getSize();

	public void fillFromMass(double[] mass);

	public void fillFromVector(Vector v);

	public void mult(double num);

	public void sum(Vector v) throws IncompatibleVectorSizesException;

	public void addElement(double value);

	public void insertElement(int num, double value);

	public void deleteElement(int num);
	
	public String toString();
	
	public boolean equals(Object obj);
	
	public Object clone() throws CloneNotSupportedException;
}
