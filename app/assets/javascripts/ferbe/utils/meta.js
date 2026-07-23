export function getMetaContent(name, defaultValue = null) {
  const meta = document.head.querySelector(`meta[name="${name}"]`);
  return meta ? meta.content : defaultValue;
}

export function getRequiredMetaContent(name) {
  const content = getMetaContent(name);
  if (content === null) {
    throw new Error(`Required meta tag "${name}" not found`);
  }
  return content;
}
