resource "aws_dynamodb_table" "images" {
  name             = "images"
  read_capacity    = 1
  write_capacity   = 1
  hash_key         = "id"
  range_key        = "target_type"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "target_type"
    type = "S"
  }
}

resource "aws_lambda_event_source_mapping" "images" {
  event_source_arn  = aws_dynamodb_table.images.stream_arn
  function_name     = module.images_index.function_arn
  starting_position = "LATEST"
}

resource "aws_dynamodb_table" "memos" {
  name             = "memos"
  read_capacity    = 1
  write_capacity   = 1
  hash_key         = "id"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"


  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_lambda_event_source_mapping" "memos" {
  event_source_arn  = aws_dynamodb_table.memos.stream_arn
  function_name     = module.memos_index.function_arn
  starting_position = "LATEST"
}

resource "aws_dynamodb_table" "tags" {
  name             = "tags"
  read_capacity    = 1
  write_capacity   = 1
  hash_key         = "id"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_lambda_event_source_mapping" "tags" {
  event_source_arn  = aws_dynamodb_table.tags.stream_arn
  function_name     = module.tags_index.function_arn
  starting_position = "LATEST"
}


/*
resource "aws_dynamodb_table_item" "tags" {
  table_name = aws_dynamodb_table.tags.name
  hash_key   = aws_dynamodb_table.tags.hash_key

  item = <<ITEM
{
  "id": {"N":"1"},
  "name": {"S":"日常"},
  "color": {"S":"#ff7893"}
}
ITEM
}
*/
