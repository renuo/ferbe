export default function editorUrl(template) {
  const params = new URLSearchParams();

  params.append("url", template.url);
  params.append("template[path]", template.filePath);
  template.renderPath.forEach((p) =>
    params.append("template[render_path][]", p),
  );

  return `/ferbe/template/edit?${params.toString()}`;
}
