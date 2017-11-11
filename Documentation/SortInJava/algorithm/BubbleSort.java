/*
 * Created on 28 mars 2004
 */
package org.nherve.sort.algorithm;

import org.nherve.sort.data.MonitoredData;

/**
 * @author Nicolas HERVE
 */
public class BubbleSort extends SortAlgorithm {

	/**
	 * @param sts
	 */
	public BubbleSort() {
		super();
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		MonitoredData tmp = null;
		for (int i = 0; i < tab.length; i++) {
			for (int j = tab.length - 1; j > i; j--) {
				if (tab[j].compareTo(tab[j - 1]) < 0) {
					swap(tab, j-1, j);
				}
			}
		}
		return tab;
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "Bubble IntroAlgo-35";
	}

}
