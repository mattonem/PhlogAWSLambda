Class {
	#name : #MDownToHTMLLambda,
	#superclass : #Lambda,
	#category : #MDownToHTMLLambda
}

{ #category : #accessing }
MDownToHTMLLambda class >> action: request [
	| json parsed |
	json := NeoJSONReader fromString: request contents.
	parsed := PPMarkdown parse: (json at: #payload ).
	^ '["parsedOK"]'
]
