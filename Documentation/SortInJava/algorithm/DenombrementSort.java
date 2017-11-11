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
public class DenombrementSort extends SortAlgorithm {
	
	private boolean countFirstLoop = false;

	/**
	 * @param sts
	 */
	public DenombrementSort(boolean countFirstLoop) {
		super();
		
		this.countFirstLoop = countFirstLoop;
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] A) {
		int k = Integer.MIN_VALUE;
		for (int i = 0; i < A.length; i++) {
			if (A[i].getValueAsInt() > k) {
				k = A[i].getValueAsInt();
			}
		}
		
		k++;
		
		if (!countFirstLoop) {
			getStatistics().top();
		}
		
		int[] C = new int[k];
		MonitoredData[] B = new MonitoredData[A.length];
		
		for (int i = 0; i < k; i++) {
			C[i] = 0;
		}
		
		for (int j = 0; j < A.length; j++) {
			C[A[j].getValueAsInt()] = C[A[j].getValueAsInt()] + 1;
		}
		
		for (int i = 1; i < k; i++) {
			C[i] += C[i - 1];
		}
		
		for (int j = A.length - 1; j >= 0; j--) {
			B[C[A[j].getValueAsInt()] - 1] = A[j];
			C[A[j].getValueAsInt()] = C[A[j].getValueAsInt()] - 1;
		}
		
		return B;
		
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "Denombrement IntroAlgo-162";
	}

}
