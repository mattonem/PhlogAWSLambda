Class {
	#name : #S3RestLambdaGetList,
	#superclass : #S3RestLambdaGet,
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaGetList >> lambdaAction: json [
	| offset limit prefix index |
	offset := json at: #offset ifAbsent: 1.
	limit := json at: #limit ifAbsent: 10.
	prefix := json at: #prefix.
	^ (offset to: limit)
		collect: [ :i | 
			index := indexes
				at: prefix
				ifAbsentPut: [ self newIndexBucket: bucket collection: prefix ].
			index at: i ]
]

{ #category : #accessing }
S3RestLambdaGetList >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndex in: aBucketMock for: collection value: #order.
]
