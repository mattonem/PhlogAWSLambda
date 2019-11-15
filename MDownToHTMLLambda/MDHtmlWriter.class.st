Class {
	#name : #MDHtmlWriter,
	#superclass : #Object,
	#category : #MDownToHTMLLambda
}

{ #category : #'as yet unclassified' }
MDHtmlWriter class >> on: aPMdDocument [ 
	^ self new runOn: aPMdDocument
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> runOn: aPMdDocument [
	| s |
	s := WriteStream on: (String new: 200).
	aPMdDocument accept: self with: s.
	^ s contents
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitAnchor: aPMdAnchor with: aWriteStream [ 
	aWriteStream << '<a href="'.
	aPMdAnchor url accept: self with: aWriteStream.
	aWriteStream << '">'.
	aPMdAnchor altText accept: self with: aWriteStream.
	aWriteStream << '</a>'.
	
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitDocument: aPMdDocument with: aStream [
	aPMdDocument contentsDo: [ :c | c accept: self with: aStream ]
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitEm: aPMdEm with: aWriteStream [
	aWriteStream
		<< '<em>';
		<< aPMdEm string;
		<< '</em>'
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitImage: aPMdImage with: aWriteStream [ 
	aWriteStream << '<img src="'.
	aPMdImage url accept: self with: aWriteStream.
	aWriteStream << '" alt="'.
	aPMdImage altText accept: self with: aWriteStream.
	aWriteStream << '">'.
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitParagraph: aPMdParagraph with: aWriteStream [ 
	aWriteStream << '<p>'.
	aPMdParagraph contentsDo: [ :c | c accept: self with: aWriteStream ].
	aWriteStream << '</p>'.
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitString: aPMdString with: aWriteStream [
	aWriteStream << aPMdString string
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitStrong: aPMdStrong with: aWriteStream [ 
	aWriteStream << '<strong>';
	<< aPMdStrong string;
	<< '</strong>'
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitTextGroup: aPMdTextGroup with: aWriteStream [ 
	aPMdTextGroup contentsDo: [ :c | c accept:self with: aWriteStream  ]
]

{ #category : #'as yet unclassified' }
MDHtmlWriter >> visitTitle: aPMdTitle with: aWriteStream [
	aWriteStream << '<h1>'.
	aPMdTitle string accept: self with: aWriteStream.
	aWriteStream << '</h1>'
]
