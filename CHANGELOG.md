0.1.9 / 2018-07-17
------------------
- Modified `common_params` when create `@rest_url`. Currently we can't use method `to_query` for parsing `common_params` hash to query string.
  
  #### Note:
  Regarding to Lazada Open Platform Official gems `lazop-api-client` version **1.2.5** `common_params` did not sort.
  
  So If `common_params` sorted, `signature` can be **IncompleteSignature**.

  Example response from APIs when `signature` generated from sorted `common_params` 
  ```json
  {
    "type":"ISV",
    "code":"IncompleteSignature",
    "message":"The request signature does not conform to lazada standards",
    "request_id":"request_id"
  }
  ```
