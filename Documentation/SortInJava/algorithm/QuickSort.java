/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.algorithm;

import java.util.Random;

import org.nherve.sort.data.MonitoredData;

/**
 * @author nherve
 */
public class QuickSort extends SortAlgorithm {
	private boolean randomized = false;
	private Random rd;

	/**
	 * @param sts
	 */
	public QuickSort(boolean randomized) {
		super();

		this.randomized = randomized;

		if (randomized) {
			rd = new Random(System.currentTimeMillis());
		}
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "QuickSort IntroAlgo-140 " + (randomized ? "random" : "normal");
	}

	private int partition(MonitoredData[] A, int p, int r) {
		int n = r - p + 1;
		MonitoredData x = A[r];
		int i = p - 1;
		for (int j = p; j < r; j++) {
			if (A[j].compareTo(x) <= 0) {
				i = i + 1;
				swap(A, i, j);
			}
		}
		swap(A, i + 1, r);
		return i + 1;
	}

	private int partitionRandomized(MonitoredData[] A, int p, int r) {
		int i = rd.nextInt(r - p + 1) + p;
		swap(A, r, i);
		return partition(A, p, r);
	}

	private void quickSort(MonitoredData[] A, int p, int r) {
		if (p < r) {
			int q = partition(A, p, r);	
			quickSort(A, p, q - 1);
			quickSort(A, q + 1, r);
		}
	}

	private void quickSortRandomized(MonitoredData[] A, int p, int r) {
		if (p < r) {
			int q = partitionRandomized(A, p, r);
			quickSortRandomized(A, p, q - 1);
			quickSortRandomized(A, q + 1, r);
		}
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		if (randomized) {
			quickSortRandomized(tab, 0, tab.length - 1);
		} else {
			quickSort(tab, 0, tab.length - 1);
		}
		return tab;
	}

	/**
	 * @return
	 */
	public boolean isRandomized() {
		return randomized;
	}

}
