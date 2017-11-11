/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.algorithm;

import org.nherve.sort.data.MonitoredData;

/**
 * @author nherve
 */
public class QSortAlgorithm extends SortAlgorithm {

	private long compCount = 0;

	/**
	 * @param sts
	 */
	public QSortAlgorithm() {
		super();
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		compCount = 0;
		quickSort(tab, 0, tab.length - 1);
		return tab;
	}

	private void quickSort(MonitoredData[] A, int g, int d) {
		compCount++;
		if (d > g) {
			MonitoredData v = A[d];
			int i = g - 1;
			int j = d;
			while(true) {
				compCount++;
				while ((++i <= d) && (A[i].compareTo(v) < 0)) {compCount++;};
				compCount++;
				while ((--j >= g) && (A[j].compareTo(v) > 0)) {compCount++;};
				compCount++;
				if (i >= j) break;
				swap(A, i, j);
			}
			swap(A, i, d);
			quickSort(A, g, i-1);
			quickSort(A, i+1, d);
		}
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "Quicksort Sedgewick algoC p124";
	}

	/**
	 * @return
	 */
	public long getCompCount() {
		return compCount;
	}

}
