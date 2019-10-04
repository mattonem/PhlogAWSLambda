Class {
	#name : #MDownToHTMLLambda,
	#superclass : #Lambda,
	#category : #MDownToHTMLLambda
}

{ #category : #accessing }
MDownToHTMLLambda class >> action: request [
	| json parsed result |
	json := NeoJSONReader fromString: request contents.
	parsed := PPMarkdown parse: (json at: #payload ).
	result := NeoJSONObject new.
	result at: #result put: (MDHtmlWriter on: parsed) .
	^ result asString.
]
