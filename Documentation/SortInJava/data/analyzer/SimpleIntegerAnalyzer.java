/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.data.analyzer;

import org.nherve.sort.data.MonitoredData;
import org.nherve.sort.data.SimpleInteger;

/**
 * @author nherve
 */
public class SimpleIntegerAnalyzer {

	public SimpleIntegerAnalyzer() {
		super();
	}
	
	public void analyzeDistribution(SimpleInteger[] data) {
		int min = Integer.MAX_VALUE;
		int max = Integer.MIN_VALUE;
		
		for (int i = 0; i < data.length; i++) {
			int v = data[i].getValue();
			if (v < min) min = v;
			if (v > max) max = v;
		}
		
		int[] dist = new int[max-min+1];
		for (int i = 0; i < data.length; i++) {
			long v = data[i].getValue();
			dist[(int)(v-min)]++;
		}
		
		int total = 0;
		for (int i = 0; i < dist.length; i++) {
			total += dist[i];
			System.out.println(""+(i+min)+","+dist[i]);
		}
		System.out.println("total : " + total);
	}
	
	public boolean checkSort(MonitoredData[] data) {
		for (int i = 1; i < data.length; i++) {
			if (data[i-1].compareTo(data[i]) > 0) {
				return false;
			} 
		}
		return true;
	}

}
