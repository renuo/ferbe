export default class FerbeTemplate extends HTMLElement {
  connectedCallback() {
    this.modifierKey = this.#getMetaContent("ferbe:modifier-key") || "alt";
    this.useLocalEditor =
      this.#getMetaContent("ferbe:use-local-editor") === "true";

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
    window.top.dispatchEvent(
      new CustomEvent("ferbe:open-editor", {
        detail: {
          url: window.location.toString(),
          filePath: this.getAttribute("path"),
          renderPath: this.#getRenderPath(),
        },
      }),
    );
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

  #getMetaContent(name) {
    const meta = document.head.querySelector(`meta[name="${name}"]`);
    return meta ? meta.content : null;
  }
}
