#!/usr/bin/env node

const { execSync, spawn } = require('child_process');
const { writeFileSync } = require('fs');

(() => {
  try {
    const list = execSync('pnpm ls -g --depth=0 --json').toString();

    const [result] = JSON.parse(list);

    const packages = Object.keys(result.dependencies)

	  writeFileSync('NPMfile', packages.join('\n'), 'utf-8')

    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
})();

// const dump = spawn('pnpm', ['ls', '-g', '--depth=0', '--json']);
//
// dump.stdout.on('data', (data) => {
//   // console.log(data.toString());
//   return;
// 	const packages = JSON.parse(data)[0];
//
// 	const entries = Object.entries(packages.dependencies)
// 		.filter(([key, value]) => key !== 'npm' && !value.resolved)
// 		.map(([key]) => key);
//
// 	writeFileSync('NPMfile', entries.join('\n'), 'utf-8')
// });
//
// dump.stderr.on('data', (data) => {
// 	console.error(data);
// });
//
// dump.on('close', (code) => {
// 	process.exit(code);
// });
