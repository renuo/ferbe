import { registerOpeningListener } from "ferbe/utils/editor_opener";
import { application } from "controllers/application";
import FerbeEditorController from "ferbe/controllers/ferbe_editor_controller";

registerOpeningListener();

application.register("ferbe-editor", FerbeEditorController);
