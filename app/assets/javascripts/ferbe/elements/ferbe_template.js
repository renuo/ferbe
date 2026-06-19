export default class FerbeTemplate extends HTMLElement {
  connectedCallback() {
    const editor = document.getElementById("ferbe-editor");
    this.modifierKey = editor?.dataset?.modifierKey || "alt";
    this.useLocalEditor = editor?.dataset?.useLocalEditor === "true";

    this.open = this.useLocalEditor
      ? this.#openInLocalEditor
      : this.#openInEditor;

    this.onclick = async (event) => {
      event.stopPropagation();
      if (this.#isModifierKeyPressed(event)) this.open();
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

  #openInLocalEditor() {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    fetch("/ferbe/template/edit_locally", {
      method: "POST",
      headers: {
        "Content-type": "application/json; charset=UTF-8",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({
        template: {
          path: this.getAttribute("path"),
        },
      }),
    });
  }

  #openInEditor() {
    const path = this.getAttribute("path");
    const renderPath = this.#getRenderPath();

    const params = new URLSearchParams();
    params.append("url", window.location.toString())
    params.append("template[path]", path);
    renderPath.forEach((p) => params.append("template[render_path][]", p));

    window.parent.location.href = `/ferbe/editor?${params.toString()}`;

    // fetch(`/ferbe/editor?${params.toString()}`, {
    //   headers: { Accept: "text/vnd.turbo-stream.html" },
    // })
    //   .then((r) => r.text())
    //   .then((html) => Turbo.renderStreamMessage(html))
    //   .catch((err) => console.error("Failed to open editor:", err));
  }

  #getRenderPath() {
    let renderPath = [];
    let element = this;

    while (element) {
      if (element.tagName === "FERBE-TEMPLATE") {
        renderPath.unshift(element.getAttribute("path"));
      }
      element = element.parentNode;
    }

    return renderPath;
  }
}
