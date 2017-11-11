/*
 * Created on 23 avr. 2004
 */
package org.nherve.sort.algorithm;

import java.util.Random;

import org.nherve.sort.data.MonitoredData;

/**
 * @author Nicolas HERVE
 */
public class ModifiedQuickSort extends SortAlgorithm {

	private InsertionSort is = null;
	private int cut = 0;

	private boolean randomized = false;
	private Random rd;

	/**
	 * 
	 */
	public ModifiedQuickSort(boolean randomized, int cut) {
		super();

		this.randomized = randomized;
		this.cut = cut;
		
		is = new InsertionSort();

		if (randomized) {
			rd = new Random(System.currentTimeMillis());
		}
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algorithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		if (randomized) {
			quickSortRandomized(tab, 0, tab.length - 1);
		} else {
			quickSort(tab, 0, tab.length - 1);
		}
		return tab;
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
		if (r-p < cut) {
			is.insertionSort(A, p, r);
		} else if (p-r < 0) {
			int q = partition(A, p, r);	
			quickSort(A, p, q - 1);
			quickSort(A, q + 1, r);
		}
	}
	
	private void quickSortRandomized(MonitoredData[] A, int p, int r) {
		if (p-r < 0) {
			int q = partitionRandomized(A, p, r);
			quickSortRandomized(A, p, q - 1);
			quickSortRandomized(A, q + 1, r);
		}
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algorithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "QuickSort + InsertionSort(" + cut + ") " + (randomized ? "random" : "normal");
	}

}
