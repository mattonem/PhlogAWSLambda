Class {
	#name : #S3RestLambdaPut,
	#superclass : #S3RestLambda,
	#classInstVars : [
		'bucket'
	],
	#category : #S3RestLambdaPut
}

{ #category : #accessing }
S3RestLambdaPut class >> lambdaAction: aRequest [
	| json id result payload |
	json := NeoJSONReader fromString: aRequest contents.
	payload := (json at: #payload).
	id := (json at: #id).
	bucket atKey: id putObject: payload asString.
	result := NeoJSONObject new.
	result
		at: #payload put: payload;
		at: #id put: id.
	^ result asString
]
