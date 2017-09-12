
logarithm(b, x){
	;Returns the log base b of x as a floating point.
	;See http://www.purplemath.com/modules/logrules5.htm
	
	return log(x) / log(b)
}

Class CumulativeMovingAverage{
	;Calculates the cumulative moving average.
	; See http://en.wikipedia.org/wiki/Moving_average#Cumulative_moving_average
	
	__n := 0
	__previous := 0
	
	sample(value){
		;Samples the passed value and adds it to the average.
		
		this.__previous := (value + this.__n * this.__previous) / (this.__n + 1)
		this.__n++
	}
	
	average[]{
		get{
			;Returns the current average
			
			return this.__previous
		}
	}
}
