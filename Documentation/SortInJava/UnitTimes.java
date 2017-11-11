/*
 * Created on 24 avr. 2004
 */
package org.nherve.sort;

import org.nherve.sort.data.MonitoredData;
import org.nherve.sort.data.SimpleInteger;

/**
 * @author Nicolas HERVE
 */
public class UnitTimes {
	public static void compTimePrimitive(int nbTry, int x) {
		int tabSize = 100;
		Statistics sts = new Statistics();
		long[] tab = new long[tabSize];
		for (int i = 0; i < tabSize; i++) {
			tab[i] = i * x;
		}
		sts.reinit();
		sts.top();
		for (int i = 0; i < nbTry; i++) {
			comp(tab, 0, 1);
			comp(tab, 1, 2);
			comp(tab, 2, 3);
			comp(tab, 3, 4);
			comp(tab, 4, 5);
			comp(tab, 5, 6);
			comp(tab, 6, 7);
			comp(tab, 7, 8);
			comp(tab, 8, 9);
			comp(tab, 9, 10);
			comp(tab, 10, 11);
			comp(tab, 11, 12);
			comp(tab, 12, 13);
			comp(tab, 13, 14);
			comp(tab, 14, 15);
			comp(tab, 15, 16);
			comp(tab, 16, 17);
			comp(tab, 17, 18);
			comp(tab, 18, 19);
			comp(tab, 19, 20);
			comp(tab, 20, 21);
			comp(tab, 21, 22);
			comp(tab, 22, 23);
			comp(tab, 23, 24);
			comp(tab, 24, 25);
			comp(tab, 25, 26);
			comp(tab, 26, 27);
			comp(tab, 27, 28);
			comp(tab, 28, 29);
			comp(tab, 29, 30);
			comp(tab, 30, 31);
			comp(tab, 31, 32);
			comp(tab, 32, 33);
			comp(tab, 33, 34);
			comp(tab, 34, 35);
			comp(tab, 35, 36);
			comp(tab, 36, 37);
			comp(tab, 37, 38);
			comp(tab, 38, 39);
			comp(tab, 39, 40);
			comp(tab, 40, 41);
			comp(tab, 41, 42);
			comp(tab, 42, 43);
			comp(tab, 43, 44);
			comp(tab, 44, 45);
			comp(tab, 45, 46);
			comp(tab, 46, 47);
			comp(tab, 47, 48);
			comp(tab, 48, 49);
			comp(tab, 49, 0);
		}

		System.out.println(sts.top());

	}

	public static void swapTimePrimitive(int nbTry) {
		int tabSize = 100;
		Statistics sts = new Statistics();
		long[] tab = new long[tabSize];
		for (int i = 0; i < tabSize; i++) {
			tab[i] = (long) i;
		}
		sts.reinit();
		sts.top();
		for (int i = 0; i < nbTry; i++) {
			swap(tab, 0, 1);
			swap(tab, 1, 2);
			swap(tab, 2, 3);
			swap(tab, 3, 4);
			swap(tab, 4, 5);
			swap(tab, 5, 6);
			swap(tab, 6, 7);
			swap(tab, 7, 8);
			swap(tab, 8, 9);
			swap(tab, 9, 10);
			swap(tab, 10, 11);
			swap(tab, 11, 12);
			swap(tab, 12, 13);
			swap(tab, 13, 14);
			swap(tab, 14, 15);
			swap(tab, 15, 16);
			swap(tab, 16, 17);
			swap(tab, 17, 18);
			swap(tab, 18, 19);
			swap(tab, 19, 20);
			swap(tab, 20, 21);
			swap(tab, 21, 22);
			swap(tab, 22, 23);
			swap(tab, 23, 24);
			swap(tab, 24, 25);
			swap(tab, 25, 26);
			swap(tab, 26, 27);
			swap(tab, 27, 28);
			swap(tab, 28, 29);
			swap(tab, 29, 30);
			swap(tab, 30, 31);
			swap(tab, 31, 32);
			swap(tab, 32, 33);
			swap(tab, 33, 34);
			swap(tab, 34, 35);
			swap(tab, 35, 36);
			swap(tab, 36, 37);
			swap(tab, 37, 38);
			swap(tab, 38, 39);
			swap(tab, 39, 40);
			swap(tab, 40, 41);
			swap(tab, 41, 42);
			swap(tab, 42, 43);
			swap(tab, 43, 44);
			swap(tab, 44, 45);
			swap(tab, 45, 46);
			swap(tab, 46, 47);
			swap(tab, 47, 48);
			swap(tab, 48, 49);
			swap(tab, 49, 0);
		}

		System.out.println(sts.top());

	}

	private static int s = 0;

	/**
	 * 
	 */
	public UnitTimes() {
		super();
	}

	public static void swap(MonitoredData[] A, int i, int j) {
		MonitoredData tmp = A[i];
		A[i] = A[j];
		A[j] = tmp;
	}

	public static void swap(long[] A, int i, int j) {
		long tmp = A[i];
		A[i] = A[j];
		A[j] = tmp;
	}

	public static int comp(MonitoredData[] A, int i, int j) {
		return A[i].compareTo(A[j]);
	}

	public static boolean comp(long[] A, int i, int j) {
		return A[i] > A[j];
	}

	public static void swapTime(int nbTry) {
		int tabSize = 100;
		Statistics sts = new Statistics();
		MonitoredData[] tab = new MonitoredData[tabSize];
		for (int i = 0; i < tabSize; i++) {
			tab[i] = new SimpleInteger(i, sts);
		}
		sts.reinit();
		sts.top();
		for (int i = 0; i < nbTry; i++) {
			swap(tab, 0, 1);
			swap(tab, 1, 2);
			swap(tab, 2, 3);
			swap(tab, 3, 4);
			swap(tab, 4, 5);
			swap(tab, 5, 6);
			swap(tab, 6, 7);
			swap(tab, 7, 8);
			swap(tab, 8, 9);
			swap(tab, 9, 10);
			swap(tab, 10, 11);
			swap(tab, 11, 12);
			swap(tab, 12, 13);
			swap(tab, 13, 14);
			swap(tab, 14, 15);
			swap(tab, 15, 16);
			swap(tab, 16, 17);
			swap(tab, 17, 18);
			swap(tab, 18, 19);
			swap(tab, 19, 20);
			swap(tab, 20, 21);
			swap(tab, 21, 22);
			swap(tab, 22, 23);
			swap(tab, 23, 24);
			swap(tab, 24, 25);
			swap(tab, 25, 26);
			swap(tab, 26, 27);
			swap(tab, 27, 28);
			swap(tab, 28, 29);
			swap(tab, 29, 30);
			swap(tab, 30, 31);
			swap(tab, 31, 32);
			swap(tab, 32, 33);
			swap(tab, 33, 34);
			swap(tab, 34, 35);
			swap(tab, 35, 36);
			swap(tab, 36, 37);
			swap(tab, 37, 38);
			swap(tab, 38, 39);
			swap(tab, 39, 40);
			swap(tab, 40, 41);
			swap(tab, 41, 42);
			swap(tab, 42, 43);
			swap(tab, 43, 44);
			swap(tab, 44, 45);
			swap(tab, 45, 46);
			swap(tab, 46, 47);
			swap(tab, 47, 48);
			swap(tab, 48, 49);
			swap(tab, 49, 0);
		}

		System.out.println(sts.top());

	}

	public static void compTime(int nbTry, int x) {
		int tabSize = 100;
		Statistics sts = new Statistics();
		MonitoredData[] tab = new MonitoredData[tabSize];
		for (int i = 0; i < tabSize; i++) {
			tab[i] = new SimpleInteger(i * x, sts);
		}
		sts.reinit();
		sts.top();
		for (int i = 0; i < nbTry; i++) {
			comp(tab, 0, 1);
			comp(tab, 1, 2);
			comp(tab, 2, 3);
			comp(tab, 3, 4);
			comp(tab, 4, 5);
			comp(tab, 5, 6);
			comp(tab, 6, 7);
			comp(tab, 7, 8);
			comp(tab, 8, 9);
			comp(tab, 9, 10);
			comp(tab, 10, 11);
			comp(tab, 11, 12);
			comp(tab, 12, 13);
			comp(tab, 13, 14);
			comp(tab, 14, 15);
			comp(tab, 15, 16);
			comp(tab, 16, 17);
			comp(tab, 17, 18);
			comp(tab, 18, 19);
			comp(tab, 19, 20);
			comp(tab, 20, 21);
			comp(tab, 21, 22);
			comp(tab, 22, 23);
			comp(tab, 23, 24);
			comp(tab, 24, 25);
			comp(tab, 25, 26);
			comp(tab, 26, 27);
			comp(tab, 27, 28);
			comp(tab, 28, 29);
			comp(tab, 29, 30);
			comp(tab, 30, 31);
			comp(tab, 31, 32);
			comp(tab, 32, 33);
			comp(tab, 33, 34);
			comp(tab, 34, 35);
			comp(tab, 35, 36);
			comp(tab, 36, 37);
			comp(tab, 37, 38);
			comp(tab, 38, 39);
			comp(tab, 39, 40);
			comp(tab, 40, 41);
			comp(tab, 41, 42);
			comp(tab, 42, 43);
			comp(tab, 43, 44);
			comp(tab, 44, 45);
			comp(tab, 45, 46);
			comp(tab, 46, 47);
			comp(tab, 47, 48);
			comp(tab, 48, 49);
			comp(tab, 49, 0);
		}

		System.out.println(sts.top());

	}

	public static void main(String[] args) {
		int nb = 2000000;
		SortTest.warmup(15);
		for (int i = 0; i < 10; i++) {
			System.out.print("Temps pour " + nb * 50 + " comp (" + (i * 10) + "): ");
			compTime(nb, i * 1000);
			System.gc();
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}

		for (int i = 0; i < 10; i++) {
			System.out.print("Temps pour " + nb * 50 + " comp de long (" + (i * 10) + "): ");
			compTimePrimitive(nb, i * 1000);
			System.gc();
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}

		for (int i = 0; i < 10; i++) {
			System.out.print("Temps pour " + nb * 50 + " swap : ");
			swapTime(nb);
			System.gc();
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}

		for (int i = 0; i < 10; i++) {
			System.out.print("Temps pour " + nb * 50 + " swap de long : ");
			swapTimePrimitive(nb);
			System.gc();
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}

	}
}
