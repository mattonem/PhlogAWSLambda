Class {
	#name : #Phlog,
	#superclass : #Object,
	#instVars : [
		'collections'
	],
	#category : #'Phlog-Core'
}

{ #category : #accessing }
Phlog class >> neoJsonMapping: mapper [
	mapper
		for: #DictionaryOfPhlogCollections
		customDo:
			[ :mapping | mapping  mapWithValueSchema: PhlogCollection ].
	mapper
		for: self
		do:
			[ :mapping | (mapping mapInstVar: #collections) valueSchema: #DictionaryOfPhlogCollections ]
]

{ #category : #'as yet unclassified' }
Phlog >> collection: aString [
	^ collections at: aString ifAbsentPut: [ PhlogCollection new ]
]

{ #category : #initialization }
Phlog >> initialize [ 
	collections := Dictionary new.
	
]
