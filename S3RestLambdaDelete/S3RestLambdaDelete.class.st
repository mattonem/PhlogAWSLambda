Class {
	#name : #S3RestLambdaDelete,
	#superclass : #S3RestLambda,
	#category : #S3RestLambdaDelete
}

{ #category : #accessing }
S3RestLambdaDelete class >> lambdaAction: aRequest [
	| json id result |
	json := NeoJSONReader fromString: aRequest contents.
	id := (json at: #id).
	bucket deleteObject: id.
	result := NeoJSONObject new.
	result
		at: #status put: 'deleted';
		at: #id put: id.
	^ result asString
]
