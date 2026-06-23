export function registerOpeningListener() {
  window.addEventListener("ferbe:open-editor", (event) => {
    const editor = document.getElementById("ferbe-editor");
    if (editor) return;

    openEditor(event.detail);
  });
}

function openEditor(template) {
  window.location.href = editorUrl(template);
}

export function editorUrl(template) {
  const params = new URLSearchParams();

  params.append("url", template.url);
  params.append("template[path]", template.filePath);
  template.renderPath.forEach((p) =>
    params.append("template[render_path][]", p),
  );

  return `/ferbe/template/edit?${params.toString()}`;
}
