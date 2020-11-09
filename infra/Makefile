.PHONY: seed
seed:
	aws dynamodb batch-write-item --request-items file://dynamodb_items/tags.json
	aws dynamodb batch-write-item --request-items file://dynamodb_items/memos.json
	aws dynamodb batch-write-item --request-items file://dynamodb_items/images.json
	aws dynamodb batch-write-item --request-items file://dynamodb_items/images_2.json
