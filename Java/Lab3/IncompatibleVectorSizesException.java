package pr3;

public class IncompatibleVectorSizesException extends Exception {

	private String message;

	public IncompatibleVectorSizesException() {
		super();
	}

	public IncompatibleVectorSizesException(String message) {
		super(message);
		this.message = message;
	}

}
