export default class FerbePartial extends HTMLElement {
  connectedCallback() {
    const editor = document.getElementById("ferbe-editor");
    this.modifierKey = editor?.dataset?.modifierKey || "alt";

    this.onclick = async (event) => {
      event.stopPropagation();
      if (this.#isModifierKeyPressed(event)) this.#openInEditor();
    };
  }

  #isModifierKeyPressed(event) {
    const modifierKeys = {
      alt: event.altKey,
      ctrl: event.ctrlKey,
      shift: event.shiftKey,
      "ctrl/cmd": event.ctrlKey || event.metaKey,
    };

    return !!modifierKeys[this.modifierKey];
  }

  #openInEditor() {
    const path = this.getAttribute("path");
    const renderPath = this.#getRenderPath();

    const params = new URLSearchParams();
    params.append("partial[path]", path);

    if (Array.isArray(renderPath)) {
      renderPath.forEach((p) => params.append("partial[render_path][]", p));
    } else {
      params.append("partial[render_path]", renderPath);
    }

    fetch(`/ferbe/partial/edit?${params.toString()}`, {
      headers: { Accept: "text/vnd.turbo-stream.html" },
    })
      .then((r) => r.text())
      .then((html) => Turbo.renderStreamMessage(html))
      .catch((err) => console.error("Failed to open editor:", err));
  }

  #getRenderPath() {
    let renderPath = [];
    let element = this;

    while (element) {
      if (element.tagName === "FERBE-PARTIAL") {
        renderPath.unshift(element.getAttribute("path"));
      }
      element = element.parentNode;
    }

    return renderPath;
  }
}
