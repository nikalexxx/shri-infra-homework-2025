// scripts/update-changelog.js
const { execSync } = require('child_process');
const fs = require('fs');

const prevTag = process.env.PREV_TAG || '';
const version = process.env.VERSION || '';
const fix = process.env.FIX || '';
const outputFile = process.env.GITHUB_OUTPUT;

if (!prevTag || !version || !fix || !outputFile) {
    console.error('Missing required environment variables: PREV_TAG, VERSION, FIX, GITHUB_OUTPUT');
    process.exit(1);
}

const rawLog = execSync(`git log ${prevTag}..HEAD --pretty=format:"* %s (%h)"`, {
    encoding: 'utf-8',
});

const escapedLog = rawLog
    .replace(/%/g, '%25')
    .replace(/\r/g, '%0D')
    .replace(/\n/g, '%0A');

fs.appendFileSync(outputFile, `log=${escapedLog}\n`);
