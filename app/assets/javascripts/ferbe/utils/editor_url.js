export default function editorUrl(template) {
  const params = new URLSearchParams([
    ["url", template.url],
    ["template[path]", template.filePath],
    ...template.renderPath.map((p) => ["template[render_path][]", p]),
  ]);

  return `/ferbe/template/edit?${params.toString()}`;
}
