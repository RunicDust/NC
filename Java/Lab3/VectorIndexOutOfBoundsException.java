package pr3;

public class VectorIndexOutOfBoundsException extends IndexOutOfBoundsException {

	private String message;
	
    public VectorIndexOutOfBoundsException(){
        super();
    }
    public VectorIndexOutOfBoundsException(String message) {
        super(message);
        this.message = message;
    }
  
}
