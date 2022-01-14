module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    "plugin:vue/vue3-recommended",
    "eslint:recommended",
    "@vue/typescript/recommended",
    "@vue/prettier",
    "@vue/eslint-config-prettier",
  ],
  parserOptions: {
    ecmaVersion: 2021,
  },
  rules: {
    "no-console": "warn",
    "no-debugger": "warn",
    "@typescript-eslint/interface-name-prefix": "off",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/explicit-module-boundary-types": "off",
    "@typescript-eslint/no-non-null-assertion": "off",
    "@typescript-eslint/no-explicit-any": "warn",
    "prettier/prettier": ["error", {}, { usePrettierrc: true }],
    "no-unused-vars": "off",
    "@typescript-eslint/no-unused-vars": "warn",
    "vue/script-setup-uses-vars": "warn",
    "vue/no-unused-properties": [
      "warn",
      {
        groups: ["props", "setup"],
        deepData: true,
      },
    ],
  },
};
