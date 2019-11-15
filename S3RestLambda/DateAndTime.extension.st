Extension { #name : #DateAndTime }

{ #category : #'*S3RestLambda' }
DateAndTime class >> neoJsonMapping: mapper [
	mapper
		for: DateAndTime
		customDo: [ :mapping | 
			mapping decoder: [ :string | DateAndTime fromString: string ].
			mapping encoder: [ :dateAndTime | dateAndTime printString ] ]
]
