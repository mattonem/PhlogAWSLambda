Class {
	#name : #S3RestLambdaGet,
	#superclass : #S3RestLambda,
	#instVars : [
		'lambdaClient',
		'indexes'
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
S3RestLambdaGet >> initialize [ 	
	indexes := Dictionary new.
]

{ #category : #accessing }
S3RestLambdaGet >> lambdaAction: json [
	| id payload format response collection index |
	id := json at: #id.
	collection := (id findTokens:'/') first.
	format := json at: #format ifAbsent: 'raw'.
	index := indexes at: collection ifAbsentPut: [ self newIndexBucket: bucket collection: collection 	].
	payload := index at: id.
	"payload := NeoJSONReader fromString: (bucket getObject: id)."
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

{ #category : #indexes }
S3RestLambdaGet >> newIndexBucket: aBucketMock collection: collection [ 
	^ S3RestIndex in: aBucketMock for: collection value: #id.
]

{ #category : #accessing }
S3RestLambdaGet >> toHtml: aString [
	
	^ NeoJSONReader fromString: (lambdaClient 
		invokeLambda: 'MDownToHTMLLambda'
		withPayload: (NeoJSONWriter toString: aString)) contents
]
