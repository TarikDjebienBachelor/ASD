/*
 * Created on 28 mars 2004
 */
package org.nherve.sort.algorithm;

import org.nherve.sort.data.Infinite;
import org.nherve.sort.data.MonitoredData;

/**
 * @author Nicolas HERVE
 */
public class MergeSort extends SortAlgorithm {
	private Infinite inf = null;

	/**
	 * @param sts
	 */
	public MergeSort() {
		super();
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		// SortTest.displayTab(tab);
		inf = new Infinite();
		inf.setStatistics(getStatistics());
		sortMerge(tab, 0, tab.length - 1);
		return tab;
	}

	private void sortMerge(MonitoredData[] A, int p, int r) {
		if (p < r) {
			int q = (p + r) / 2;
			sortMerge(A, p, q);
			sortMerge(A, q + 1, r);
			merge(A, p, q, r);
			// System.out.print(p + "->" + r + " ");
			// SortTest.displayTab(A);
		}
	}

	private void merge(MonitoredData[] A, int p, int q, int r) {
		int n1 = q - p + 1;
		int n2 = r - q;

		MonitoredData[] L = new MonitoredData[n1 + 1];
		MonitoredData[] R = new MonitoredData[n2 + 1];

		for (int i = 0; i < n1; i++) {
			L[i] = A[p + i];
		}

		for (int j = 0; j < n2; j++) {
			R[j] = A[q + j + 1];
		}

		L[n1] = inf;
		R[n2] = inf;

		int i = 0;
		int j = 0;

		for (int k = p; k <= r; k++) {
			if (L[i].compareTo(R[j]) <= 0) {
				A[k] = L[i];
				i++;
			} else {
				A[k] = R[j];
				j++;
			}
		}
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "Merge IntroAlgo-27";
	}

}
