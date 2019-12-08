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
	| collection result format |
	collection := json at: #collection.
	format := json at: #format ifAbsent: [ #raw ].
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
	format = #html
		ifTrue: [ | f |
			f := [ 1 ] future.
			result
				do:
					[ :aPost | f zip: [ aPost content: (self convertHtml: aPost content) ] future ].
			f waitForCompletion: 10 seconds ].
	^ result
]

{ #category : #accessing }
PhlogLambdaGet >> lambdaClient: aClient [
	lambdaClient := aClient
]
