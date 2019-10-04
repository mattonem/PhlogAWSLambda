Class {
	#name : #PPMarkdown,
	#superclass : #PPCompositeParser,
	#instVars : [
		'document',
		'paragraph',
		'title',
		'image',
		'url',
		'altText',
		'em',
		'text',
		'textGroup',
		'strong',
		'anchor',
		'carousel'
	],
	#category : #MDownToHTMLLambda
}

{ #category : #grammar }
PPMarkdown >> altText [
	^ (#newline asParser / $] asParser) negate star flatten ==> [ :node | PMdString from: node ]
]

{ #category : #grammar }
PPMarkdown >> anchor [
	^ $[ asParser, altText  , '](' asParser, url  ,$) asParser ==> [ :node | 
		PMdAnchor from: node ]
]

{ #category : #grammar }
PPMarkdown >> carousel [
	^ ('![' asParser , altText , ']' asParser ,(('(' asParser , url , ')' asParser) min: 2)
		, #newline asParser negate not) ==> [ :node | PMdCarousel from: node ]
]

{ #category : #grammar }
PPMarkdown >> document [
	^  ((image/carousel/textGroup) separatedBy: #newline asParser plus) withoutSeparators ==> [ :node | PMdDocument from: node ]
]

{ #category : #grammar }
PPMarkdown >> em [
^ $_ asParser , (#newline asParser/ $_ asParser) negate star, $_ asParser ==> [:node | PMdEm from: node]
]

{ #category : #grammar }
PPMarkdown >> image [
	^ ('![' asParser , altText , '](' asParser , url , ')' asParser
		, #newline asParser negate not) ==> [ :node | PMdImage from: node ]
]

{ #category : #grammar }
PPMarkdown >> paragraph [
	^ (anchor/strong/em/text) star ==> [ :node | PMdParagraph from: node ]
]

{ #category : #accessing }
PPMarkdown >> start [
	^ document end
]

{ #category : #grammar }
PPMarkdown >> strong [
	^ '__' asParser , (#newline asParser/ '__' asParser) negate star flatten, '__' asParser ==> [:node | PMdStrong from: node]
]

{ #category : #grammar }
PPMarkdown >> text [ 
	^ ((anchor/ strong / em ) not, #newline asParser negate) plus ==> [ :node | PMdString from: (node collect: #second) ]
]

{ #category : #grammar }
PPMarkdown >> textGroup [
	^ 
		(((image/carousel) not, ( title/paragraph) separatedBy: (#newline asParser plus)) ) withoutSeparators ==> [ :node | PMdTextGroup from: ( node collect: #second )  ]
]

{ #category : #grammar }
PPMarkdown >> title [
	^ $# asParser, text  ==> [ :node | PMdTitle from: node ]
]

{ #category : #grammar }
PPMarkdown >> url [
	^ (#space asParser / $) asParser) negate star flatten ==> [ :node | PMdString from: node ]
]
