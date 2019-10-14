Class {
	#name : #MDownToHTMLLambda,
	#superclass : #LambdaCommandLineHandler,
	#category : #MDownToHTMLLambda
}

{ #category : #accessing }
MDownToHTMLLambda >> lambdaAction: request [
	| json parsed result target path payload |
	json := NeoJSONReader fromString: request contents.
	target := (json at: #jsonPath ifAbsent: '.payload').
	path := target substrings: '.'.
	payload := json.
	path do: [ :aLevel | payload := payload at: aLevel ].
	parsed := PPMarkdown parse: payload.
	result := json.
	path allButLastDo: [ :aLevel | result := result at: aLevel ].
	result at: path last put: (MDHtmlWriter on: parsed) .
	^ NeoJSONWriter toString: json.
]
