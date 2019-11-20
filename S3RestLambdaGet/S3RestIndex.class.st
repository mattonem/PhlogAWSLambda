Class {
	#name : #S3RestIndex,
	#superclass : #Object,
	#instVars : [
		'bucket',
		'collection',
		'accessor',
		'dictionary',
		'lastUpdate'
	],
	#category : #S3RestLambdaGet
}

{ #category : #'instance creation' }
S3RestIndex class >> in: aBucket for: aString value: aString3 [ 
	^ self new bucket: aBucket;
		collection: aString;
		accessor: aString3; 
		yourself.
]

{ #category : #accessing }
S3RestIndex >> accessor: aString [ 
	accessor := aString
]

{ #category : #accessing }
S3RestIndex >> at: anId [
	self validate.
	^ dictionary at: anId asString
]

{ #category : #accessing }
S3RestIndex >> at: anId ifPresent: aBlockClosure ifAbsent: aBlockClosure3 [
	self validate.
	^ dictionary
		at: anId asString
		ifPresent: aBlockClosure
		ifAbsent: aBlockClosure3
]

{ #category : #accessing }
S3RestIndex >> bucket: aBucket [
	bucket := aBucket
]

{ #category : #accessing }
S3RestIndex >> collection: aString [ 
	collection := aString
]

{ #category : #accessing }
S3RestIndex >> getMetadata [
	^ (NeoJSONReader
		on: (bucket getObject: collection , '/_metadata') readStream)
		for: #Metadata
			do: [ :mapping | 
			mapping subjectClass: NeoJSONObject.
			(mapping mapAccessor: #lastUpdate) valueSchema: DateAndTime.
			mapping mapAccessor: #root ];
		nextAs: #Metadata
]

{ #category : #processing }
S3RestIndex >> indexIdFor: payload iteration: ite [
	^ payload at: accessor
]

{ #category : #accessing }
S3RestIndex >> initialize [ 
	dictionary := OrderedDictionary new.
]

{ #category : #accessing }
S3RestIndex >> last [
	self validate.
	^ dictionary values
		ifEmpty: [ nil ]
		ifNotEmpty: [ :values | values last ]
]

{ #category : #processing }
S3RestIndex >> updateDictionaryRoot: rootId [
	| id payload ite |
	lastUpdate := DateAndTime now.
	id := rootId.
	dictionary := OrderedDictionary new.
	ite := 1.
	[ id isNotNil ]
		whileTrue: [ payload := NeoJSONReader fromString: (bucket getObject: id).
			dictionary at: (self indexIdFor: payload iteration: ite) put: payload.
			ite := ite + 1.
			id := payload at: #next ]
]

{ #category : #accessing }
S3RestIndex >> validate [
	| metadata |
	metadata := self getMetadata.
	lastUpdate
		ifNil: [ lastUpdate := DateAndTime now.
			self updateDictionaryRoot: (metadata at: #root) ].
	lastUpdate > (metadata at: #lastUpdate)
		ifFalse: [ self updateDictionaryRoot: (metadata at: #root) ]
]
