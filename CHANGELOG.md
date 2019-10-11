0.3.5 / 2019-10-11
---
- Rework perform method in `StockShaker::Client::LazadaOP`

0.3.4 / 2019-09-30
---
- Create new `StockShaker::Concern::Utility`
- Rework Utility -> DateUtil
- Rework `client/lazada_op`
- Remove `active_support` from dependencies

0.3.3 / 2018-10-8
---
- assign `business_params`
```ruby
# lib/stock_shaker/request/jd_central_op.rb
# JDCentralOP#add_business_params line 24 - 26
 
@business_params = {
  param_json: hash.to_json
}
```

0.3.2 / 2018-10-4
---
- Added JD Central (TH) Integration

0.3.1 / 2018-08-14
---
- Return ::Client::ShopeeOP.perform as Object type not a JSON

0.3.0 / 2018-08-03
---
- Merge conflict


0.2.9 / 2018-08-3
---
- Added `rescue StandardError` for `ShopeeOP::Client.perform`

0.2.8 / 2018-07-26
---
- Update gemspec

0.2.7 / 2018-07-26
---
- Refactoring and publish beta version.
