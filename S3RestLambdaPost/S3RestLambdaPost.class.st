Class {
	#name : #S3RestLambdaPost,
	#superclass : #S3RestLambda,
	#classInstVars : [
		'qqq'
	],
	#category : #S3RestLambdaPost
}

{ #category : #accessing }
S3RestLambdaPost class >> lambdaAction: aRequest [
	| json id result payload collection |
	json := NeoJSONReader fromString: aRequest contents.
	collection := (json at: #collection).
	collection isEmpty ifTrue: [ Error signal: 'collection cannot be empty' ].
	payload := (json at: #payload).
	id := collection, '/' , UUID new asString.
	bucket atKey: id putObject: payload asString.
	result := NeoJSONObject new.
	result
		at: #payload put: payload;
		at: #id put: id.
	^ result asString
]
