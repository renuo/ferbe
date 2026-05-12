import { Controller } from "@hotwired/stimulus";
import { CodeJar } from "codejar";
import hljs from "highlight.js/lib/core";
import erb from "highlight.js/lib/languages/erb";
import xml from "highlight.js/lib/languages/xml";
import ruby from "highlight.js/lib/languages/ruby";

export default class FerbeEditorController extends Controller {
  static targets = ["editor", "form", "input", "errorContainer"];

  connect() {
    this.#setupHighlighting();
    this.#highlight(this.editorTarget);
    this.#preventUnsavedClosing();
    this.#setupErrorHandling();
  }

  disconnect() {
    this.jar.destroy();
    window.onbeforeunload = null;
    this.errorContainerTarget.innerHTML = "";
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

  #setupErrorHandling() {
    addEventListener("turbo:before-fetch-response", (event) => {
      const response = event.detail.fetchResponse;
      if (response.statusCode !== 500) return;

      event.preventDefault();
      document.documentElement.removeAttribute("aria-busy");
      this.#displayError({
        message: `${response.statusCode} ${response.response.statusText}`,
        url: response.response.url
      });
    });
  }

  #displayError({message, url}) {
    this.errorContainerTarget.innerHTML =
`<strong>There is an error that was likely caused by your edit:</strong>
${message}
<a href="${url}" target="_blank">Open in new tab</a>`;
  }
}
