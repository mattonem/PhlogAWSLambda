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
	| result |
	phlog := Phlog fromJson: (bucket getObject: 'phlog').
	result := phlog.
	json
		at: #collection
		ifPresent:
			[ :collection | result := phlog select: [ :post | post collection = collection ] ].
	^ result size
]
