Class {
	#name : #BaselineOfS3RestLambda,
	#superclass : #BaselineOf,
	#category : #BaselineOfS3RestLambda
}

{ #category : #baselines }
BaselineOfS3RestLambda >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'AwsLambda'
				with: [ spec
						repository: 'github://mattonem/Pharo-AWSLambda';
						loads: #core ].
			spec
				baseline: 'NeoJSON'
				with: [ spec
						repository: 'github://svenvc/NeoJSON/repository';
						loads: #core ].
			spec
				baseline: 'AWS'
				with: [ spec
						repository: 'github://newapplesho/aws-sdk-smalltalk/pharo-repository';
						loads: #'AWS-S3' ].
			spec
				package: 'S3RestLambdaPost'
				with: [ spec requires: #('AwsLambda' NeoJSON) ].
			spec group: #post with: S3RestLambdaPost ]
]
