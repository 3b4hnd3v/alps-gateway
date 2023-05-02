package com.alps;

public class PrimeCounter {
	static long MAX_PRIME = 10000000;

	private static boolean isPrime(int prime) {
	    if (prime <1 || prime % 2 == 0){
	        return false;
	    }

	    for(int i = 2; i <= Math.sqrt(prime) ; i++) {
	        if ((prime % i) == 0) {
	            return false;
	        }
	    }
	    return true;
	}


	/**
	 * Count howmany prime exsit between user input and 10,000.
	 * @param test if the number is prime.
	 * @return the number of primes are found.
	 */
	public int countPrimes(int userInput){
	    int count =0;
	        for(int i=userInput; i<=MAX_PRIME; i++) {
	            if(isPrime(i)){
	                count++;
	            }
	        }
	    return count;   
	    }
}
