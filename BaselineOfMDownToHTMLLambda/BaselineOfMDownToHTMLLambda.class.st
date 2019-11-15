Class {
	#name : #BaselineOfMDownToHTMLLambda,
	#superclass : #BaselineOf,
	#category : #BaselineOfMDownToHTMLLambda
}

{ #category : #baselines }
BaselineOfMDownToHTMLLambda >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'AwsLambda'
				with: [ spec
						repository: 'github://mattonem/Pharo-AWS-Lambda-Runtime';
						loads: #core ].
			
			spec
				baseline: 'PetitParser'
				with: [ spec
						repository: 'github://moosetechnology/PetitParser/src';
						loads: #Core ].
			spec
				package: 'MDownToHTMLLambda'
				with: [ spec requires: #('AwsLambda' PetitParser) ] ]
]
