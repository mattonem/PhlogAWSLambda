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
				package: 'S3RestLambda'
					with: [ spec requires: #('AwsLambda' AWS NeoJSON) ];
				package: 'S3RestLambdaPut'
					with: [ spec requires: #('S3RestLambda') ];
				package: 'S3RestLambdaDelete'
					with: [ spec requires: #('S3RestLambda') ];
				package: 'S3RestLambdaPost'
					with: [ spec requires: #('S3RestLambda') ].
			spec
				group: #post with: 'S3RestLambdaPost';
				group: #delete with: 'S3RestLambdaDelete';
				group: #put with: 'S3RestLambdaPut' ]
]
