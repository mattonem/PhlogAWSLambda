Class {
	#name : #S3RestLambdaGetList,
	#superclass : #S3RestLambdaGet,
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaGetList >> lambdaAction: json [
	| offset limit prefix index result |
	offset := json at: #offset ifAbsent: 1.
	limit := json at: #limit ifAbsent: 10.
	prefix := json at: #prefix.
	result := OrderedCollection new.
	offset to: limit do: [ :i | 
		index := indexes
			at: prefix
			ifAbsentPut: [ self newIndexBucket: bucket collection: prefix ].
		index
			at: i
			ifPresent: [ :payload | result add: payload ]
			ifAbsent: [  ] ].
	^ result
]

{ #category : #accessing }
S3RestLambdaGetList >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndex in: aBucketMock for: collection value: #order.
]