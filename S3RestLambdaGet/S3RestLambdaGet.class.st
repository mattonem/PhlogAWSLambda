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
S3RestLambdaGet >> lambdaClient: aClient [
	lambdaClient := aClient
]

{ #category : #accessing }
S3RestLambdaGet >> toHtml: aString [
	
	^ NeoJSONReader fromString: (lambdaClient 
		invokeLambda: 'MDownToHTMLLambda'
		withPayload: (NeoJSONWriter toString: aString)) contents
]
