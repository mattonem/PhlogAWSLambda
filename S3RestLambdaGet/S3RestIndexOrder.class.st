Class {
	#name : #S3RestIndexOrder,
	#superclass : #S3RestIndex,
	#category : #S3RestLambdaGet
}

{ #category : #processing }
S3RestIndexOrder >> indexIdFor: payload iteration: ite [
	^ ite
]
