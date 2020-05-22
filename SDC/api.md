## Server API

### Get product reviews
  * GET `/api/product/{product_id}/review?limit={limit}&offset={offset}&sort={sort}`

**Parameters:**
  * `product_id` product id
  * `limit` limit
  * `offset` offset
  * `sort` sort

**Success Status Code:** `200`

**Returns:** Array

```Array
    [
      {
        "review_id": "Number",
        "title": "String",
        "text": "String",
        "recommends": "Boolean",
        "rating_overall": "Number",
        "rating_size": "Number",
        "rating_width": "Number",
        "rating_comfort": "Number",
        "rating_quality": "Number",
        "is_helpful": "Number",
        "is_not_helpful": "Number",
        "nickname": "String",
        "verified": "Boolean",
        "photos": "Array["String"]"
        "created_At": "datetime",
      }
      ...
    ]
```

### Create product review
  * POST `/api/product/{product_id}/review`

**Parameters:**
  * `product_id` product id

**Request Body:**
```JSON
    {
      "title": "String",
      "text": "String",
      "recommends": "Boolean",
      "rating_overall": "Number",
      "rating_size": "Number",
      "rating_width": "Number",
      "rating_comfort": "Number",
      "rating_quality": "Number",
      "is_helpful": "Number",
      "is_not_helpful": "Number",
      "nickname": "String",
      "verified": "Boolean",
      "photos": "Array["String"]"
      "created_At": "datetime",
    }
```

**Success Status Code:** `201`

### Update product review
  * PUT `/api/product/{product_id}/review/{review_id}`

**Parameters:**
  * `product_id` product id
  * `review_id` review id

**Request Body:**
```JSON
    {
      "title": "String",
      "text": "String",
      "recommends": "Boolean",
      "rating_overall": "Number",
      "rating_size": "Number",
      "rating_width": "Number",
      "rating_comfort": "Number",
      "rating_quality": "Number",
      "is_helpful": "Number",
      "is_not_helpful": "Number",
      "nickname": "String",
      "verified": "Boolean",
      "photos": "Array["String"]"
      "created_At": "datetime",
    }
```

**Success Status Code:** `201`

### Delete product review
  * DELETE `/api/product/{product_id}/review/{review_id}`

**Parameters:**
  * `product_id` product id
  * `review_id` review id

**Success Status Code:** `204`

### Get user
  * GET `/api/user/{user_id}`

**Parameters:**
  * `user_id` user id

**Success Status Code:** `200`

**Returns:** JSON

```Array
    [
      {
        "id": "Number",
        "nickname": "String",
        "email": "String"
      }
      ...
    ]
```

### Create user
  * POST `/api/user`

**Request Body:**
```JSON
    {
      "nickname": "String",
      "email": "String"
    }
```

**Success Status Code:** `201`

### Update user
  * PUT `/api/user/{user_id}`

**Parameters:**
  * `user_id` user id

**Request Body:**
```JSON
    {
      "nickname": "String",
      "email": "String"
    }
```

**Success Status Code:** `201`

### Delete user
  * DELETE `/api/user/{user_id}`

**Parameters:**
  * `user_id` user id

**Success Status Code:** `204`