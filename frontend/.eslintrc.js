module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  parserOptions: {
    parser: '@babel/eslint-parser',
    requireConfigFile: false,
  },
  extends: [
    '@nuxtjs',
  ],
  rules: {
    'comma-dangle': ['error', 'always-multiline'],
  },
}
