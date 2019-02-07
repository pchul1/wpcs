package kr.or.waterkorea.batch;

/**
 * 
 */

/**
 * @author aquilegia
 *
 */
public class GeoPoint {
	/**
	 * @uml.property  name="x"
	 */
	double x;
	/**
	 * @uml.property  name="y"
	 */
	double y;
	/**
	 * @uml.property  name="z"
	 */
	double z;
	
	/**
	 * 
	 */
	public GeoPoint() {
		super();
	}
	
	/**
	 * @param x
	 * @param y
	 */
	public GeoPoint(double x, double y) {
		super();
		this.x = x;
		this.y = y;
		this.z = 0;
	}
	
	/**
	 * @param x
	 * @param y
	 * @param y
	 */
	public GeoPoint(double x, double y, double z) {
		super();
		this.x = x;
		this.y = y;
		this.z = z;
	}
	
	/**
	 * @return
	 * @uml.property  name="x"
	 */
	public double getX() {
		return x;
	}

	/**
	 * @return
	 * @uml.property  name="y"
	 */
	public double getY() {
		return y;
	}
	
	/**
	 * @return
	 * @uml.property  name="z"
	 */
	public double getZ() {
		return z;
	}
}
