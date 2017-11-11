/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort;

/**
 * @author nherve
 */
public class Statistics {
	
	private long compare;
	private long swap;
	
	private long start;
	private long top;

	public Statistics() {
		super();
		
		reinit();
	}
	
	public void addCompare() {
		compare++;
	}
	
	public void addSwap() {
		swap++;
	}
	
	public long getCompare() {
		return compare;
	}
	
	public long getSwap() {
		return swap;
	}
	
	public void reinit() {
		compare = 0;
		swap = 0;
	}
	
	public void start() {
		start = System.currentTimeMillis();
	}
	
	public long top() {
		top = System.currentTimeMillis();
		long res = top - start;
		start = top;
		return res;
	}
	
}
