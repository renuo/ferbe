// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import FerbeEditorController from "ferbe/controllers/ferbe_editor_controller";
eagerLoadControllersFrom("controllers", application);
application.register("ferbe-editor", FerbeEditorController);
