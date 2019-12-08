Class {
	#name : #PhlogLambdaGet,
	#superclass : #S3RestLambda,
	#instVars : [
		'phlog'
	],
	#category : #'Phlog-Lambda-Get'
}

{ #category : #accessing }
PhlogLambdaGet >> lambdaAction: json [
	| collection id post |
	collection := json at: #collection.
	id := json at: #id.
	phlog := (NeoJSONReader on: (bucket getObject: 'phlog') readStream)
		nextAs: Phlog.
	post := (phlog collection: collection) searchId: id.
	^ post
]
