Class {
	#name : #S3RestLambdaPost,
	#superclass : #Lambda,
	#classInstVars : [
		'bucket'
	],
	#category : #S3RestLambdaPost
}

{ #category : #accessing }
S3RestLambdaPost class >> bucketName [
	^ OSEnvironment current at: 'BUCKET_NAME'
]

{ #category : #accessing }
S3RestLambdaPost class >> initLambda [
	| s3 |
	Stdio stderr << 'S3 >> initLambda'; lf.
	super initLambda.
	Stdio stderr << 'S3 >> initLambda super ok'; lf.
	Stdio stderr << 'S3AccessKeyId: ' << self s3AccessKeyId ; lf.
	Stdio stderr << 'S3secreteKey: ' << self s3secreteKey ; lf.
	Stdio stderr << 'bucketNamed: ' << self bucketName ; lf.
	Stdio stderr << 'regionName: ' << self region ; lf.
	AWSS3Config default
		accessKeyId: self s3AccessKeyId;
		secretKey: self s3secreteKey;
		regionName: self region.
	Stdio stderr << 'S3 >> initLambda aws ok'; lf.
	s3 := AWSS3 new.
	Stdio stderr << 'S3 >> initLambda s3 ok'; lf.
	bucket := s3 bucketNamed: self bucketName.
	Stdio stderr << 'S3 >> initLambda bucket ok'; lf.

]

{ #category : #accessing }
S3RestLambdaPost class >> lambdaAction: aRequest [
	Stdio stderr << 'action' ; lf.
	bucket
		atKey: UUID new asString
		putObject: aRequest contents.
	^ aRequest contents
]

{ #category : #accessing }
S3RestLambdaPost class >> region [
	^ OSEnvironment current at: 'AWS_REGION'
]

{ #category : #accessing }
S3RestLambdaPost class >> s3AccessKeyId [
	^ OSEnvironment current at: 'AWS_ACCESS_KEY_ID'
]

{ #category : #accessing }
S3RestLambdaPost class >> s3secreteKey [
	^ OSEnvironment current at: 'AWS_SECRET_ACCESS_KEY'
]
