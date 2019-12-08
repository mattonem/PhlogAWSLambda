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
	| collection result |
	collection := json at: #collection.
	result := OrderedCollection new.
	phlog := (NeoJSONReader on: (bucket getObject: 'phlog') readStream)
		nextAs: Phlog.
	collection := phlog collection: collection.
	json
		at: #id
		ifPresent: [ :id | result add: (collection searchId: id) ].
	json
		at: #offset
		ifPresent: [ :offset | 
			json
				at: #limit
				ifPresent: [ :limit | result add: (collection offset: offset limit: limit) ] ].
	^ result
]
