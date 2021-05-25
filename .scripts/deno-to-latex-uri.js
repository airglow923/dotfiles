const latex = Deno.args[0];
const latexRenderer = 'https://latex.codecogs.com/svg.latex?';

if (latex === undefined || typeof latex !== 'string') {
  const errMsg = 'Invalid argument';
  writeStdStream(errMsg, Deno.stderr);
  Deno.exit(1);
}

async function writeStdStream(str, stream = Deno.stdout) {
  return stream.write(new TextEncoder().encode(str));
}

function asciiToUTF(str) {
  str = str.replace(/\(/g, '%28');
  str = str.replace(/\)/g, '%29');

  return str;
}

const encodedLatex = encodeURI(latex);
const normalizedLatex = asciiToUTF(encodedLatex);

writeStdStream(latexRenderer + normalizedLatex + '\n');
