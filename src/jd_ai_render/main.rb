require "base64"
require "json"

module JanDoe
  module AiRender
    def self.show
      @dialog ||= self.create_dialog

      # Action callbacks need to be readded each time the dialog is shown.
      @dialog.add_action_callback("start_render") { start_render }

      # If the dialog is already visible, trying to show it again brings it to
      # the front.
      @dialog.visible? ? @dialog.bring_to_front : @dialog.show
    end

    def self.create_dialog
      dialog = UI::HtmlDialog.new(
        preferences_key: EXTENSION.name,
        width: 600,
        height: 400
      )

      # In a real web based extension you'd display your own web page in the
      # html dialog.
      ### dialog.set_url("https://yourwebsite.com?extensionVersion=#{EXTENSION.version}")

      # It's also useful to send the extension version along with the request
      # so you can disable the service with an update notification if the
      # client extension is outdated.

      # For this example a file shipped with the extension is used.
      dialog.set_file("#{__dir__}/web_server.html")

      dialog
    end

    def self.start_render
      # A typical AI render extension takes a screenshot of the model to send to
      # the server.
      temp_file = "#{Sketchup.temp_dir}/#{Time.now.to_i}_#{rand(255)}.png"
      Sketchup.active_model.active_view.write_image(temp_file)
      data = File.binread(temp_file)
      File.delete(temp_file)
      
      # An energy analysis service, exporter or conventional renderer could
      # instead use a copy of the model.
      ### temp_file = "#{Sketchup.temp_dir}/#{Time.now.to_i}_#{rand(255)}.skp"
      ### Sketchup.active_model.save_copy(temp_file)
      ### data = File.binread(temp_file)
      ### File.delete(temp_file)
      
      # One way to get the data to the server is to send it as a base64 string
      # to the html dialog.
      @dialog.execute_script("uploadScreenshot(#{Base64.encode64(data).to_json})")
      
      # The file can also be sent to the server using Sketchup::Http.
    end

    # Load guard to only add menu entry once even if the code reloads
    unless @loaded
      @loaded = true

      command = UI::Command.new(EXTENSION.name) { show }
      command.status_bar_text = EXTENSION.description

      menu = UI.menu("Extensions")
      menu.add_item(command)
    end
  end
end