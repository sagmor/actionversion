require 'spec_helper'
require 'fixtures/numbers'

describe ActionVersion::Versionable do

  describe "#version" do

    describe "geting versions" do

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

    describe "defining versions" do
      it "performs the given block inside of the new class context" do
        klass = Class.new{ include ActionVersion::Versionable }

        klass.version(123) do
          def some_method
            "hello world!"
          end
        end

        instance = klass.version(123).new

        expect(instance).to respond_to :some_method
        expect(instance.some_method).to be_eql "hello world!"
      end

      it "builds versions by subclassing the base" do
        klass = Class.new{ include ActionVersion::Versionable }
        klass.version(123) { }

        expect(klass.version(123).superclass).to be_equal klass
      end

      it "can build versions with a custom superclass" do
        klass = Class.new{ include ActionVersion::Versionable }
        klass.version(123, parent: Object) { }

        expect(klass.version(123).superclass).not_to be_equal klass
        expect(klass.version(123).superclass).to be_equal Object
      end

      it "defines version constants with a preaty name to ease development" do
        expect(NumbersFixture.version(10).inspect).to be_eql("NumbersFixture::V10")

        klass = Class.new{ include ActionVersion::Versionable }
        klass.version(123) { }

        expect(klass).to be_const_defined "V123"
        expect(klass::V123).to be_equal klass.version(123)
      end

    end

  end

  describe "#versioned?" do

    it "returns true if class has at least one version" do
      expect(NumbersFixture).to be_versioned
    end

    it "returns false if it's a subclass" do
      expect(Class.new(NumbersFixture)).not_to be_versioned
    end

    it "returns false if it's a version" do
      expect(NumbersFixture.version(10)).not_to be_versioned
    end

    it "returns false if class has no version defined" do
      expect(Class.new{ include ActionVersion::Versionable }).not_to be_versioned
    end

  end

end
