module JanDoe
  module AiRender
    EXTENSION = SketchupExtension.new(
      "JD AI Render", "jd_ai_render/main"
    )
    EXTENSION.creator     = "Jane Doe"
    EXTENSION.description = "Creates AI renderings of your SketchUp model."
    EXTENSION.version     = "1.0.0"
    EXTENSION.copyright   = "2026 Jane Doe"
    Sketchup.register_extension(EXTENSION, true)
  end
end