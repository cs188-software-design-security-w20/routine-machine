module.exports = {
  env: {
    es2021: true,
    node: true,
  },
  extends: [
    'airbnb-typescript/base',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module',
    tsconfigRootDir: __dirname,
    project: ['./tsconfig.json'],
  },
  plugins: [
    '@typescript-eslint',
  ],
  rules: {
    'import/no-cycle': 'off',
    'linebreak-style': 'off',
    '@typescript-eslint/naming-convention': 'off',
  },
};
