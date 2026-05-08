export default class FerbePartial extends HTMLElement {
  constructor() {
    super();
  }

  connectedCallback() {
    const editor = document.getElementById("ferbe-editor");
    this.modifierKey = editor?.dataset?.modifierKey || "alt";

    this.onclick = async (event) => {
      event.stopPropagation();
      if (!this.#isModifierKeyPressed(event)) return;

      this.#openInEditor();
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
    const fullPath = this.getAttribute("full-path");

    fetch(`/ferbe/partial/edit?partial[path]=${fullPath}`, {
      headers: { Accept: "text/vnd.turbo-stream.html" },
    })
      .then((r) => r.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }
}
