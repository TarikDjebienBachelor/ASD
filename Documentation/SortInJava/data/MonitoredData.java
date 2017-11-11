/*
 * Created on 25 mars 2004
 *
 * To change this generated comment go to 
 * Window>Preferences>Java>Code Generation>Code Template
 */
package org.nherve.sort.data;

import org.nherve.sort.Statistics;

/**
 * @author nherve
 */
public interface MonitoredData extends Comparable {
	void setStatistics(Statistics sts);
	Statistics getStatistics();
	int getValueAsInt();
}
