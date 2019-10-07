Class {
	#name : #S3RestLambdaPost,
	#superclass : #S3RestLambda,
	#classInstVars : [
		'bucket'
	],
	#category : #S3RestLambdaPost
}

{ #category : #accessing }
S3RestLambdaPost class >> lambdaAction: aRequest [
	| json id result |
	json := NeoJSONReader fromString: aRequest contents.
	id := UUID new asString.
	bucket atKey: UUID new asString putObject: (json at: #paylaod).
	result := NeoJSONObject new.
	result
		at: #payload put: json;
		at: #id put: id.
	^ result asString
]
