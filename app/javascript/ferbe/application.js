import FerbePartial from "ferbe/elements/ferbe_partial";

customElements.define("ferbe-partial", FerbePartial);

// TODO: Remove when editor is implemented
document.addEventListener("ferbe:open-editor", (event) => {
  console.log(event);
});
