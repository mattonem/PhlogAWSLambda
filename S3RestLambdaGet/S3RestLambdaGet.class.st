Class {
	#name : #S3RestLambdaGet,
	#superclass : #S3RestLambda,
	#instVars : [
		'lambdaClient'
	],
	#category : #S3RestLambdaGet
}

{ #category : #accessing }
S3RestLambdaGet >> initLambda [
	super initLambda.
	AWSLambdaConfig default
		accessKeyId: self s3AccessKeyId;
		secretKey: self s3secreteKey;
		sessionToken: self sessionToken;
		regionName: self region.
	self lambdaClient: AWSLambda new.
]

{ #category : #accessing }
S3RestLambdaGet >> lambdaAction: json [
	| id payload format response |
	id := json at: #id.
	format := json at: #format ifAbsent: 'raw'.
	payload := NeoJSONReader fromString: (bucket getObject: id).
	response := Dictionary new.
	response
		at: #payload put: payload;
		at: #id put: id.
	format = 'html'
		ifTrue: [ response
				at: #payload
				at: #content
				put: (self toHtml: (response at: #payload at: #content)) ].
	^ response
]

{ #category : #accessing }
S3RestLambdaGet >> lambdaClient: aClient [
	lambdaClient := aClient
]

{ #category : #accessing }
S3RestLambdaGet >> toHtml: aString [
	
	^ NeoJSONReader fromString: (lambdaClient 
		invokeLambda: 'MDownToHTMLLambda'
		withPayload: (NeoJSONWriter toString: aString)) contents
]
