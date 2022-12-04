# sequence
这是我自己用来生成序列的一个存储过程

# 参数
`as_seqname` 序列的名称, 我会用nameof(MODEL) 来确定是哪个表来生成这个序列

`as_prefix` 前缀, 可以给序列增加一个前缀比如SKU100007

`as_seqcount` 序列的跨度, 比如第一个序列是10001 如果设置为7 那么下一个序列是10008

`as_seqlen` 序列的长度, 中间会用0来补位, 比如17 长度为2, 1000007 长度为7

`is_date` 在序列的前面增加日期组成的数字格式为`YYYYMMDDHHmmss`

`result` 返回值 字符串类型.
