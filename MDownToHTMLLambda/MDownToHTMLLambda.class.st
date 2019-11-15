Class {
	#name : #MDownToHTMLLambda,
	#superclass : #LambdaCommandLineHandler,
	#category : #MDownToHTMLLambda
}

{ #category : #accessing }
MDownToHTMLLambda >> lambdaAction: request [
	| parsed |
	parsed := PPMarkdown parse: request.
	^ MDHtmlWriter on: parsed
]
