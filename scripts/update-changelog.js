// scripts/update-changelog.js
const { execSync } = require('child_process');
const fs = require('fs');

const VERSION = process.env.VERSION;
const DATE = process.env.DATE;

if (!VERSION || !DATE) {
    console.error('VERSION и DATE должны быть переданы через переменные окружения');
    process.exit(1);
}

// Получаем предыдущий тег (если есть)
let previousTag = '';
try {
    previousTag = execSync('git describe --tags --abbrev=0').toString().trim();
} catch (_) {
    previousTag = '';
}

// Получаем список коммитов
let log = '';
try {
    const range = previousTag ? `${previousTag}..HEAD` : '';
    log = execSync(`git log ${range} --pretty=format:"* %s (%h)"`).toString().trim();
} catch (e) {
    console.error('Ошибка при получении логов коммитов:', e.message);
    process.exit(1);
}

// Формируем новый changelog
const changelogPath = 'CHANGELOG.md';
const currentContent = fs.existsSync(changelogPath) ? fs.readFileSync(changelogPath, 'utf-8') : '';
const newEntry = `## ${VERSION} - ${DATE}\n\n${log}\n\n`;
fs.writeFileSync(changelogPath, newEntry + currentContent);

// Git-команды
try {
    execSync('git config user.name "github-actions"');
    execSync('git config user.email "github-actions@github.com"');
    execSync('git add CHANGELOG.md');
    execSync(`git commit -m "chore(release): update changelog for ${VERSION}"`);
    execSync(`git push --set-upstream origin releases/${VERSION}`);
} catch (e) {
    console.error('Ошибка при git push:', e.message);
    process.exit(1);
}
