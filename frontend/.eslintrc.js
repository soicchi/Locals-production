module.exports = {
  root: true,
  parserOptions: {
    parser: '@babel/eslint-parser',
    requireConfigFile: false,
    sourceType: 'module',
  },
  extends: [
    '@nuxtjs',
  ],
  rules: {
    'comma-dangle': ['error', 'always-multiline'],
  },
}
