Class {
	#name : #PMdParagraph,
	#superclass : #PMdElement,
	#instVars : [
		'content'
	],
	#category : #MDownToHTMLLambda
}

{ #category : #'as yet unclassified' }
PMdParagraph >> accept: aPhlogTextRenderer with: aWAHtmlCanvas [ 
	aPhlogTextRenderer visitParagraph: self with: aWAHtmlCanvas
]

{ #category : #'as yet unclassified' }
PMdParagraph >> contentsDo: aBlockClosure [ 
	content do: aBlockClosure
]

{ #category : #'as yet unclassified' }
PMdParagraph >> first [
	^ content first
]

{ #category : #'as yet unclassified' }
PMdParagraph >> from: node [
	content := node
]

{ #category : #'as yet unclassified' }
PMdParagraph >> second [
	^ content second
]
