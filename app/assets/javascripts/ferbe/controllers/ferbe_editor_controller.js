import { Controller } from "@hotwired/stimulus";
import { CodeJar } from "codejar";
import hljs from "highlight.js/lib/core";
import erb from "highlight.js/lib/languages/erb";
import xml from "highlight.js/lib/languages/xml";
import ruby from "highlight.js/lib/languages/ruby";

hljs.registerLanguage("xml", xml);
hljs.registerLanguage("ruby", ruby);
hljs.registerLanguage("erb", erb);

export default class FerbeEditorController extends Controller {
  static targets = ["editor", "input"];

  connect() {
    this.jar = CodeJar(this.editorTarget, this.#highlight, { tab: "  " });

    this.jar.onUpdate((code) => {
      this.inputTarget.value = code;
    });

    this.#highlight(this.editorTarget);
  }

  disconnect() {
    this.jar.destroy();
  }

  close() {
    this.element.remove();
  }

  #highlight(editor) {
    const code = editor.textContent;
    const result = hljs.highlight(code, { language: "erb" });
    editor.innerHTML = result.value;
  }
}
