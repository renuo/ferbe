# Ferbe

**F**aster **ERB** Template **E**diting

An in-browser split view editor to quickly…

- … see what code generated an HTML element
- … edit the code behind your templates
- … see and navigate the render path to a template

> [!NOTE]
> Ferbe can also be configured to open the templates in any local editor

## Demo

https://github.com/user-attachments/assets/a21e2e19-02ce-426c-882d-d07a637b13a0

## Usage

To open a template in the editor, press your modifier key (`alt/option` by default) and click on any element on your page.
If not configured differently this will open a split view editor in your browser.

### Editor

#### Render Path

On the top of the editor you will see the render path navigator. Here you see all the parent templates of the currently selected one.
It can be navigated. The originally selected template will stay at the bottom.

#### Code Editor

Below the render path navigator you'll find the actual code editor.
Here, you can make any changes to the selected template.
To save the changes press `ctrl/cmd + s` or press the save button below.
To cancel the changes, press `ctrl/cmd + z`, close the editor with the X on the top left or simply select a different template.

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
The default "alt" will be the `option` key on a Mac.

```rb
config.modifier_key = "alt" # or "ctrl", "shift", "ctrl/cmd"
```

Change, if the templates should be opened in a local editor instead.
It will open it in the editor set in your `EDITOR` environment variable.
The default is `false`.

```rb
config.use_local_editor = false # or true
```

## Limitations

Opening the editor opens a new page that displays the original page inside an iframe. This results in the following limitations:

- As shown on the "Cards" page, when deleting a card, pages that can only be viewed once cannot be opened in the editor. 
- But even if this wasn't the case, views returned by non-`GET` requests cannot be displayed.
- Controller actions must be idempotent. If a given URL can return different pages, the page displayed in the editor may differ from the one that was originally selected and is being edited. In the dummy app, this is shown by the "Surprise" page that is different on every third visit.

## Installation

> [!NOTE]
> This guide assumes that you use ferbe on a standard rails 8.0/8.1 app that already has stimulus and importmap set up.

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

Now, in your layout, add these in the head section:

```erb
  <%= ferbe_styles_tag %>
  <%= ferbe_javascript_tag %>
```

---

Copyright 2026 by Renuo AG
