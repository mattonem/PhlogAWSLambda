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
	Stdio stderr << 'action' ; lf.
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
	Stdio stderr << 'S3AccessKeyId: ' << self S3AccessKeyId ; lf.
	Stdio stderr << 'S3secreteKey: ' << self S3secreteKey ; lf.
	Stdio stderr << 'bucketNamed: ' << self bucketName ; lf.
]

{ #category : #accessing }
S3RestLambdaPost class >> region [
	^ OSEnvironment current at: 'AWS_REGION'
]
