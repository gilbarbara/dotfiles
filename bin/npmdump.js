#!/usr/bin/env node

const { spawn } = require('child_process');
const { writeFileSync } = require('fs');

const dump = spawn('npm', ['ls', '-g', '--depth=0', '--json']);

dump.stdout.on('data', (data) => {
	const packages = JSON.parse(data);

	const entries = Object.entries(packages.dependencies)
		.filter(([key, value]) => key !== 'npm' && !value.resolved)
		.map(([key]) => key);

	writeFileSync('NPMfile', entries.join('\n'), 'utf-8')
});

dump.stderr.on('data', (data) => {
	console.error(data);
});

dump.on('close', (code) => {
	process.exit(code);
});
