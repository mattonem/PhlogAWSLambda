Class {
	#name : #S3RestLambdaGet,
	#superclass : #S3RestLambda,
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaGet class >> lambdaAction: aRequest [
	| json id result payload |
	json := NeoJSONReader fromString: aRequest contents.
	id := (json at: #id).
	payload := bucket getObject: id.
	result := NeoJSONObject new.
	result
		at: #payload put: payload;
		at: #id put: id.
	^ result asString
]
