Class {
	#name : #Phlog,
	#superclass : #Object,
	#instVars : [
		'files'
	],
	#category : #'Phlog-Core'
}

{ #category : #accessing }
Phlog class >> fromJson: aString [
	^ (NeoJSONReader on: aString readStream) nextAs: self
]

{ #category : #accessing }
Phlog class >> neoJsonMapping: mapper [
	mapper
		for: #ListOfPosts
		customDo:
			[ :mapping | mapping  listOfType: OrderedCollection andElementSchema: PhlogPost ].
	mapper
		for: self
		do:
			[ :mapping | (mapping mapInstVar: #files) valueSchema: #ListOfPosts ]
]

{ #category : #initialization }
Phlog >> add: aFile [
	^ files add: aFile
]

{ #category : #initialization }
Phlog >> initialize [ 
	files := OrderedCollection new.
	
]

{ #category : #initialization }
Phlog >> select: aBlock [
	^ files select: aBlock
]

{ #category : #initialization }
Phlog >> serialize [
	^ NeoJSONWriter toString: self
]
