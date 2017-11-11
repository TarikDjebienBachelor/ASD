/*
 * Created on 3 avr. 2004
 */
package org.nherve.sort.data.generator;

import java.util.Random;

/**
 * @author Nicolas HERVE
 */
public class SinusFunction implements MathematicalFunction {
	
	private double a;
	private double b;
	private double c;
	
	private boolean noise;
	private double n;
	private Random rd;

	/**
	 * 
	 */
	public SinusFunction(double a, double b, double c, boolean noise, double n) {
		super();
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.noise = noise;
		if (noise) {
			this.n = n;
			rd = new Random(System.currentTimeMillis());
		}
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.data.generator.MathematicalFunction#getValue(int)
	 */
	public double getValue(int i) {
		double value = a * Math.sin(c * i) + b;
		
		if (noise) {
			value += rd.nextDouble()*2*n-n;
		}
		
		return value;
	}

}
