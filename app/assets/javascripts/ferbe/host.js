import FerbeTemplate from "ferbe/elements/ferbe_template";
import { editorUrl } from "ferbe/utils/editor";

customElements.define("ferbe-template", FerbeTemplate);

addEventListener("ferbe:open-editor", (event) => {
  const editor = document.getElementById("ferbe-editor");
  if (editor) return;

  const template = event.detail;
  window.location.href = editorUrl(template);
});
