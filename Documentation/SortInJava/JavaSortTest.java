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
public class JavaSortTest {

	private final static String sep = ",";
	private static BufferedWriter writer = null;

	/**
	 *  
	 */
	public JavaSortTest() {
		super();
	}

	private static void smallTest(String directory, boolean primitif, int nb) {
		JavaSort sort = new JavaSort();
		Statistics sts = new Statistics();
		sort.setStatistics(sts);

		SimpleIntegerDataFactory factory = new SimpleIntegerDataFactory(sts);

		File dir = new File(directory);

		MonitoredData[][] datas = new MonitoredData[nb][];
		long[][] datasL = new long[nb][];
		long top = 0;
		if (dir.exists() && dir.isDirectory()) {
			File[] df = dir.listFiles();
			for (int i = 0; i < df.length; i++) {
				try {
					if (primitif) {
						for (int n = 0; n < nb; n++) {
							datasL[n] = factory.readFromFileAsLong(df[i].getAbsolutePath());
						}
					} else {
						for (int n = 0; n < nb; n++) {
							datas[n] = factory.readFromFile(df[i].getAbsolutePath());
						}
					}
					sts.start();
					sts.reinit();
					if (primitif) {
						sts.top();
						//System.out.print(sort + " - " + df[i]);
						for (int n = 0; n < nb; n++) {
							sort.sort(datasL[n]);
						}
						top = sts.top();
					} else {
						sts.top();
						//System.out.print(sort + " - " + df[i]);
						for (int n = 0; n < nb; n++) {
							sort.sort(datas[n]);
						}
						top = sts.top();

					}
					//System.out.println("ok");
					//displayTab("", data);
					String info = df[i].getName().replaceAll("_", sep).replaceAll(".csv", "") + sep + sort.getName() + "(" + (primitif ? "long" : "SimpleInteger") + ")" + sep + top + sep + sts.getCompare() + sep + sts.getSwap();

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

		String dataset = args[0];

		String outputFile = null;

		outputFile = args[1];
		writer = new BufferedWriter(new FileWriter(outputFile));

		// -----------------------------------
		String title = "name" + sep + "dist" + sep + "num" + sep + "nb" + sep + "min" + sep + "max" + sep + "param" + sep + "algo" + sep + "ms" + sep + "comp" + sep + "swap";

		System.out.println(title);
		if (writer != null) {
			writer.write(title);
			writer.newLine();
			writer.flush();
		}

		int nb = 10;
		warmup(10);
		smallTest(dataset, false, nb);
		smallTest(dataset, true, nb);

		if (writer != null) {
			writer.close();
		}
	}
}
