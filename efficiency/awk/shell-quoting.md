# shell中的引号问题

```sh
$ awk 'BEGIN { print "Here is a single quote '"'"'" }'
Here is a single quote '

$ awk 'BEGIN { print "Here is a single quote '\''" }'
Here is a single quote '

$ awk "BEGIN { print \"Here is a single quote '\" }"
Here is a single quote '

$ awk 'BEGIN { print "Here is a single quote \47" }'
Here is a single quote '

$ awk 'BEGIN { print "Here is a double quote \42" }'
Here is a double quote "

$ awk -v sq="'" 'BEGIN { print "Here is a single quote " sq "" }'
Here is a single quote '
```
