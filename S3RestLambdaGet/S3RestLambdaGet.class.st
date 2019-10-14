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
S3RestLambdaGet >> lambdaAction: aRequest [
	| json id payload format |
	json := NeoJSONReader fromString: aRequest contents.
	id := json at: #id.
	format := json at: #format ifAbsent: 'raw'.
	payload := NeoJSONReader fromString: (bucket getObject: id).
	json
		at: #payload put: payload;
		at: #id put: id.
	format = 'html'
		ifTrue: [ json := self toHtml: json ].
	^ NeoJSONWriter toString: json 
]

{ #category : #accessing }
S3RestLambdaGet >> lambdaClient: aClient [
	lambdaClient := aClient
]

{ #category : #accessing }
S3RestLambdaGet >> toHtml: aPayload [
	aPayload at: #jsonPath put: '.payload.content'.
	^ NeoJSONReader fromString: (lambdaClient
		invokeRequest: 'MDownToHTMLLambda'
		withPayload: (NeoJSONWriter toString: aPayload)) contents
]
