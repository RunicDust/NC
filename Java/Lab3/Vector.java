package pr3;


public interface Vector {
	public double getElement(int num);
	public void setElement(int num, double value);
	public int getSize();
	public void fillFromMass(double[] mass);
	public void fillFromVector(Vector v);
	public void mult(double num);
	public void sum(Vector v) throws IncompatibleVectorSizesException;
	public boolean equal(Vector v);
}
