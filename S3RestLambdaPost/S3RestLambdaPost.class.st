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
	| json id result payload |
	json := NeoJSONReader fromString: aRequest contents.
	payload := (json at: #payload).
	id := UUID new asString.
	bucket atKey: id putObject: payload asString.
	result := NeoJSONObject new.
	result
		at: #payload put: payload;
		at: #id put: id.
	^ result asString
]
