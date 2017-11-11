/*
 * Created on 28 mars 2004
 */
package org.nherve.sort.algorithm;

import org.nherve.sort.data.MonitoredData;

/**
 * @author Nicolas HERVE
 */
public class InsertionSort extends SortAlgorithm {

	/**
	 * @param sts
	 */
	public InsertionSort() {
		super();
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		return insertionSort(tab, 0, tab.length - 1);
	}
	
	public MonitoredData[] insertionSort(MonitoredData[] tab, int l, int r) {
		MonitoredData key = null;
		int i = 0;
		for (int j = l+1; j <= r; j++) {
			key = tab[j];
			i = j - 1;
			while ((i >= l) && (tab[i].compareTo(key) > 0)) {
				tab[i + 1] = tab[i];
				i = i - 1;
			}
			tab[i + 1] = key;
		}
		return tab;		
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "Insertion IntroAlgo-15";
	}

}
