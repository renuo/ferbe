# Ferbe

**F**aster **ERB** Partial **E**diting

An in-browser split view editor to quickly…
- … see what code generated an HTML element
- … edit the code behind your partials
- … see and navigate the render path to a partial

>[!NOTE]
> Ferbe can also be configured to open the partials in any local editor

## Usage

To open a partial in the editor, press your modifier key (`alt/option` by default) and click on any element on your page that is inside a partial.
If not configured differently this will open a split view editor in your browser.

### Editor
#### Render Path
On the top of the editor you will see the render path navigator. Here you see all the parent partials of the currently selected one.
It can be navigated. The originally selected partial will stay at the bottom.

#### Code Editor
Below the render path navigator you'll find the actual code editor.
Here, you can make any changes to the selected partial.
To save the changes press `ctrl/cmd + s` or press the save button below.
To cancel the changes, press `ctrl/cmd + z`, close the editor with the X on the top left or simply select a different partial.

When saving changes, the actual file on your disk is overwritten.

### Error Handling
If the changes you made lead to an error, the page will not fully reload and keep displaying the old output.
An error message is displayed in the editor containing a link to see the curent page with errors.

### Configuration
You can configure three parameters in the `app/config/initializers/ferbe.rb`:

Enable or disable the gem (default: `true`):
```rb
config.enabled = true # or false
```

Set the modifier key used to open the editor.
The default is "alt" will be the `option` key on a Mac.

```rb
config.modifier_key = "alt" # or "ctrl", "shift", "ctrl/cmd"
```

Change, if the partials should be opened in a local editor instead.
It will open it in the editor set in your `EDITOR` environment variable.
The default is `false`.

```rb  
config.use_local_editor = false # or true  
```  

## Installation
>[!NOTE]
> This guide assumes that you use ferbe on a standard rails 8.1 app that aalready has stimulus and importmap set up.

Add this line to your application's Gemfile:

```ruby
gem "ferbe", github: "renuo/ferbe", branch: "develop"
```

And execute:

```bash
$ bundle install
```

Now run the following to mount the engine and add the initializer:

```bash  
$ rails generate ferbe:install  
```  

### Layout

In your layout, add these in the head section:

```erb
  <%= ferbe_styles_tag %>
  <%= ferbe_javascript_tag %>
```

Add the `ferbe_editor_tag` and wrap everything in an element with the `ferbe__page` class.

```erb
<div class="ferbe__page">
  <main>
    <%= yield %>
  </main>

<%= ferbe_editor_tag %>
</div>
```

### Add the Stimulus controller
The final step is to add the provided Stimulus controller to your `javascript/controllers/index.js`:

```js
import FerbeEditorController from "ferbe/controllers/ferbe_editor_controller";
// ...
application.register("ferbe-editor", FerbeEditorController);
```

---

Copyright 2026 by Renuo AG
