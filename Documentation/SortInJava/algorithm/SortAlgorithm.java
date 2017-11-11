/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.algorithm;

import org.nherve.sort.*;
import org.nherve.sort.data.MonitoredData;

/**
 * @author nherve
 */
public abstract class SortAlgorithm {

	private Statistics sts;

	public SortAlgorithm() {
		super();
	}
	
	public Statistics getStatistics() {
		return sts;
	}

	public void setStatistics(Statistics sts) {
		this.sts = sts;
	}	
	

	public void swap (MonitoredData[] A, int i, int j) {
		MonitoredData tmp = A[i];
		A[i] = A[j];
		A[j] = tmp;
		
		sts.addSwap();
	}	

	public abstract MonitoredData[] sort (MonitoredData[] tab);
	public abstract String getName();
}
