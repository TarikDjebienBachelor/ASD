/*
 * Created on 25 mars 2004
 * 
 * To change this generated comment go to Window>Preferences>Java>Code
 * Generation>Code Template
 */
package org.nherve.sort.data.generator;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import org.nherve.sort.Statistics;
import org.nherve.sort.data.SimpleInteger;

/**
 * @author nherve
 */
public class SimpleIntegerDataFactory {
	public final static String[] DISTRIBUTION = new String[] { "uniform-d", "gaussian", "increasing", "decreasing", "allmost-inc", "allmost-dec", "sinusoid", "allmost-sin", "shuffled" };
	public final static int RANDOM_DISTRIBUTION = 0;
	public final static int GAUSSIAN_DISTRIBUTION = 1;
	public final static int INCREASING_DISTRIBUTION = 2;
	public final static int ALLMOST_INCREASING_DISTRIBUTION = 4;
	public final static int DECREASING_DISTRIBUTION = 3;
	public final static int ALLMOST_DECREASING_DISTRIBUTION = 5;
	public final static int SINUSOID_DISTRIBUTION = 6;
	public final static int ALLMOST_SINUSOID_DISTRIBUTION = 7;
	public final static int SHUFFLED_DISTRIBUTION = 8;

	private Statistics sts;

	public SimpleIntegerDataFactory(Statistics sts) {
		super();

		this.sts = sts;
	}

	public void writeToFile(SimpleInteger[] data, String file, boolean overwrite) throws IOException {
		File f = new File(file);

		if (f.exists() && !overwrite) {
			throw new IOException("Le fichier existe deja : " + file);
		}

		FileWriter writer = new FileWriter(f);
		for (int i = 0; i < data.length; i++) {
			writer.write(data[i].toString() + "\r\n");
		}

		writer.close();
	}

	public long[] readFromFileAsLong(String file) throws IOException {
			BufferedReader reader = new BufferedReader(new FileReader(file));
			ArrayList lst = new ArrayList();
			String l = null;
			while ((l = reader.readLine()) != null) {
				lst.add(new Long(l));
			}
			reader.close();
			long[] res = new long[lst.size()];
			int i = 0;
			for (Iterator it = lst.iterator(); it.hasNext(); i++) {
				res[i] = ((Long) it.next()).longValue();
			}
			return res;
		}

	public SimpleInteger[] readFromFile(String file) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader(file));
		ArrayList lst = new ArrayList();
		String l = null;
		while ((l = reader.readLine()) != null) {
			lst.add(new SimpleInteger(l, sts));
		}
		reader.close();
		SimpleInteger[] res = new SimpleInteger[lst.size()];
		int i = 0;
		for (Iterator it = lst.iterator(); it.hasNext(); i++) {
			res[i] = (SimpleInteger) it.next();
		}
		return res;
	}

	private SimpleInteger[] generateRandomSimpleInteger(int nb, int min, int max) {
		SimpleInteger res[] = new SimpleInteger[nb];
		Random rd = new Random(System.currentTimeMillis());
		int v;
		int e = max - min + 1;
		for (int i = 0; i < nb; i++) {
			v = rd.nextInt(e) + min;
			res[i] = new SimpleInteger(v, sts);
		}
		return res;
	}

	private SimpleInteger[] generateGaussianSimpleInteger(int nb, int min, int max, int x) {
		SimpleInteger res[] = new SimpleInteger[nb];
		Random rd = new Random(System.currentTimeMillis());
		int v;
		boolean haveNextNextGaussian = false;
		double nextNextGaussian = 0;
		double d;
		int e = max - min;
		for (int i = 0; i < nb; i++) {
			do {
				if (haveNextNextGaussian) {
					haveNextNextGaussian = false;
					d = nextNextGaussian;
				} else {
					double v1, v2, s;
					do {
						v1 = 2 * rd.nextDouble() - 1;
						v2 = 2 * rd.nextDouble() - 1;
						s = v1 * v1 + v2 * v2;
					} while (s >= 1 || s == 0);
					double multiplier = Math.sqrt(-2 * Math.log(s) / s);
					nextNextGaussian = v2 * multiplier;
					haveNextNextGaussian = true;
					d = v1 * multiplier;
				}

				v = (int) Math.round((d + x) * e / (2 * x)) + min;
			}
			while ((v < min) || (v > max));

			res[i] = new SimpleInteger(v, sts);
		}
		return res;
	}

	private SimpleInteger[] generateFunctionSimpleInteger(int nb, MathematicalFunction f) {
		SimpleInteger res[] = new SimpleInteger[nb];
		double v = 0;
		int rv = 0;

		for (int i = 0; i < nb; i++) {
			v = f.getValue(i);
			rv = (int) Math.round(v);
			res[i] = new SimpleInteger(rv, sts);
		}

		return res;
	}

	public SimpleInteger[] generateSimpleInteger(int nb, int min, int max, int distribution, int parameter) {
		if (distribution == RANDOM_DISTRIBUTION) {
			return generateRandomSimpleInteger(nb, min, max);
		} else if (distribution == GAUSSIAN_DISTRIBUTION) {
			return generateGaussianSimpleInteger(nb, min, max, parameter);
		} else if (distribution == INCREASING_DISTRIBUTION) {
			double a = (max - min) / (double) (nb - 1);
			double b = min;
			LinearFunction f = new LinearFunction(a, b, false, 0);
			return generateFunctionSimpleInteger(nb, f);
			//return generateLinearSimpleInteger(nb, min, max, a, b);
		} else if (distribution == DECREASING_DISTRIBUTION) {
			double a = (min - max) / (double) (nb - 1);
			double b = max;
			LinearFunction f = new LinearFunction(a, b, false, 0);
			return generateFunctionSimpleInteger(nb, f);
			//return generateLinearSimpleInteger(nb, min, max, a, b);
		} else if (distribution == ALLMOST_INCREASING_DISTRIBUTION) {
			double a = (max - min - 2 * parameter) / (double) (nb - 1);
			double b = min + parameter;
			LinearFunction f = new LinearFunction(a, b, true, parameter);
			return generateFunctionSimpleInteger(nb, f);
			//return generateLinearNoiseSimpleInteger(nb, min, max, a, b, parameter);
		} else if (distribution == ALLMOST_DECREASING_DISTRIBUTION) {
			double a = (min - max + 2 * parameter) / (double) (nb - 1);
			double b = max - parameter;
			LinearFunction f = new LinearFunction(a, b, true, parameter);
			return generateFunctionSimpleInteger(nb, f);
			//return generateLinearNoiseSimpleInteger(nb, min, max, a, b, parameter);
		} else if (distribution == SINUSOID_DISTRIBUTION) {
			double a = (max - min) / 2;
			double b = a;
			double c = 2 * Math.PI / nb;
			SinusFunction f = new SinusFunction(a, b, c, false, parameter);
			return generateFunctionSimpleInteger(nb, f);
			//return generateLinearNoiseSimpleInteger(nb, min, max, a, b, parameter);
		} else if (distribution == ALLMOST_SINUSOID_DISTRIBUTION) {
			double a = (max - min) / 2 - parameter;
			double b = (max - min) / 2;
			double c = 2 * Math.PI / nb;
			SinusFunction f = new SinusFunction(a, b, c, true, parameter);
			return generateFunctionSimpleInteger(nb, f);
			//return generateLinearNoiseSimpleInteger(nb, min, max, a, b, parameter);
		} else if (distribution == SHUFFLED_DISTRIBUTION) {
			SimpleInteger[] si = new SimpleInteger[nb];
			for (int i = 0; i < nb; i++) {
				si[i] = new SimpleInteger(min + i, sts);
			}
			List l = Arrays.asList(si);
			Collections.shuffle(l);
			return (SimpleInteger[])l.toArray();
		} else {
			return null;
		}
	}

}
