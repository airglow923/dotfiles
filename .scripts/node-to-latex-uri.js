const latex = process.argv[2];

if (latex === undefined || typeof latex !== 'string') {
  const errMsg = 'Invalid argument';
  process.stderr.write(errMsg);
  process.exit(1);
}

const encodedLatex = encodeURI(latex);

process.stdout.write(encodedLatex + '\n');
