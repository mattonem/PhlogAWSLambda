Class {
	#name : #S3RestLambdaPost,
	#superclass : #S3RestLambda,
	#classInstVars : [
		'qqq'
	],
	#category : #S3RestLambdaPost
}

{ #category : #accessing }
S3RestLambdaPost >> getMetadata: collection [
	^ (NeoJSONReader
		on: (bucket getObject: collection , '/_metadata') readStream)
		for: #Metadata
			do: [ :mapping | 
			mapping subjectClass: NeoJSONObject.
			(mapping mapAccessor: #lastUpdate) valueSchema: DateAndTime.
			mapping mapAccessor: #root ];
		nextAs: #Metadata
]

{ #category : #accessing }
S3RestLambdaPost >> lambdaAction: json [
	| id result payload collection metadata previousRootId |
	collection := json at: #prefix.
	metadata := self getMetadata: collection.
	previousRootId := metadata at: #root.
	payload := json at: #payload.
	id := collection , '/' , UUID new asString.
	payload at: #id put: id.
	payload at: #next put: previousRootId.
	bucket atKey: id putObject: (NeoJSONWriter toString: payload).
	self updateMetadata: collection root: id.
	result := NeoJSONObject new.
	result
		at: #payload put: payload;
		at: #id put: id.
	^ result
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
