import { Controller } from "@hotwired/stimulus";
import { CodeJar } from "codejar";
import hljs from "highlight.js/lib/core";
import erb from "highlight.js/lib/languages/erb";
import xml from "highlight.js/lib/languages/xml";
import ruby from "highlight.js/lib/languages/ruby";

export default class FerbeEditorController extends Controller {
  static targets = ["editor", "form", "input"];

  connect() {
    this.#setupHighlighting();
    this.#highlight(this.editorTarget);
    this.#preventUnsavedClosing();
  }

  disconnect() {
    this.jar.destroy();
    window.onbeforeunload = null;
  }

  close() {
    this.element.remove();
  }

  save() {
    this.formTarget.requestSubmit();
  }

  #hasUnsavedChanges() {
    return this.originalContent !== this.inputTarget.value;
  }

  #setupHighlighting() {
    hljs.registerLanguage("xml", xml);
    hljs.registerLanguage("ruby", ruby);
    hljs.registerLanguage("erb", erb);

    this.originalContent = this.inputTarget.value;
    this.jar = CodeJar(this.editorTarget, this.#highlight, { tab: "  " });

    this.jar.onUpdate((code) => {
      this.inputTarget.value = code;
    });
  }

  #highlight(editor) {
    const code = editor.textContent;
    const result = hljs.highlight(code, { language: "erb" });
    editor.innerHTML = result.value;
  }

  #preventUnsavedClosing() {
    window.onbeforeunload = () => {
      if (this.#hasUnsavedChanges())
        return "There are unsaved changes in the ferbe editor.";
    };
  }
}
