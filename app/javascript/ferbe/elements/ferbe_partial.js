export default class FerbePartial extends HTMLElement {
  constructor() {
    super();
  }

  connectedCallback() {
    const editor = document.getElementById("ferbe-editor");
    this.modifierKey = editor?.dataset?.modifierKey || "alt";

    this.path = this.getAttribute("path");
    this.fullPath = this.getAttribute("full-path");

    this.onclick = (event) => {
      event.stopPropagation();
      if (!this.#isModifierKeyPressed(event)) return;

      document.dispatchEvent(
        new CustomEvent("ferbe-open-editor", {
          detail: {
            fullPath: this.fullPath,
            path: this.path,
          },
        }),
      );
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
}
