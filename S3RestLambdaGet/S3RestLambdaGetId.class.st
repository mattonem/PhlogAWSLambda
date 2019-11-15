Class {
	#name : #S3RestLambdaGetId,
	#superclass : #S3RestLambdaGet,
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaGetId >> lambdaAction: json [
	| id payload format response collection index |
	Stdio stderr << 'start getId'.
	id := json at: #id.
	collection := (id findTokens:'/') first.
	format := json at: #format ifAbsent: 'raw'.
	index := indexes at: collection ifAbsentPut: [ self newIndexBucket: bucket collection: collection 	].
	payload := index at: id.
	response := Dictionary new.
	response
		at: #payload put: payload;
		at: #id put: id.
	"format = 'html'
		ifTrue: [ response
				at: #payload
				at: #content
				put: (self toHtml: (response at: #payload at: #content)) ]."
	^ response
]

{ #category : #indexes }
S3RestLambdaGetId >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndex in: aBucketMock for: collection value: #id.
]
