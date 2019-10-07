Class {
	#name : #S3RestLambda,
	#superclass : #Lambda,
	#category : #S3RestLambda
}

{ #category : #accessing }
S3RestLambda class >> action: request [
	| json parsed result |
	json := NeoJSONReader fromString: request contents.
	^ json asString.
]

{ #category : #accessing }
S3RestLambda class >> initLambda [ 
	
]
