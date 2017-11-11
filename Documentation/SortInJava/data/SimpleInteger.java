/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.data;

import org.nherve.sort.Statistics;

/**
 * @author nherve
 */
public class SimpleInteger implements MonitoredData {
	
	private int value;
	private Statistics sts;
	
	

	public SimpleInteger(int v, Statistics sts) {
		super();
		value = v;
		this.sts = sts;
	}
	
	public SimpleInteger(String v, Statistics sts) {
		this(new Integer(v).intValue(), sts);
	}	
	
	public int getValue() {
		return value;
	}

	public int compareTo(Object o) {
		sts.addCompare();
		
		if (o instanceof Infinite) {
			return -1;
		}
		
		// return new Integer(getValue()).compareTo(new Integer(((SimpleInteger)o).getValue()));
		return value - ((SimpleInteger)o).value;
	}

	public Statistics getStatistics() {
		return sts;
	}

	public void setStatistics(Statistics sts) {
		this.sts = sts;
	}
	
	public String toString() {
		return ""+value;
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.data.MonitoredData#getValueAsInt()
	 */
	public int getValueAsInt() {
		return getValue();
	}

}
