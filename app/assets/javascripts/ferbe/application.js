import FerbeTemplate from "ferbe/elements/ferbe_template";
import { editorUrl } from "ferbe/utils";

customElements.define("ferbe-template", FerbeTemplate);

addEventListener("ferbe:open-editor", (event) => {
  const editor = document.getElementById("ferbe-editor");
  if (editor) return;

  openEditor(event.detail);
});

function openEditor(template) {
  window.location.href = editorUrl(template);
}
