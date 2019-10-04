Class {
	#name : #PMdTextGroup,
	#superclass : #PMdElement,
	#instVars : [
		'content'
	],
	#category : #MDownToHTMLLambda
}

{ #category : #'as yet unclassified' }
PMdTextGroup >> accept: aPhlogTextRenderer with: aWAHtmlCanvas [ 
	aPhlogTextRenderer visitTextGroup: self with: aWAHtmlCanvas
]

{ #category : #'as yet unclassified' }
PMdTextGroup >> contentsDo: aBlockClosure [ 
	content do: aBlockClosure
]

{ #category : #'as yet unclassified' }
PMdTextGroup >> first [
	^ content first
]

{ #category : #'as yet unclassified' }
PMdTextGroup >> from: aCollection [ 

	content := aCollection
]
