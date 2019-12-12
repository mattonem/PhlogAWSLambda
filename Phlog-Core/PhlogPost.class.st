Class {
	#name : #PhlogPost,
	#superclass : #Object,
	#instVars : [
		'id',
		'content',
		'collection',
		'order'
	],
	#category : #'Phlog-Core'
}

{ #category : #'as yet unclassified' }
PhlogPost class >> collection: aCollection content: aString [ 
	^ self new
		collection: aCollection;
		content: aString;
		yourself
]

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
PhlogPost >> collection [
	^ collection
]

{ #category : #'as yet unclassified' }
PhlogPost >> collection: aCollection [
	collection := aCollection
]

{ #category : #'as yet unclassified' }
PhlogPost >> content [ 
	^ content
]

{ #category : #'as yet unclassified' }
PhlogPost >> content: aString [ 
	content := aString
]

{ #category : #'as yet unclassified' }
PhlogPost >> id [ 
	^ id
]

{ #category : #'as yet unclassified' }
PhlogPost >> initialize [
	id := UUID new asString.
	order := 1.
]

{ #category : #'as yet unclassified' }
PhlogPost >> order [ 
	^ order
]

{ #category : #'as yet unclassified' }
PhlogPost >> order: anInterger [ 
	order := anInterger 
]
