require 'spec_helper'
require 'fixtures/numbers'

describe ActionVersion::Versionable do

  describe "#version" do

    it "returns the requested version" do
      expect(NumbersFixture.version(10).new.version).to be_equal(10)
      expect(NumbersFixture.version(20).new.version).to be_equal(20)
      expect(NumbersFixture.version(30).new.version).to be_equal(30)
    end

    it "raises error when requested a version lower than the available ones" do
      expect{ NumbersFixture.version(5) }.to raise_error
    end

    it "returns the lower version number available" do
      expect(NumbersFixture.version(14).new.version).to be_equal(10)
      expect(NumbersFixture.version(27).new.version).to be_equal(20)
      expect(NumbersFixture.version(100).new.version).to be_equal(30)
    end

  end

  describe "#versioned?" do

    it "returns true if class has at least one version" do
      expect(NumbersFixture).to be_versioned
    end

    it "returns false if it's a subclass" do
      expect(Class.new(NumbersFixture)).not_to be_versioned
    end

    it "returns false if class has no version defined" do
      expect(Class.new{ include ActionVersion::Versionable }).not_to be_versioned
    end

  end

end
