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
	payload at: #id put: id.
	payload at: #next put: nil.
	bucket atKey: id putObject: (NeoJSONWriter toString: payload).
	self updateMetadata: collection root: id.
	result := NeoJSONObject new.
	result
		at: #payload put: payload;
		at: #id put: id.
	^ result asString
]

{ #category : #accessing }
S3RestLambdaPost >> updateMetadata: collection root: id. [
	bucket
		atKey: collection , '/_metadata'
		putObject:
			(NeoJSONWriter
				toString:
					(Dictionary
						newFromPairs:
							{#lastUpdate.
							DateAndTime now.
							#root.
							id}))
]
