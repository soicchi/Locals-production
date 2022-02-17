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
    "vue/multi-word-component-names": ["error", {
      "ignores": [
        'Modal',
        'default',
        'error',
        'signin',
        'signup',
        'index',
        'email',
        'reset',
        'all',
        'bookmark',
        'create',
        'followers',
        'following',
        'edit',
        'password',
        'Footer',
      ]
    }]
  },
}
