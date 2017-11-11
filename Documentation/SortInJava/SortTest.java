/*
 * Created on 25 mars 2004
 * 
 * To change this generated comment go to Window>Preferences>Java>Code
 * Generation>Code Template
 */
package org.nherve.sort;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.nherve.sort.algorithm.BubbleSort;
import org.nherve.sort.algorithm.DenombrementSort;
import org.nherve.sort.algorithm.HeapSort;
import org.nherve.sort.algorithm.InsertionSort;
import org.nherve.sort.algorithm.JavaSort;
import org.nherve.sort.algorithm.MergeSort;
import org.nherve.sort.algorithm.ModifiedQuickSort;
import org.nherve.sort.algorithm.QSortAlgorithm;
import org.nherve.sort.algorithm.QuickSort;
import org.nherve.sort.algorithm.SortAlgorithm;
import org.nherve.sort.data.MonitoredData;
import org.nherve.sort.data.analyzer.SimpleIntegerAnalyzer;
import org.nherve.sort.data.generator.SimpleIntegerDataFactory;

/**
 * @author nherve
 */
public class SortTest {

	private final static String sep = ",";
	private static BufferedWriter writer = null;

	/**
	 *  
	 */
	public SortTest() {
		super();
	}

	private static void smallTest(String directory, SortAlgorithm sort, int nb) {
		Statistics sts = new Statistics();
		sort.setStatistics(sts);
		SimpleIntegerDataFactory factory = new SimpleIntegerDataFactory(sts);
		SimpleIntegerAnalyzer analyzer = new SimpleIntegerAnalyzer();
		File dir = new File(directory);

		if (dir.exists() && dir.isDirectory()) {
			File[] df = dir.listFiles();
			for (int i = 0; i < df.length; i++) {
				MonitoredData[][] datas = new MonitoredData[nb][];
				try {
					for (int n = 0; n < nb; n++) {
						datas[n] = factory.readFromFile(df[i].getAbsolutePath());
					}
					sts.start();
					sts.reinit();
					sts.top();
					//System.out.print(sort + " - " + df[i]);
					for (int n = 0; n < nb; n++) {
						sort.sort(datas[n]);
					}
					long top = sts.top();
					//System.out.println("ok");
					//displayTab("", data);
					String info = df[i].getName().replaceAll("_", sep).replaceAll(".csv", "") + sep + sort.getName() + sep + top + sep + sts.getCompare() + sep + sts.getSwap();

					System.out.println(info);
					System.gc();
					try {
						Thread.sleep(500);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}
					/*
										if (sort instanceof QSortAlgorithm) {
											System.out.println("compCount = " + ((QSortAlgorithm) sort).getCompCount());
										}
					*/
					if (writer != null) {
						writer.write(info);
						writer.newLine();
						writer.flush();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private static void fullTest(String directory, SortAlgorithm sort, boolean check) {
		Statistics sts = new Statistics();
		sort.setStatistics(sts);
		SimpleIntegerDataFactory factory = new SimpleIntegerDataFactory(sts);
		SimpleIntegerAnalyzer analyzer = new SimpleIntegerAnalyzer();
		File dir = new File(directory);
		MonitoredData[] data = null;

		if (dir.exists() && dir.isDirectory()) {
			File[] df = dir.listFiles();
			for (int i = 0; i < df.length; i++) {
				try {
					sts.start();
					data = factory.readFromFile(df[i].getAbsolutePath());
					sts.reinit();
					sts.top();
					data = sort.sort(data);
					long top = sts.top();
					//displayTab("", data);
					String info = null;
					if (sort instanceof QSortAlgorithm) {
						//System.out.println("compCount = " + ((QSortAlgorithm) sort).getCompCount());
						info = df[i].getName().replaceAll("_", sep).replaceAll(".csv", "") + sep + sort.getName() + sep + top + sep + sts.getCompare() + sep + ((QSortAlgorithm) sort).getCompCount();
					} else {
						info = df[i].getName().replaceAll("_", sep).replaceAll(".csv", "") + sep + sort.getName() + sep + top + sep + sts.getCompare() + sep + sts.getSwap();
					}

					if (check) {
						info += sep + analyzer.checkSort(data);
					}
					System.out.println(info);
					System.gc();
					try {
						Thread.sleep(500);
					} catch (InterruptedException e1) {
						e1.printStackTrace();
					}
					/*
										if (sort instanceof QSortAlgorithm) {
											System.out.println("compCount = " + ((QSortAlgorithm) sort).getCompCount());
										}
					*/
					if (writer != null) {
						writer.write(info);
						writer.newLine();
						writer.flush();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}

	}

	public static void displayTab(String msg, MonitoredData[] tab) {
		System.out.print(msg + " [");
		for (int i = 0; i < tab.length; i++) {
			if (i > 0) {
				System.out.print(", ");
			}
			System.out.print(tab[i]);
		}
		System.out.println("]");
	}

	public static void warmup(int nbSec) {
		long end = System.currentTimeMillis() + nbSec * 1000;
		long now = System.currentTimeMillis();
		System.out.println("warmup begin");

		do {
			int j = 0;
			for (int i = 0; i < 100000; i++) {
				j += i;
			}
			now = System.currentTimeMillis();
		} while (now < end);

		System.out.println("warmup end");
	}

	public static void main(String[] args) throws Exception {

		if (args.length < 3) {
			System.err.println("java SortTest [dataDirectory] [n / n2 / nlogn] [check] [outputFile (optionnal)]");
		}

		boolean check = new Boolean(args[2]).booleanValue();

		String type = args[1];

		boolean n2 = type.equalsIgnoreCase("N2");
		boolean nLogN = type.equalsIgnoreCase("NLOGN");
		boolean n = type.equalsIgnoreCase("N");

		String dataset = args[0];

		String outputFile = null;

		if (args.length > 3) {
			outputFile = args[3];
			writer = new BufferedWriter(new FileWriter(outputFile));
		}

		// -----------------------------------
		String title = "name" + sep + "dist" + sep + "num" + sep + "nb" + sep + "min" + sep + "max" + sep + "param" + sep + "algo" + sep + "ms" + sep + "comp" + sep + "swap";
		if (check) {
			title += sep + "check";
		}

		System.out.println(title);
		if (writer != null) {
			writer.write(title);
			writer.newLine();
			writer.flush();
		}
		
		int nb = 100;
		warmup(10);
		// fullTest(dataset, new HeapSort(false), false);
		smallTest(dataset, new QuickSort(true) , nb);
		smallTest(dataset, new QuickSort(false) , nb);
		//smallTest(dataset, new BubbleSort() , 10);
		//smallTest(dataset, new QuickSort(true) , 10);
		//smallTest(dataset, new MergeSort() , 10);
		//smallTest(dataset, new JavaCollecionSort() , 10);
		//smallTest(dataset, new ModifiedQuickSort(false, 7) , 10);
		// smallTest(dataset, new QuickSort(false) , nb);
		
		/*
		if (n2)
		*/
		// fullTest(dataset, new InsertionSort(), check);
		/*
		smallTest(dataset, new QuickSort(false), 100000);
		smallTest(dataset, new QuickSort(true) , 100000);
		
		
		smallTest(dataset, new MergeSort() , 100000);
		smallTest(dataset, new JavaCollecionSort() , 100000);
		
		*/
		//warmup(30);
		//smallTest(dataset, new InsertionSort(), 100000);
		/*
		smallTest(dataset, new ModifiedQuickSort(false, 7), 100000);
		smallTest(dataset, new QuickSort(false), 100000);
		smallTest(dataset, new QuickSort(true), 100000);
		smallTest(dataset, new JavaCollecionSort(), 100000);
		smallTest(dataset, new MergeSort(), 100000);
		*/
		//smallTest(dataset, new HeapSort(false), 10);
		/*
		smallTest(dataset, new QuickSort(false),             25);
		smallTest(dataset, new ModifiedQuickSort(false, 3),  25);
		smallTest(dataset, new ModifiedQuickSort(false, 7),  25);
		smallTest(dataset, new ModifiedQuickSort(false, 11), 25);
		*/
		//fullTest(dataset, new InsertionSort(), check);
		/*if (n2)
		fullTest(dataset, new BubbleSort(), check);
		*/
		/*
		if (nLogN)
		fullTest(dataset, new JavaCollecionSort(), check);
		if (nLogN)
		fullTest(dataset, new MergeSort(), check);
		if (nLogN)
		fullTest(dataset, new HeapSort(false), check);
		
		if (nLogN)
			fullTest(dataset, new QuickSort(false), check);
		*/
		/*
		if (nLogN)
			fullTest(dataset, new QuickSort(true), check);
		*/
		/*
		if (nLogN)
			fullTest(dataset, new QSortAlgorithm(), check);
		*/
		/*
		if (n || nLogN)
		fullTest(dataset, new DenombrementSort(false), check);
		*/
		if (writer != null) {
			writer.close();
		}
	}
}
