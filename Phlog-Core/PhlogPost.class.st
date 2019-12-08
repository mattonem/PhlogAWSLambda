Class {
	#name : #PhlogPost,
	#superclass : #Object,
	#instVars : [
		'id',
		'content'
	],
	#category : #'Phlog-Core'
}

{ #category : #'as yet unclassified' }
PhlogPost class >> content: aString [
	^ self new
		content: aString;
		yourself
]

{ #category : #'as yet unclassified' }
PhlogPost class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping | mapping mapAllInstVars ]
]

{ #category : #'as yet unclassified' }
PhlogPost >> content: aString [ 
	content := aString
]

{ #category : #'as yet unclassified' }
PhlogPost >> initialize [
	id := UUID new asString
]
