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
	| json result |
	json := NeoJSONReader fromString: aRequest contents.
	bucket atKey: (json at: #id) putObject: (json at: #paylaod).
	result := NeoJSONObject new.
	result at: #payload put: json.
	^ result asString
]
