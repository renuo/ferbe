import { getMetaContent } from "ferbe/utils/meta";

export function editorUrl(template) {
  const params = new URLSearchParams([
    ["url", template.url],
    ["template[path]", template.filePath],
    ...template.renderPath.map((p) => ["template[render_path][]", p]),
  ]);

  return `${getMetaContent("ferbe:mount-path")}/template/edit?${params.toString()}`;
}
