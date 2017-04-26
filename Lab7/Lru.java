package lru;

//Author: Rajdeep Pinge
//Date: 20-02-2017

/* code to simulate page replacement algorithm 
* with least recently used replacement method
*/

import java.util.ArrayList;
import java.util.Scanner;

public class Lru {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Scanner sc = new Scanner(System.in);
		
		int frameSize = 5;		// cache frame size
		int currSize = 0;		// current size of frame
		
		ArrayList<Integer> cache = new ArrayList<Integer>(frameSize);	// simulates cache
		
		int pageNo = 0;
		
		do {		// at least once
			pageNo = sc.nextInt();
			
			if(cache.contains((Integer)pageNo)) {	// page in cache
				cache.remove((Integer)pageNo);
				cache.add(pageNo);	
			}
			
			else {		// page not in cache
				if(frameSize > currSize){		// if there is still space in cache
					cache.add(pageNo);
					currSize++;
				}
				else {	// frameSize == currSize therefore must replace
					cache.remove(0);
					cache.add(pageNo);
				}
			}
			
			// print the cache frame
			for(int i = 0; i < currSize; i++) {
				System.out.print(cache.get(i) + " ");
			}
			
			System.out.println();
			
		}while (pageNo != 0);	// do until a valid page number is entered
		
		sc.close();
	}

}
