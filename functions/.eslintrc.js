module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    "quotes": ["error", "double"],
    "max-len": ["error", {"code": 120}],
    "linebreak-style": ["error", "windows"],
  },
  parserOptions: {
    ecmaVersion: 8, // or 2017,
  },
};
