Class {
	#name : #MDownToHTMLLambda,
	#superclass : #LambdaCommandLineHandler,
	#category : #MDownToHTMLLambda
}

{ #category : #accessing }
MDownToHTMLLambda >> lambdaAction: request [
	| parsed |
	parsed := PPMarkdown parse: request.
	^ NeoJSONWriter toString: (MDHtmlWriter on: parsed)
]
