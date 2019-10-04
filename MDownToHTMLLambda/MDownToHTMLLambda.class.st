Class {
	#name : #MDownToHTMLLambda,
	#superclass : #Lambda,
	#category : #MDownToHTMLLambda
}

{ #category : #accessing }
MDownToHTMLLambda class >> action: request [
	^request contents
]
