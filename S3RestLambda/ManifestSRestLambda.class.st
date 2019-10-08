"
Lambda cleanBuilds.
[ |dir|
dir := Lambda buildRepo: 'github://mattonem/MDownToHTMLLambda' baseline: 'BaselineOfS3RestLambda' group: 'post' lambdaClass: 'S3RestLambdaPost' .
Lambda deployFunction: 'S3RestLambdaPost' fromDirectory: dir] fork.
[|dir|
	dir := Lambda buildRepo: 'github://mattonem/MDownToHTMLLambda' baseline: 'BaselineOfS3RestLambda' group: 'put' lambdaClass: 'S3RestLambdaPut' .
Lambda deployFunction: 'S3RestLambdaPut' fromDirectory: dir] fork
"
Class {
	#name : #ManifestSRestLambda,
	#superclass : #PackageManifest,
	#category : #'S3RestLambda-Manifest'
}
