alias hist='fc -lED 1'
alias hg='hist | grep -i'
alias opt='set -o | sort'
alias og='opt | grep -i'

# directory stack
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"
unset index
