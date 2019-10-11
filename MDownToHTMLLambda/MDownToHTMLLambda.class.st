Class {
	#name : #MDownToHTMLLambda,
	#superclass : #LambdaCommandLineHandler,
	#category : #MDownToHTMLLambda
}

{ #category : #accessing }
MDownToHTMLLambda >> lambdaAction: request [
	| json parsed result |
	json := NeoJSONReader fromString: request contents.
	parsed := PPMarkdown parse: (json at: #payload ).
	result := NeoJSONObject new.
	result at: #payload put: (MDHtmlWriter on: parsed) .
	^ result asString.
]
