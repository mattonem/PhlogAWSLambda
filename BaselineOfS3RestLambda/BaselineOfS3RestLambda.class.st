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
						repository: 'github://mattonem/Pharo-AWS-Lambda-Runtime';
						loads: #core ].
			spec
				baseline: 'NeoJSON'
				with: [ spec
						repository: 'github://svenvc/NeoJSON/repository';
						loads: #core ].
			spec
				baseline: 'AWS'
				with: [ spec
						repository: 'github://mattonem/aws-sdk-smalltalk/pharo-repository:AWS-Lambda' ].
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
					with: [ spec requires: #('AwsLambda' 'AWS-S3' NeoJSON) ];
				package: 'S3RestLambdaPut'
					with: [ spec requires: #('S3RestLambda') ];
				package: 'S3RestLambdaGet'
					with: [ spec requires: #('S3RestLambda' 'AWS-Lambda') ];
				package: 'S3RestLambdaDelete'
					with: [ spec requires: #('S3RestLambda') ];
				package: 'S3RestLambdaPost'
					with: [ spec requires: #('S3RestLambda') ].
			spec
				group: #post with: 'S3RestLambdaPost';
				group: #delete with: 'S3RestLambdaDelete';
				group: #get with: 'S3RestLambdaGet';
				group: #put with: 'S3RestLambdaPut' ]
]
