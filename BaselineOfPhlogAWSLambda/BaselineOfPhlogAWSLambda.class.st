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
				baseline: 'TaskIt'
				with: [ spec repository: 'github://sbragagnolo/taskit' ].
			spec
				baseline: 'AwsLambda'
				with: [ spec
						repository: 'github://mattonem/Pharo-AWS-Lambda-Runtime';
						loads: #core ].
			spec
				baseline: 'AWS'
				with: [ spec repository: 'github://newapplesho/aws-sdk-smalltalk' ].
			spec
				project: 'AWS-S3'
				copyFrom: 'AWS'
				with: [ spec loads: #('AWS-S3') ].
			spec
				project: 'AWS-Lambda'
				copyFrom: 'AWS'
				with: [ spec loads: #('AWS-Lambda') ].
			spec
				package: 'S3RestLambda'
					with: [ spec requires: #('AwsLambda' 'AWS-S3') ];
				package: 'Phlog-Core' with: [ spec requires: #('AWS-S3') ];
				package: 'Phlog-Lambda-Post'
					with: [ spec requires: #('Phlog-Core' 'S3RestLambda') ];
				package: 'Phlog-Lambda-Get'
					with: [ spec requires: #('Phlog-Core' 'S3RestLambda' 'TaskIt' 'AWS-Lambda') ].
			spec
				group: #post with: 'Phlog-Lambda-Post';
				group: #get with: 'Phlog-Lambda-Get' ]
]
