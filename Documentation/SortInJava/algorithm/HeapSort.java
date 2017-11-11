/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.algorithm;

import org.nherve.sort.Statistics;
import org.nherve.sort.data.MinusInfinite;
import org.nherve.sort.data.MonitoredData;
import org.nherve.sort.data.SimpleInteger;

/**
 * @author nherve
 */
public class HeapSort extends SortAlgorithm {

	private class MaxHeap {
		int length; // length >= size
		int size;
		private MonitoredData[] A;

		private int parent(int i) {
			return i >> 1;
		}

		private int left(int i) {
			return i << 1;
		}

		private int right(int i) {
			return (i << 1) + 1;
		}

		public MaxHeap(MonitoredData[] tab) {
			super();
			A = tab;
			length = size = A.length - 1;
			//System.out.println(this);
			for (int i = length / 2; i > 0; i--) {
				entasserMax(i);
			}
		}

		public void entasserMax(int i) {
			//System.out.println("entasserMax(" + i + ")");
			int l = left(i);
			int r = right(i);
			int max = -1;

			if ((l <= size) && (A[l].compareTo(A[i]) > 0)) {
				max = l;
			} else {
				max = i;
			}

			if ((r <= size) && (A[r].compareTo(A[max]) > 0)) {
				max = r;
			}

			if (max != i) {
				swap(A, i, max);
				entasserMax(max);
			}
			//System.out.println(this);
		}

		private String getChars(int n, String c) {
			StringBuffer sbf = new StringBuffer();
			for (int i = 0; i < n; i++) {
				sbf.append(c);
			}
			return sbf.toString();
		}

		public String toString() {
			StringBuffer sbf = new StringBuffer();
			int nbLignes = (int) Math.round(Math.log(length)) + 2;
			int nbColonnes = 1 << nbLignes;
			//TODO pas forcement le max !!!
			int blocSize = A[1].toString().length();
			int maxLigneSize = nbColonnes * (blocSize + 1);

			int prevIdx = 0;
			for (int l = 0; l < nbLignes; l++) {
				StringBuffer sbf1 = new StringBuffer(maxLigneSize);
				StringBuffer sbf2 = new StringBuffer(maxLigneSize);
				int ligneCols = 1 << l;
				int col = 0;
				int spaces = maxLigneSize - (ligneCols * blocSize);
				int eachSpaces = spaces / ligneCols;
				int befEachSp = eachSpaces / 2;
				int aftEachSp = eachSpaces - befEachSp;
				int befEachTr = (maxLigneSize / ligneCols) / 2;
				int aftEachTr = (maxLigneSize / ligneCols) - befEachTr;
				for (int c = prevIdx + 1; c <= prevIdx + ligneCols; c++) {

					if (c <= length) {
						int correctionB = (blocSize - A[c].toString().length()) / 2;
						int correctionA = (blocSize - A[c].toString().length()) - correctionB;

						if ((col > 0) && (col % 2 == 1)) {
							sbf2.append(getChars(befEachTr - 1, "-"));
							sbf2.append("+");
						} else {
							sbf2.append(getChars(befEachTr, " "));

						}

						if ((col < ligneCols - 1) && (col % 2 == 0)) {
							sbf2.append("+");
							sbf2.append(getChars(aftEachTr - 2, "-"));
							sbf2.append("+");
						} else {
							sbf2.append(getChars(aftEachTr, " "));

						}

						col++;

						sbf1.append(getChars(befEachSp + correctionB, " ") + A[c] + getChars(aftEachSp + correctionA, " "));
					}

				}
				prevIdx += ligneCols;
				sbf1.append("\r\n");
				sbf2.append("\r\n");
				sbf.append(sbf2);
				sbf.append(sbf1);

			}

			return sbf.toString();
		}
	}

	private boolean countFirstLoop = false;

	/**
	 * @param sts
	 */
	public HeapSort(boolean countFirstLoop) {
		super();

		this.countFirstLoop = countFirstLoop;
	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#sort(org.nherve.sort.data.MonitoredData[])
	 */
	public MonitoredData[] sort(MonitoredData[] tab) {
		MonitoredData[] A = new MonitoredData[tab.length + 1];
		A[0] = new MinusInfinite();
		A[0].setStatistics(getStatistics());
		for (int i = 0; i < tab.length; i++) {
			A[i + 1] = tab[i];
		}

		if (!countFirstLoop) {
			getStatistics().top();
		}

		MaxHeap heap = new MaxHeap(A);
		//System.out.println(heap);
		for (int i = heap.length; i > 1; i--) {
			swap(A, 1, i);
			heap.size = heap.size - 1;
			heap.entasserMax(1);
		}
		return A;

	}

	/* (non-Javadoc)
	 * @see org.nherve.sort.algotithm.SortAlgorithm#getName()
	 */
	public String getName() {
		return "Heap IntroAlgo-122";
	}

	public void test() {
		MonitoredData[] A = new MonitoredData[7];
		Statistics sts = new Statistics();
		setStatistics(sts);

		A[1] = new SimpleInteger(15, sts);
		A[2] = new SimpleInteger(10, sts);
		A[3] = new SimpleInteger(4, sts);
		A[4] = new SimpleInteger(34, sts);
		A[5] = new SimpleInteger(1, sts);
		A[6] = new SimpleInteger(19, sts);

		MaxHeap heap = new MaxHeap(A);
		System.out.println(heap);
	}

	public static void main(String args[]) {
		new HeapSort(true).test();
	}

}
