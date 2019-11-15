Class {
	#name : #S3RestLambdaPost,
	#superclass : #S3RestLambda,
	#classInstVars : [
		'qqq'
	],
	#category : #S3RestLambdaPost
}

{ #category : #accessing }
S3RestLambdaPost >> lambdaAction: json [
	| id result payload collection |
	collection := (json at: #collection).
	payload := (json at: #payload).
	id := collection, '/' , UUID new asString.
	bucket atKey: id putObject: (NeoJSONWriter toString: payload).
	self updateLastUpdateTime: collection.
	result := NeoJSONObject new.
	result
		at: #payload put: payload;
		at: #id put: id.
	^ result asString
]

{ #category : #accessing }
S3RestLambdaPost >> updateLastUpdateTime: collection [
	bucket
		atKey: collection , '/metadata'
		putObject:
			(NeoJSONWriter
				toString:
					(Dictionary
						newFromPairs:
							{#lastUpdate.
							DateAndTime now}))
]
