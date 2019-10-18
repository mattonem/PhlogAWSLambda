Class {
	#name : #S3RestLambdaList,
	#superclass : #S3RestLambda,
	#instVars : [
		'sortedList',
		'lambdaClient',
		'updateTables'
	],
	#category : #S3RestLambdaList
}

{ #category : #accessing }
S3RestLambdaList >> fetch: anId prefix: aPrefix [
	| xml lastMod |
	xml := bucket listObjectPrefix: anId.
	lastMod := (xml findElementNamed: 'LastModified') contentString
		asDateAndTime.
	(updateTables  at: aPrefix ifAbsentPut: self newUdpateTable)
		at: anId
		put: {(#lastModified -> lastMod)} asDictionary.
	self sortIndex: aPrefix.
]

{ #category : #'as yet unclassified' }
S3RestLambdaList >> index: aString at: anInteger [
	^ (sortedList at: aString at: anInteger) key
]

{ #category : #'as yet unclassified' }
S3RestLambdaList >> index: aString at: anInteger do: ablock [
	^ ablock value: ((sortedList at: aString at: anInteger  ifAbsent: [ ^ self ] ) key)
]

{ #category : #accessing }
S3RestLambdaList >> initLambda [
	super initLambda.
	AWSLambdaConfig default
		accessKeyId: self s3AccessKeyId;
		secretKey: self s3secreteKey;
		sessionToken: self sessionToken;
		regionName: self region.
	self lambdaClient: AWSLambda new.
]

{ #category : #accessing }
S3RestLambdaList >> initialize [
	super initialize.
	sortedList := Dictionary new.
	updateTables := Dictionary new.
]

{ #category : #accessing }
S3RestLambdaList >> lambdaAction: aRequest [
	| json offset limit prefix payload  |
	json := NeoJSONReader fromString: aRequest contents.
	offset := json at: #offset ifAbsent: 1.
	limit := json at: #limit ifAbsent: 10.
	prefix := json at: #prefix.
	self validateIndex: prefix.
	payload := json at: #payload put: OrderedCollection new.
	offset to: offset + limit do: [ :i | self index: prefix at: i do: [ :val | payload add: val ] ].
	^ NeoJSONWriter toString: json
]

{ #category : #accessing }
S3RestLambdaList >> lambdaClient: aClient [
	lambdaClient := aClient
]

{ #category : #accessing }
S3RestLambdaList >> newUdpateTable [
	^ Dictionary new.
]

{ #category : #accessing }
S3RestLambdaList >> sortIndex: prefix [
	sortedList
		at: prefix
		put:
			(((updateTables at: prefix) keys
				collect: [ :key | 
					key
						->
							(((NeoJSONReader
								fromString:
									(lambdaClient
										createInvokeRequest: 'S3RestLambdaGet'
										payload: '{"id":"' , key , '"}') contents) at: #payload)
								at: #order) ]) sorted: [ :v1 :v2 | v1 value < v2 value ])
]

{ #category : #accessing }
S3RestLambdaList >> validateIndex: aPrefix [
	| xml lastModified id |
	xml := bucket listObjectsPrefix: aPrefix.
	(xml allElementsNamed: 'Contents')
		do: [ :element | 
			lastModified := (element findElementNamed: 'LastModified')
				contentString asDateAndTime.
			id := (element findElementNamed: 'Key') contentString.
			(((updateTables at: aPrefix ifAbsentPut: self newUdpateTable)
				at: id
				ifAbsentPut: (self fetch: id prefix: aPrefix)) at: #lastModified)
				< lastModified
				ifTrue: [ self fetch: id prefix: aPrefix ] ]
]
