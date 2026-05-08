export default class FerbePartial extends HTMLElement {

  constructor() {
    super();
  }

  connectedCallback() {
    const editor = document.getElementById("ferbe-editor");
    this.modifierKey = editor?.dataset?.modifierKey || "alt";

    this.onclick = (event) => {
      if (this.#isModifierKeyPressed(event)) {
        event.stopPropagation();
        this.querySelector("&> *").style.backgroundColor = "#" + ((1 << 24) * Math.random() | 0).toString(16).padStart(6, "0");
      }
    }
  }

  #isModifierKeyPressed(event) {
    const modifierKeys = {
      "alt": event.altKey,
      "ctrl": event.ctrlKey,
      "shift": event.shiftKey,
      "ctrl/cmd": event.ctrlKey || event.metaKey
    };

    return !!modifierKeys[this.modifierKey];
  }
}
