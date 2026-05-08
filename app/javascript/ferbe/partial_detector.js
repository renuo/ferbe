export default class PartialDetector {
  editor =  document.getElementById("ferbe-editor");
  modifierKey = this.editor?.dataset?.modifierKey || "alt";

  registerListener() {
    document.addEventListener("click", (event) => {
      if (this.#isModifierKeyPressed(event)) {
        console.log("Pressed");
      }
    });
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
