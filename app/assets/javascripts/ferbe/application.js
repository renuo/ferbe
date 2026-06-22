import FerbeTemplate from "ferbe/elements/ferbe_template";

customElements.define("ferbe-template", FerbeTemplate);

addEventListener("ferbe:open-editor", (event) => {
  const editor = document.getElementById("ferbe-editor");
  if (editor) return;

  openEditor(event.detail);
});

function openEditor(template) {
  const params = new URLSearchParams();

  params.append("url", template.url);
  params.append("template[path]", template.filePath);
  template.renderPath.forEach((p) =>
    params.append("template[render_path][]", p),
  );

  window.location.href = `/ferbe/editor?${params.toString()}`;
}
