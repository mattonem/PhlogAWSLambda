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
S3RestIndex >> getCollectionLastUpdate [
	^ ((NeoJSONReader
		on: (bucket getObject: collection , '/_metadata') readStream)
		for: #Metadata
			do: [ :mapping | 
			mapping subjectClass: NeoJSONObject.
			(mapping mapAccessor: #lastUpdate) valueSchema: DateAndTime ];
		nextAs: #Metadata) at: #lastUpdate
]

{ #category : #accessing }
S3RestIndex >> initialize [ 
	dictionary := OrderedDictionary new.
]

{ #category : #processing }
S3RestIndex >> updateDictionary [
	| ids |
	lastUpdate := DateAndTime now.
	ids := ((bucket listObjectPrefix: collection) allElementsNamed: #Key)
		collect: #contentString.
	ids remove: collection, '/_metadata'.
	dictionary := OrderedDictionary new.
	ids
		do: [ :anId | 
			| payload |
			payload := NeoJSONReader fromString: (bucket getObject: anId).
			dictionary at: (payload at: accessor) put: payload ]
]

{ #category : #accessing }
S3RestIndex >> validate [
	lastUpdate
		ifNil: [ lastUpdate := DateAndTime now.
			self updateDictionary ].
	lastUpdate > self getCollectionLastUpdate
		ifFalse: [ self updateDictionary ]
]
