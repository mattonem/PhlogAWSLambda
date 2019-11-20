Class {
	#name : #S3RestLambdaGetLast,
	#superclass : #S3RestLambdaGet,
	#category : #S3RestLambdaGet
}

{ #category : #'instance creation' }
S3RestLambdaGetLast >> lambdaAction: json [
	| prefix index format payload |
	
	prefix := json at: #prefix.
	format := json at: #format ifAbsent: 'raw'.
	index := indexes
		at: prefix
		ifAbsentPut: [ self newIndexBucket: bucket collection: prefix ].
	payload := index last.
	payload
		at: #content
		put:
			(format = 'html'
				ifTrue: [ self toHtml: (payload at: #content) ]
				ifFalse: [ payload at: #content ]).
	^ payload
]

{ #category : #'instance creation' }
S3RestLambdaGetLast >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndexOrder in: aBucketMock for: collection value: #order.
]
