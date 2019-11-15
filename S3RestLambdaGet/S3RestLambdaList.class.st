Class {
	#name : #S3RestLambdaList,
	#superclass : #S3RestLambdaGet,
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaList >> lambdaAction: json [
	| offset limit prefix |
	offset := json at: #offset ifAbsent: 1.
	limit := json at: #limit ifAbsent: 10.
	prefix := json at: #prefix.
	^ (offset to: limit) collect: [ :i | indexes at: prefix at: i ]
]

{ #category : #accessing }
S3RestLambdaList >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndex in: aBucketMock for: collection value: #order.
]
