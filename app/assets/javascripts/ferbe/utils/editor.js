import { getMetaContent } from "ferbe/utils/meta";

export function editorUrl(template) {
  const params = new URLSearchParams([
    ["url", template.url],
    ["template[path]", template.filePath],
    ...template.renderPath.map((p) => ["template[render_path][]", p]),
  ]);
  const mountPath = getMetaContent("ferbe:mount-path", "/ferbe");

  return `${mountPath}/template/edit?${params.toString()}`;
}
