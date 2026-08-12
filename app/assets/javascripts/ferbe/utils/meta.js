export function getMetaContent(name, defaultValue = null) {
  const meta = document.head.querySelector(`meta[name="${name}"]`);
  return meta ? meta.content : defaultValue;
}
