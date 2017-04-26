package optimal;

import java.util.ArrayList;
import java.util.Scanner;

public class Optimal {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Scanner sc = new Scanner(System.in);
		
		int frameSize = 3;		// cache frame size
		int currSize = 0;		// current size of frame
		
		ArrayList<Integer> cache = new ArrayList<Integer>(frameSize);	// simulates cache
		
		int listSize = sc.nextInt();
		
		int[] pageList = new int[listSize];
		
		for(int i = 0; i < pageList.length; i++) {
			pageList[i] = sc.nextInt();
		}
		
		for(int i = 0; i < pageList.length; i++) {
			
			if(cache.contains( pageList[i] ) ) {	// page in cache do nothing
				//cache.remove((Integer)pageNo);
				//cache.add(pageNo);	
			}
			
			else {		// page not in cache
				if(frameSize > currSize){		// if there is still space in cache
					cache.add(pageList[i]);
					currSize++;
				}
				
				else {
					int[] retime = new int[frameSize];
					for(int l = 0; l < frameSize; l++) {
						retime[l] = pageList.length;
						
					}
					
					for(int l = 0; l < frameSize; l++) {
						for(int j = pageList.length-1; j > i; j--) {
							if (pageList[j] == cache.get(l)) {
								retime[l] = j;
								break;
							}
							
						}
					}
					
					int max = retime[0];
					int pos = 0;
					boolean replace = false;
					for(int l = 0; l < frameSize; l++) {
						if(retime[l] == pageList.length) {
							cache.remove(l);
							cache.add(pageList[i]);
							replace = true;
							break;
						}
						else {
							if(retime[l] > max) {
								max = retime[l];
								pos = l;
							}
						}
					}
					
					if(!replace) {
						cache.remove(pos);
						cache.add(pageList[i]);
					}
				}
			}
			
			// print the cache frame
			for(int k = 0; k < currSize; k++) {
				System.out.print(cache.get(k) + " ");
			}
			
			System.out.println();
			
		}	// do until a valid page number is entered
		
		sc.close();
		
	}

}
