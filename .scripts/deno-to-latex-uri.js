const latex = Deno.args[0];

async function writeStdStream(str, stream = Deno.stdout) {
  return stream.write(new TextEncoder().encode(str));
}

if (latex === undefined || typeof latex !== 'string') {
  const errMsg = 'Invalid argument';
  writeStdStream(errMsg, Deno.stderr);
  Deno.exit(1);
}

const encodedLatex = encodeURI(latex);

writeStdStream(encodedLatex + '\n');
