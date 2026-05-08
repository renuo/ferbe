import FerbePartial from "ferbe/elements/ferbe_partial";

customElements.define("ferbe-partial", FerbePartial);
document.addEventListener("ferbe-open-editor", (event) => {
  console.log(event);
});
