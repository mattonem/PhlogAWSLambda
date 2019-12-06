Class {
	#name : #BaselineOfPhlogAWSLambda,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhlogAWSLambda
}

{ #category : #baselines }
BaselineOfPhlogAWSLambda >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'AwsLambda'
				with: [ spec
						repository: 'github://mattonem/Pharo-AWS-Lambda-Runtime';
						loads: #core ].
			spec
				baseline: 'AWS'
				with: [ spec
						repository: 'github://newapplesho/aws-sdk-smalltalk:AWS-Lambda/pharo-repository' ].
			spec
				project: 'AWS-S3'
				copyFrom: 'AWS'
				with: [ spec loads: #('AWS-S3') ].
			spec
				project: 'AWS-Lambda'
				copyFrom: 'AWS'
				with: [ spec loads: #('AWS-Lambda') ].
			spec package: 'Phlog-Core' with: [ spec requires: #('AWS-S3') ].
			spec package: 'Phlog-Core-Post' with: [ spec requires: #('Phlog-Core' 'AWS-S3') ]. ]
]
