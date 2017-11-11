/*
 * Created on 2 avr. 2004
 */
package org.nherve.sort.data;

import org.nherve.sort.Statistics;

	public class Infinite implements MonitoredData {
		private Statistics sts;

		public Statistics getStatistics() {
			return sts;
		}

		public void setStatistics(Statistics sts) {
			this.sts = sts;
		}

		public int compareTo(Object o) {
			sts.addCompare();
			return 1;
		}

		/* (non-Javadoc)
		 * @see java.lang.Object#toString()
		 */
		public String toString() {
			return "infinite";
		}

		/* (non-Javadoc)
		 * @see org.nherve.sort.data.MonitoredData#getValueAsInt()
		 */
		public int getValueAsInt() {
			return Integer.MAX_VALUE;
		}

	}
