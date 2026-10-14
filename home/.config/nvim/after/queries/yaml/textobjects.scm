; extends
; @key / @value / @entry captures for the ak/ik, av/iv, ae/ie mappings in init.lua

(block_mapping_pair
  key: (_) @key.outer
  value: (_)? @value.outer) @entry.outer

(flow_pair
  key: (_) @key.outer
  value: (_)? @value.outer) @entry.outer
