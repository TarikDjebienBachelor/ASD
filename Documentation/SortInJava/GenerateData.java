/*
 * Created on 25 mars 2004
 * 
 * To change this generated comment go to Window>Preferences>Java>Code
 * Generation>Code Template
 */
package org.nherve.sort;

import java.io.File;
import java.io.IOException;

import org.nherve.sort.data.SimpleInteger;
import org.nherve.sort.data.analyzer.SimpleIntegerAnalyzer;
import org.nherve.sort.data.generator.SimpleIntegerDataFactory;

/**
 * @author nherve
 */
public class GenerateData {

	/**
	 *  
	 */
	public GenerateData() {
		super();
	}

	private static void generateFullDataSet(boolean delete, String directory, String filePrefix, String fileSuffix, int nbSet, int nb[], int[] min, int[] max) {
		SimpleIntegerDataFactory factory = new SimpleIntegerDataFactory(null);
		File dir = new File(directory);

		if (delete) {
			if (dir.exists() && dir.isDirectory()) {
				File[] df = dir.listFiles();
				for (int i = 0; i < df.length; i++) {
					df[i].delete();
				}
			}
		}

		dir.mkdirs();

		Statistics sts = new Statistics();
		sts.start();

		for (int d = 0; d < SimpleIntegerDataFactory.DISTRIBUTION.length; d++) {
			generateDistributionFullDataSet(d, sts, factory, directory, filePrefix, fileSuffix, nbSet, nb, min, max);
		}
	}

	private static void generateDistributionFullDataSet(int distribution, Statistics sts, SimpleIntegerDataFactory factory, String directory, String filePrefix, String fileSuffix, int nbSet, int nb[], int[] min, int[] max) {
		if (factory == null) {
			factory = new SimpleIntegerDataFactory(null);
		}

		if (sts == null) {
			sts = new Statistics();
			sts.start();
		}

		for (int mn = 0; mn < min.length; mn++) {
			for (int mx = 0; mx < max.length; mx++) {
				int parameter = 0;

				if (distribution == SimpleIntegerDataFactory.GAUSSIAN_DISTRIBUTION) {
					parameter = 4;
				} else if ((distribution == SimpleIntegerDataFactory.ALLMOST_DECREASING_DISTRIBUTION) || (distribution == SimpleIntegerDataFactory.ALLMOST_INCREASING_DISTRIBUTION) || (distribution == SimpleIntegerDataFactory.ALLMOST_SINUSOID_DISTRIBUTION)) {
					parameter = (int) Math.round(Math.abs(max[mx] - min[mn]) / 10d);
				}

				for (int n = 0; n < nb.length; n++) {
					for (int ns = 0; ns < nbSet; ns++) {
						String filename = directory + File.separator + filePrefix + "_" + SimpleIntegerDataFactory.DISTRIBUTION[distribution] + "_" + ns + "_" + nb[n] + "_" + min[mn] + "_" + max[mx] + "_" + parameter + fileSuffix;
						SimpleInteger[] data = factory.generateSimpleInteger(nb[n], min[mn], max[mx], distribution, parameter);
						try {
							factory.writeToFile(data, filename, false);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					System.out.println(sts.top() + " ms - " + SimpleIntegerDataFactory.DISTRIBUTION[distribution] + " - " + nb[n] + " points - min : " + min[mn] + " - max : " + max[mx]);
				}
			}

		}
	}

	public static void main(String[] args) throws IOException {
		// generateFullDataSet(true, "sample", "test", ".csv", 1, new int[] { 100 }, new int[] { 1 }, new int[] { 100 });
		// generateFullDataSet(true, "testNlogN", "test", ".csv", 10, new int[] { 1000, 2500, 5000, 7500, 10000 }, new int[] { 1 }, new int[] { 10000 });
		// generateFullDataSet(true, "testNlogN", "test", ".csv", 1, new int[] { 100000, 200000, 300000, 400000, 500000 }, new int[] { 1 }, new int[] { 10000 });
		// generateDistributionFullDataSet(SimpleIntegerDataFactory.RANDOM_DISTRIBUTION, null, null, "testNlogN", "test", ".csv", 100, new int[] { 500, 1000, 2500, 5000, 7500, 10000, 60000, 100000, 500000, 1000000 }, new int[] { 1 }, new int[] { 1000000 });
		generateDistributionFullDataSet(SimpleIntegerDataFactory.INCREASING_DISTRIBUTION, null, null, "testNlogN", "test", ".csv", 10, new int[] { 10000 }, new int[] { 1 }, new int[] { 10000 });
		// generateDistributionFullDataSet(SimpleIntegerDataFactory.SHUFFLED_DISTRIBUTION, null, null, "testJava", "test", ".csv", 10, new int[] { 10000, 50000, 100000 }, new int[] { 1 }, new int[] { 10000 });
		// generateFullDataSet(true, "testNlogN", "test", ".csv", 1, new int[] {  100, 500, 1000 }, new int[] { 1 }, new int[] { 10000 });
		//generateFullDataSet(true, "testData", "test", ".csv", 100, new int[] { 1000 }, new int[] { 1 }, new int[] { 10000 });

		/*
		SimpleIntegerDataFactory factory = new SimpleIntegerDataFactory(null);
		SimpleInteger[] d = factory.readFromFile("E:/Nicolas/CNAM/Probatoire/Sort/sample/" + "test_increasing_0_100_1_100_0.csv");
		
		SimpleIntegerAnalyzer analyzer = new SimpleIntegerAnalyzer();
		analyzer.analyzeDistribution(d);
		*/

	}
}
