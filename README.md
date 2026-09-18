# Web Based Extension Example

A web based SketchUp extension is an extension with a thin Ruby wrapper for
displaying a web page, while most of the heavy lifting is done on your server.
A typical example is an AI rendering or energy analysis but it could also be a
product catalog or an exporter.

This architecture comes with better protection of your intellectual property
as much of the code doesn't have to run on the user's machine. It is also harder
to pirate as you can do license checks server side, out of the user's reach.

This example shows how an AI renderer could act on a screenshot of the model but
the full 3D model file could also be sent to the server for more advanced
analysis.

This simplified example uses a local html file but a real web based extension
would connect to your own server.

## Loading into SketchUp

To load the extension from source into SketchUp, you can run this script in
the SketchUp Ruby console, or place it in your SketchUp Plugins folder to run
each time SketchUp is launched.

```ruby
path = "C:/Users/Jane Doe/SketchUp Extensions/web-based-extension/src"
$LOAD_PATH << path
Dir.glob("#{path}/*.rb").each { |p| require p }
```

Replace the path with the location you clone this repository to.

To reload, you can use this snippet in the Ruby console.

```ruby
path = "C:/Users/Jane Doe/SketchUp Extensions/web-based-extension/src"
Dir.glob("#{path}/**/*.rb").each { |p| load p }
```

Again, replace the path with the actual file location.

Alternatively, you can use [ThomThom's Extension Sources](https://extensions.sketchup.com/extension/a9f18009-29cc-4c43-a0a7-e018e7a6563b/extension-sources).

## Building

Zip the content of the `src/` folder and change the file extension to `.rbz`.
