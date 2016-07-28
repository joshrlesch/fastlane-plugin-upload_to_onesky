module Fastlane
  module Actions
    class UploadToOneskyAction < Action
      def self.run(params)
        UI.message("The upload_to_onesky plugin is working!")
      end

      def self.description
        "Upload a strings file to OneSky"
      end

      def self.authors
        ["joshrlesch"]
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "UPLOAD_TO_ONESKY_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
