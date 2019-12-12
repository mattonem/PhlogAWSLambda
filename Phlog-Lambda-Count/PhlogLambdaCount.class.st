Class {
	#name : #PhlogLambdaCount,
	#superclass : #S3RestLambda,
	#instVars : [
		'phlog'
	],
	#category : #'Phlog-Lambda-Count'
}

{ #category : #accessing }
PhlogLambdaCount >> lambdaAction: json [
	| collection result |
	collection := json at: #collection.
	phlog := Phlog fromJson: (bucket getObject: 'phlog').
	result := phlog.
	collection
		ifNotNil: [ result := phlog select: [ :post | post collection = collection ] ].
	^ result size
]
