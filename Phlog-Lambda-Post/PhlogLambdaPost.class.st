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
	phlog := Phlog fromJson: (bucket getObject: 'phlog').
	phlog add: (PhlogPost collection: collection content: content ).
	bucket atKey: 'phlog' putObject: phlog serialize.
	^ phlog
]
