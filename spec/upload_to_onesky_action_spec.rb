describe Fastlane::Actions::UploadToOneskyAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The upload_to_onesky plugin is working!")

      Fastlane::Actions::UploadToOneskyAction.run(nil)
    end
  end
end
