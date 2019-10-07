Class {
	#name : #S3RestLambdaPost,
	#superclass : #Lambda,
	#classInstVars : [
		'bucket'
	],
	#category : #S3RestLambdaPost
}

{ #category : #accessing }
S3RestLambdaPost class >> S3AccessKeyId [
	^ OSEnvironment current at: 'AWS_ACCESS_KEY_ID'
]

{ #category : #accessing }
S3RestLambdaPost class >> S3secreteKey [
	^ OSEnvironment current at: 'AWS_SECRET_ACCESS_KEY'
]

{ #category : #accessing }
S3RestLambdaPost class >> action: aRequest [
	bucket
		atKey: UUID new asString
		putObject: aRequest contents.
	^ aRequest contents
]

{ #category : #accessing }
S3RestLambdaPost class >> bucketName [
	^ OSEnvironment current at: 'BUCKET_NAME'
]

{ #category : #accessing }
S3RestLambdaPost class >> initLambda [
	| s3 |
	super initLambda.
	AWSS3Config default
		accessKeyId: self S3AccessKeyId;
		secretKey: self S3secreteKey;
		regionName: self region.
	s3 := AWSS3 new.
	bucket := s3 bucketNamed: self bucketName.
]

{ #category : #accessing }
S3RestLambdaPost class >> region [
	^ OSEnvironment current at: 'AWS_REGION'
]
