/*
 * Created on 13 avr. 2004
 */
package org.nherve.sort;

import java.text.DecimalFormat;

/**
 * @author Nicolas HERVE
 */
public class Serie {

	/**
	 * 
	 */
	public Serie() {
		super();
	}
	
	private double getNext(double n, double prev) {
		return ((n+1)/n)*prev + (n+3)/2 - (n-1)*(n+2)/(2*n);
	}
	
	public void compute(double v1, int min, int max, int step) {
		DecimalFormat df = new DecimalFormat("0.000000");
		double v = v1;
		for (int n = min; n <= max; n++) {
			v = getNext(n, v);
			if (n % step == 0) {
				System.out.println(n + " - " + df.format(v));
			}
		}
	}

	public static void main(String[] args) {
		Serie s = new Serie();
		s.compute(1d, 3, 100000, 500);
		// s.compute(1, 2, 10,1);
	}
}
