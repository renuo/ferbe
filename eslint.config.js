import js from "@eslint/js";
import globals from "globals";
import { defineConfig } from "eslint/config";
import eslintConfigPrettier from "eslint-config-prettier";

export default defineConfig([
  js.configs.recommended,
  {
    files: ["app/assets/javascripts/**/*.js"],
    languageOptions: {
      globals: {
        ...globals.browser,
        Turbo: "readonly",
      },
    },
  },
  eslintConfigPrettier,
]);
