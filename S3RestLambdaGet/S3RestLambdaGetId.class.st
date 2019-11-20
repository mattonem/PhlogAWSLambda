Class {
	#name : #S3RestLambdaGetId,
	#superclass : #S3RestLambdaGet,
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaGetId >> lambdaAction: json [
	| id payload format collection index |
	id := json at: #id.
	collection := (id findTokens: '/') first.
	format := json at: #format ifAbsent: 'raw'.
	index := indexes
		at: collection
		ifAbsentPut: [ self newIndexBucket: bucket collection: collection ].
	payload := (index at: id) copy.
	payload
		at: #content
		put:
			(format = 'html'
				ifTrue: [ self toHtml: (payload at: #content) ]
				ifFalse: [ payload at: #content ]).
	^ payload
]

{ #category : #indexes }
S3RestLambdaGetId >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndex in: aBucketMock for: collection value: #id.
]
