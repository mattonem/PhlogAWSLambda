Class {
	#name : #PhlogLambdaGet,
	#superclass : #S3RestLambda,
	#instVars : [
		'phlog',
		'lambdaClient'
	],
	#category : #'Phlog-Lambda-Get'
}

{ #category : #accessing }
PhlogLambdaGet >> convertHtml: aString [
	^ NeoJSONReader
		fromString:
			(lambdaClient
				invokeLambda: 'MDownToHTMLLambda'
				withPayload: (NeoJSONWriter toString: aString)) contents
]

{ #category : #accessing }
PhlogLambdaGet >> initLambda [
	super initLambda.
	AWSLambdaConfig default
		accessKeyId: self s3AccessKeyId;
		secretKey: self s3secreteKey;
		sessionToken: self sessionToken;
		regionName: self region.
	self lambdaClient: AWSLambda new.
]

{ #category : #accessing }
PhlogLambdaGet >> lambdaAction: json [
	| result format collection |
	collection := json at: #collection.
	format := json at: #format ifAbsent: [ #raw ].
	result := OrderedCollection new.
	phlog := Phlog fromJson: (bucket getObject: 'phlog').
	json
		at: #id
		ifPresent: [ :id | result addAll: (phlog select: [ :post | post id = id ]) ].
	json
		at: #offset
		ifPresent: [ :offset | 
			json
				at: #limit
				ifPresent: [ :limit | 
					result
						addAll: (phlog select: [ :post | post collection = collection ]) ] ].
	format = #html
		ifTrue: [ | f |
			f := [ 1 ] future.
			result
				do: [ :aPost | 
					f := f
						zip: [ aPost content: (self convertHtml: aPost content) ] future ].
			f waitForCompletion: 10 seconds ].
	^ result
]

{ #category : #accessing }
PhlogLambdaGet >> lambdaClient: aClient [
	lambdaClient := aClient
]
