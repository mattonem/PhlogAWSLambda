Class {
	#name : #S3RestLambda,
	#superclass : #LambdaCommandLineHandler,
	#instVars : [
		'bucket'
	],
	#category : #S3RestLambda
}

{ #category : #accessing }
S3RestLambda >> bucketName [
	^ OSEnvironment current at: 'BUCKET_NAME'
]

{ #category : #accessing }
S3RestLambda >> initLambda [
	super initLambda.
	AWSS3Config default
		accessKeyId: self s3AccessKeyId;
		secretKey: self s3secreteKey;
		sessionToken: self sessionToken;
		regionName: self region.
	self initializeBucket: self bucketName.
]

{ #category : #accessing }
S3RestLambda >> initializeBucket: bucketName [
	| s3 |
	s3 := AWSS3 new.
	bucket := s3 bucketNamed: bucketName
]

{ #category : #accessing }
S3RestLambda >> region [
	^ OSEnvironment current at: 'AWS_REGION'
]

{ #category : #accessing }
S3RestLambda >> s3AccessKeyId [
	^ OSEnvironment current at: 'AWS_ACCESS_KEY_ID'
]

{ #category : #accessing }
S3RestLambda >> s3secreteKey [
	^ OSEnvironment current at: 'AWS_SECRET_ACCESS_KEY'
]

{ #category : #accessing }
S3RestLambda >> sessionToken [
	^ OSEnvironment current at: 'AWS_SESSION_TOKEN'
]
