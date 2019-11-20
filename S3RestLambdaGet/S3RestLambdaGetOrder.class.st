Class {
	#name : #S3RestLambdaGetOrder,
	#superclass : #S3RestLambdaGet,
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaGetOrder >> lambdaAction: json [
	| prefix index format order payload |
	order := json at: #order.
	prefix := json at: #prefix.
	format := json at: #format ifAbsent: 'raw'.
	index := indexes
		at: prefix
		ifAbsentPut: [ self newIndexBucket: bucket collection: prefix ].
	payload := index at: order.
	payload
		at: #content
		put:
			(format = 'html'
				ifTrue: [ self toHtml: (payload at: #content) ]
				ifFalse: [ payload at: #content ]).
	^ payload
]

{ #category : #accessing }
S3RestLambdaGetOrder >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndex in: aBucketMock for: collection value: #order.
]
