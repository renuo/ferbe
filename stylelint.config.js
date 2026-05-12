/** @type {import('stylelint').Config} */
export default {
  extends: "stylelint-config-standard",
  ignoreFiles: ["app/assets/stylesheets/ferbe/highlight.css"],
  rules: {
    "selector-class-pattern": [
      "^[a-z]([a-z0-9-]+)?(__([a-z0-9-]+))?(--([a-z0-9-]+))?$",
      {
        resolveNestedSelectors: true,
        message:
          "Expected class selector to be BEM adjacent (block__element--modifier)",
      },
    ],
  },
};
