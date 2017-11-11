/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.algorithm;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.nherve.sort.data.MonitoredData;

/**
 * @author nherve
 */
public class JavaSort extends SortAlgorithm {

	/**
	 * @param sts
	 */
	public JavaSort() {
		super();
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		Arrays.sort(tab);
		return tab;
		// List l = Arrays.asList(tab);
		// Collections.sort(l);
		// return (MonitoredData[]) l.toArray();
	}
	
	public long[] sort(long[] tab) {
		Arrays.sort(tab);
		return tab;
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "Java (modified merge sort)";
	}

}
