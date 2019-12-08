Class {
	#name : #PhlogCollection,
	#superclass : #Object,
	#instVars : [
		'posts'
	],
	#category : #'Phlog-Core'
}

{ #category : #accessing }
PhlogCollection class >> neoJsonMapping: mapper [
	mapper
		for: #ListOfPhlogPost
		customDo:
			[ :mapping | mapping listOfType: OrderedCollection andElementSchema: PhlogPost ].
	mapper
		for: self
		do:
			[ :mapping | (mapping mapInstVar: #posts) valueSchema: #ListOfPhlogPost ]
]

{ #category : #initialization }
PhlogCollection >> initialize [ 
	posts := OrderedCollection new.
	
]

{ #category : #'as yet unclassified' }
PhlogCollection >> post: aString [ 
	^ posts addFirst: (PhlogPost content: aString)
]
