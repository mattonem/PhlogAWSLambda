Class {
	#name : #S3RestLambda,
	#superclass : #LambdaCommandLineHandler,
	#classInstVars : [
		'bucket',
		'prefix'
	],
	#category : #S3RestLambda
}

{ #category : #accessing }
S3RestLambda class >> bucketName [
	^ OSEnvironment current at: 'BUCKET_NAME'
]

{ #category : #accessing }
S3RestLambda class >> initLambda [
	super initLambda.
	AWSS3Config default
		accessKeyId: self s3AccessKeyId;
		secretKey: self s3secreteKey;
		sessionToken: self sessionToken;
		regionName: self region.
	self initializeBucket: self bucketName.
]

{ #category : #accessing }
S3RestLambda class >> initializeBucket: bucketName [
	| s3 |
	s3 := AWSS3 new.
	bucket := s3 bucketNamed: bucketName
]

{ #category : #accessing }
S3RestLambda class >> region [
	^ OSEnvironment current at: 'AWS_REGION'
]

{ #category : #accessing }
S3RestLambda class >> s3AccessKeyId [
	^ OSEnvironment current at: 'AWS_ACCESS_KEY_ID'
]

{ #category : #accessing }
S3RestLambda class >> s3secreteKey [
	^ OSEnvironment current at: 'AWS_SECRET_ACCESS_KEY'
]

{ #category : #accessing }
S3RestLambda class >> sessionToken [
	^ OSEnvironment current at: 'AWS_SESSION_TOKEN'
]
