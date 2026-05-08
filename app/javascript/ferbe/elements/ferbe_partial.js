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

    fetch(`/ferbe/partial/edit?partial[path]=${path}`, {
      headers: { Accept: "text/vnd.turbo-stream.html" },
    })
      .then((r) => r.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }
}
