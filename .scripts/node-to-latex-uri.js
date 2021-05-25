const latex = process.argv[2];
const latexRenderer = 'https://latex.codecogs.com/svg.latex?';

if (latex === undefined || typeof latex !== 'string') {
  const errMsg = 'Invalid argument';
  process.stderr.write(errMsg);
  process.exit(1);
}

function asciiToUTF(str) {
  str = str.replace(/\(/g, '%28');
  str = str.replace(/\)/g, '%29');

  return str;
}

const encodedLatex = encodeURI(latex);
const normalizedLatex = asciiToUTF(encodedLatex);

writeStdStream(latexRenderer + normalizedLatex + '\n');
