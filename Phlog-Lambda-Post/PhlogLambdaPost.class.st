Class {
	#name : #PhlogLambdaPost,
	#superclass : #S3RestLambda,
	#instVars : [
		'phlog'
	],
	#category : #'Phlog-Lambda-Post'
}

{ #category : #accessing }
PhlogLambdaPost >> lambdaAction: json [
	| content collection |
	collection := json at: #collection.
	content := json at: #content.
	phlog := (NeoJSONReader on: (bucket objectAt: 'phlog') readStream)
		nextAs: Phlog.
	(phlog collection: collection) post: content.
	bucket atKey: 'phlog' putObject: (NeoJSONWriter toString: phlog).
	^ phlog
]
