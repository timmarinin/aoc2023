const fs = require('fs')
const solve = (t) => {
	return t
		.split('\n')
		.map((l) => {
			const r = l
				.split('')
				.map((c) => parseInt(c, 10))
				.filter((x) => !Number.isNaN(x))
			let [first, last] = [r.shift(), r.pop()]
			if (first === undefined) {
				first = ''
			}
			if (last === undefined) {
				last = first
			}
			
			return ('' + first) + ('' + last)
		})
		.reduce((a, b) => parseInt(a)+ parseInt(b), 0)
}

const t = fs.readFileSync('input_1a.txt', 'utf-8')
console.log(solve(t.trim()))
