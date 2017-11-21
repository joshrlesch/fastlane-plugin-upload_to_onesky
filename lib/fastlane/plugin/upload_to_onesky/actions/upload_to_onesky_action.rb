module Fastlane
  module Actions
    class UploadToOneskyAction < Action
      def self.run(params)
        require 'rest-client'

        file_path = File.expand_path(params[:strings_file_path])

        file = File.new(file_path, 'rt')

        request_params = {
            content_type: :json,
            params: self.auth_hash(params[:public_key], params[:secret_key])

        }

        UI.success 'Starting the upload to OneSky'
        url = "https://platform.api.onesky.io/1/projects/#{params[:project_id]}/files"

        body_hash = {
            file: file,
            file_format: params[:strings_file_format],
            multipart: true
        }

        # True by default on onesky file upload
        # https://github.com/onesky/api-documentation-platform/blob/master/resources/file.md#upload---upload-a-file
        unless params[:is_keeping_all_strings]
          body_hash[:is_keeping_all_strings] = false
        end

        # False by default on onesky file upload
        # https://github.com/onesky/api-documentation-platform/blob/master/resources/file.md#upload---upload-a-file
        if params[:is_allow_translation_same_as_original]
          body_hash[:is_allow_translation_same_as_original] = true
        end

        resp = RestClient.post(url,
                               body_hash,
                               request_params)

        if resp.code == 201
          UI.success "#{File.basename params[:strings_file_path]} was successfully uploaded to project #{params[:project_id]} in OneSky"
        else
          UI.error "Error uploading file to OneSky, Status code is #{resp.code}"
        end
      end

      def self.auth_hash(api_key, secret_key)
        now = Time.now.to_i

        {
            api_key: api_key,
            timestamp: now,
            dev_hash: Digest::MD5.hexdigest(now.to_s + secret_key)
        }
      end

      def self.description
        'Upload a strings file to OneSky'
      end

      def self.authors
        ['JMoravec', 'joshrlesch']
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :public_key,
                                       env_name: 'ONESKY_PUBLIC_KEY',
                                       description: 'Public key for OneSky',
                                       is_string: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         raise "No Public Key for OneSky given, pass using `public_key: 'token'`".red unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :secret_key,
                                       env_name: 'ONESKY_SECRET_KEY',
                                       description: 'Secret Key for OneSky',
                                       is_string: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         raise "No Secret Key for OneSky given, pass using `secret_key: 'token'`".red unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :project_id,
                                       env_name: 'ONESKY_PROJECT_ID',
                                       description: 'Project Id to upload file to',
                                       optional: false,
                                       verify_block: proc do |value|
                                         raise 'No project id given'.red unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :strings_file_path,
                                       env_name: 'ONESKY_STRINGS_FILE_PATH',
                                       description: 'Base file path for the strings file to upload',
                                       is_string: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         raise "Couldn't find file at path '#{value}'".red unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :strings_file_format,
                                       env_name: 'ONESKY_STRINGS_FORMAT',
                                       description: 'Format of the strings file: see https://github.com/onesky/api-documentation-platform/blob/master/reference/format.md',
                                       is_string: true,
                                       optional: false,
                                       verify_block: proc do |value|
                                         raise 'No file format given'.red unless (value and not value.empty?)
                                       end),
          FastlaneCore::ConfigItem.new(key: :is_keeping_all_strings,
                                      env_name: 'IS_KEEPING_ALL_STRINGS',
                                      description: 'Deprecate strings if not found in newly uploaded file',
                                      is_string: false,
                                      optional: true,
                                      default_value: true),
          FastlaneCore::ConfigItem.new(key: :is_allow_translation_same_as_original,
                                      env_name: 'IS_ALLOW_TRANSLATION_SAME_AS_ARIGINAL',
                                      description: 'Skip importing translations that are the same as source text',
                                      is_string: false,
                                      optional: true,
                                      default_value: false)
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
